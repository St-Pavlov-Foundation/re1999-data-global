-- chunkname: @modules/logic/versionactivity2_7/act191/model/Act191MatchMO.lua

module("modules.logic.versionactivity2_7.act191.model.Act191MatchMO", package.seeall)

local Act191MatchMO = pureTable("Act191MatchMO")

function Act191MatchMO:init(info)
	self.uid = info.uid
	self.rank = info.rank
	self.robot = info.robot
	self.playerUid = info.playerUid
	self.heroMap = info.heroMap
	self.subHeroMap = info.subHeroMap

	self:updateEnhance(info.enhanceSet)

	self.wareHouseInfo = info.warehouseInfo
end

function Act191MatchMO:updateEnhance(enhanceIdList)
	self.enhanceSet = enhanceIdList

	local actId = Activity191Model.instance:getCurActId()

	self.heroId2ExtraFetterMap = {}

	for _, enhanceId in ipairs(self.enhanceSet) do
		local enhanceCo = Activity191Config.instance:getEnhanceCo(actId, enhanceId)
		local effectIds = string.splitToNumber(enhanceCo.effects, "|")

		for _, effectId in ipairs(effectIds) do
			local effectCo = lua_activity191_effect.configDict[effectId]
			local params = string.split(effectCo.typeParam, "#")

			if effectCo.type == Activity191Enum.EffectType.ExtraFetter then
				local heroId = tonumber(params[1])
				local fetterTbl = self.heroId2ExtraFetterMap[heroId]

				if not fetterTbl then
					fetterTbl = {}
					self.heroId2ExtraFetterMap[heroId] = fetterTbl
				end

				table.insert(fetterTbl, params[2])
			end
		end
	end
end

function Act191MatchMO:getRoleCo(heroId)
	if self.robot then
		return Activity191Config.instance:getRoleCo(heroId)
	else
		local heroInfo = self:getHeroInfo(heroId, true)

		if heroInfo then
			return Activity191Config.instance:getRoleCoByNativeId(heroId, heroInfo.star)
		end
	end
end

function Act191MatchMO:getHeroInfo(heroId, error)
	heroId = tostring(heroId)

	local info = self.wareHouseInfo.heroInfoMap[heroId]

	if error and not info then
		logError("enemyHeroInfo not found" .. heroId)
	end

	return info
end

function Act191MatchMO:getItemCo(itemUid)
	local itemId

	if self.robot then
		itemId = itemUid
	else
		local itemInfo = self:getItemInfo(itemUid)

		itemId = itemInfo.itemId
	end

	return Activity191Config.instance:getCollectionCo(itemId)
end

function Act191MatchMO:getItemInfo(itemUid)
	itemUid = tostring(itemUid)

	local info = self.wareHouseInfo.itemInfoMap[itemUid]

	if info then
		return info
	else
		logError("enemyItemInfo not found" .. itemUid)
	end
end

function Act191MatchMO:getTeamFetterCntDic()
	local cntDic = {}

	for _, info in pairs(self.heroMap) do
		if info.heroId ~= 0 then
			local roleCo = self:getRoleCo(info.heroId)
			local fetterArr = string.split(roleCo.tag, "#")

			for _, tag in ipairs(fetterArr) do
				if cntDic[tag] then
					cntDic[tag] = cntDic[tag] + 1
				else
					cntDic[tag] = 1
				end
			end

			if info.itemUid1 ~= 0 then
				local itemCo = self:getItemCo(info.itemUid1)
				local tagStr = not string.nilorempty(itemCo.tag) and itemCo.tag or itemCo.tag2

				if not string.nilorempty(tagStr) then
					fetterArr = string.split(itemCo.tag, "#")

					for _, tag in ipairs(fetterArr) do
						if cntDic[tag] then
							cntDic[tag] = cntDic[tag] + 1
						else
							cntDic[tag] = 1
						end
					end
				end
			end

			local fetterTbl = self.heroId2ExtraFetterMap[info.heroId]

			if fetterTbl then
				for _, tag in ipairs(fetterTbl) do
					if not cntDic[tag] then
						cntDic[tag] = 1
					else
						cntDic[tag] = cntDic[tag] + 1
					end
				end
			end
		end
	end

	for _, heroId in pairs(self.subHeroMap) do
		local roleCo = self:getRoleCo(heroId)
		local fetterArr = string.split(roleCo.tag, "#")

		for _, tag in ipairs(fetterArr) do
			if cntDic[tag] then
				cntDic[tag] = cntDic[tag] + 1
			else
				cntDic[tag] = 1
			end
		end

		local fetterTbl = self.heroId2ExtraFetterMap[heroId]

		if fetterTbl then
			for _, tag in ipairs(fetterTbl) do
				if not cntDic[tag] then
					cntDic[tag] = 1
				else
					cntDic[tag] = cntDic[tag] + 1
				end
			end
		end
	end

	return cntDic
end

function Act191MatchMO:getFetterHeroList(tag)
	local actId = Activity191Model.instance:getCurActId()
	local fetterHeroList = {}
	local roleCoList = lua_activity191_role.configList

	for _, roleCo in ipairs(roleCoList) do
		local heroId = self.robot and roleCo.id or roleCo.roleId

		if roleCo.activityId == actId and roleCo.star == 1 then
			local transfer = 0
			local inBag = 0

			if self:isHeroInTeam(heroId) then
				inBag = 2
			elseif not self.robot and self:getHeroInfo(heroId) then
				inBag = 1
			end

			local fetterArr = string.split(roleCo.tag, "#")

			if tabletool.indexOf(fetterArr, tag) then
				local data = {
					config = roleCo,
					inBag = inBag,
					transfer = transfer
				}

				fetterHeroList[#fetterHeroList + 1] = data
			else
				local info = self:getBattleHeroInfoInTeam(roleCo.roleId)

				if info and info.itemUid1 ~= 0 then
					local itemCo = self:getItemCo(info.itemUid1)

					if not string.nilorempty(itemCo.tag) then
						fetterArr = string.split(itemCo.tag, "#")

						if tabletool.indexOf(fetterArr, tag) then
							local data = {
								inBag = 2,
								transfer = 1,
								config = roleCo
							}

							fetterHeroList[#fetterHeroList + 1] = data
						end
					end
				end
			end

			local fetterTbl = self.heroId2ExtraFetterMap[heroId]

			if fetterTbl and tabletool.indexOf(fetterTbl, tag) then
				local data = {
					transfer = 2,
					config = roleCo,
					inBag = inBag
				}

				fetterHeroList[#fetterHeroList + 1] = data
			end
		end
	end

	table.sort(fetterHeroList, Activity191Helper.sortFetterHeroList)

	return fetterHeroList
end

function Act191MatchMO:isHeroInTeam(heroId)
	for _, info in pairs(self.heroMap) do
		if info.heroId == heroId then
			return true
		end
	end

	for _, _heroId in pairs(self.subHeroMap) do
		if _heroId == heroId then
			return true
		end
	end
end

function Act191MatchMO:getBattleHeroInfoInTeam(heroId)
	for _, info in pairs(self.heroMap) do
		if info.heroId == heroId then
			return info
		end
	end
end

return Act191MatchMO
