-- chunkname: @modules/logic/versionactivity2_7/act191/model/Act191GameMO.lua

module("modules.logic.versionactivity2_7.act191.model.Act191GameMO", package.seeall)

local Act191GameMO = pureTable("Act191GameMO")

function Act191GameMO:init(info)
	self.actId = Activity191Model.instance:getCurActId()
	self.coin = info.coin
	self.curStage = info.curStage
	self.curNode = info.curNode
	self.nodeInfo = info.nodeInfo
	self.curTeamIndex = 1
	self.teamInfo = info.teamInfo

	self:updateWareHouseInfo(info.warehouseInfo)

	self.score = info.score
	self.state = info.state
	self.rank = info.rank
	self.rankMark = 0
	self.recordInfo = info.recordInfo
	self.initBuildInfo = info.initBuildInfo
end

function Act191GameMO:update(info)
	if self.curNode ~= info.curNode then
		self.nodeChange = true
	end

	self.coin = info.coin
	self.curStage = info.curStage
	self.curNode = info.curNode
	self.nodeInfo = info.nodeInfo
	self.teamInfo = info.teamInfo

	self:updateWareHouseInfo(info.warehouseInfo)

	self.score = info.score
	self.state = info.state

	self:updateRank(info.rank)

	self.recordInfo = info.recordInfo
	self.initBuildInfo = info.initBuildInfo
end

function Act191GameMO:updateRank(rank)
	self.rankMark = rank > self.rank and 1 or rank < self.rank and -1 or 0
	self.rank = rank
end

function Act191GameMO:updateWareHouseInfo(info)
	self.warehouseInfo = info
	self.heroId2ExtraFetterMap = {}

	for _, enhanceId in ipairs(info.enhanceId) do
		local enhanceCo = Activity191Config.instance:getEnhanceCo(self.actId, enhanceId)
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

function Act191GameMO:updateTeamInfo(teamIndex, teamInfo)
	self.curTeamIndex = teamIndex

	local isFind = false

	for k, info in ipairs(self.teamInfo) do
		if info.index == teamIndex then
			self.teamInfo[k] = teamInfo
			isFind = true

			break
		end
	end

	if not isFind then
		table.insert(self.teamInfo, teamInfo)
	end
end

function Act191GameMO:updateCurNodeInfo(nodeInfo)
	for i = 1, #self.nodeInfo do
		if self.nodeInfo[i].nodeId == self.curNode then
			self.nodeInfo[i] = nodeInfo
		end
	end
end

function Act191GameMO:getStageNodeInfoList(stageId)
	local nodeInfoList = {}

	stageId = stageId or self.curStage

	for _, info in ipairs(self.nodeInfo) do
		if info.stage == stageId then
			nodeInfoList[#nodeInfoList + 1] = info
		end
	end

	table.sort(nodeInfoList, function(a, b)
		return a.nodeId < b.nodeId
	end)

	return nodeInfoList
end

function Act191GameMO:getNodeInfoById(nodeId)
	for _, info in ipairs(self.nodeInfo) do
		if info.nodeId == nodeId then
			return info
		end
	end
end

function Act191GameMO:getNodeDetailMo(nodeId, notError)
	nodeId = nodeId or self.curNode

	local nodeInfo = self:getNodeInfoById(nodeId)

	if not nodeInfo or string.nilorempty(nodeInfo.nodeStr) then
		if not notError then
			logError("check select node" .. nodeId)
		end

		return
	end

	local mo = Act191NodeDetailMO.New()

	mo:init(nodeInfo.nodeStr)

	return mo
end

function Act191GameMO:getTeamInfo()
	local teamInfo = Activity191Helper.matchKeyInArray(self.teamInfo, self.curTeamIndex)

	if not teamInfo then
		teamInfo = Activity191Module_pb.Act191BattleTeamInfo()
		teamInfo.index = self.curTeamIndex
		teamInfo.auto = false

		table.insert(self.teamInfo, teamInfo)
	end

	return teamInfo
end

function Act191GameMO:getPreviewFetterCntDic(heroIdDic)
	local cntDic = {}
	local teamInfo = self:getTeamInfo()

	for index, heroId in pairs(heroIdDic) do
		local heroInfo = self:getHeroInfoInWarehouse(heroId)
		local roleCo = Activity191Config.instance:getRoleCoByNativeId(heroId, heroInfo.star)
		local fetterArr = string.split(roleCo.tag, "#")

		for _, tag in ipairs(fetterArr) do
			if not cntDic[tag] then
				cntDic[tag] = 1
			else
				cntDic[tag] = cntDic[tag] + 1
			end
		end

		if index <= 4 then
			local info = Activity191Helper.matchKeyInArray(teamInfo.battleHeroInfo, index)

			if info then
				local itemUid = info.itemUid1

				if itemUid ~= 0 then
					local itemInfo = self:getItemInfoInWarehouse(itemUid)
					local itemCo = Activity191Config.instance:getCollectionCo(itemInfo.itemId)
					local tagStr = not string.nilorempty(itemCo.tag) and itemCo.tag or itemCo.tag2

					if not string.nilorempty(tagStr) then
						fetterArr = string.split(tagStr, "#")

						for _, tag in ipairs(fetterArr) do
							if not cntDic[tag] then
								cntDic[tag] = 1
							else
								cntDic[tag] = cntDic[tag] + 1
							end
						end
					end
				end
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

function Act191GameMO:getTeamFetterCntDic()
	local cntDic = {}
	local teamInfo = self:getTeamInfo()

	for _, info in ipairs(teamInfo.battleHeroInfo) do
		if info.heroId ~= 0 then
			local heroInfo = self:getHeroInfoInWarehouse(info.heroId)
			local roleCo = Activity191Config.instance:getRoleCoByNativeId(info.heroId, heroInfo.star)
			local fetterArr = string.split(roleCo.tag, "#")

			for _, tag in ipairs(fetterArr) do
				if cntDic[tag] then
					cntDic[tag] = cntDic[tag] + 1
				else
					cntDic[tag] = 1
				end
			end

			if info.itemUid1 ~= 0 then
				local itemInfo = self:getItemInfoInWarehouse(info.itemUid1)
				local itemCo = Activity191Config.instance:getCollectionCo(itemInfo.itemId)
				local tagStr = not string.nilorempty(itemCo.tag) and itemCo.tag or itemCo.tag2

				if not string.nilorempty(tagStr) then
					fetterArr = string.split(tagStr, "#")

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

	for _, info in ipairs(teamInfo.subHeroInfo) do
		local heroInfo = self:getHeroInfoInWarehouse(info.heroId)
		local roleCo = Activity191Config.instance:getRoleCoByNativeId(info.heroId, heroInfo.star)
		local fetterArr = string.split(roleCo.tag, "#")

		for _, tag in ipairs(fetterArr) do
			if cntDic[tag] then
				cntDic[tag] = cntDic[tag] + 1
			else
				cntDic[tag] = 1
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

	return cntDic
end

function Act191GameMO:getFetterHeroList(tag)
	local fetterHeroList = {}
	local roleCoList = lua_activity191_role.configList

	for _, roleCo in ipairs(roleCoList) do
		local heroId = roleCo.roleId

		if roleCo.activityId == self.actId and roleCo.star == 1 then
			local transfer = 0
			local inBag = 0

			if self:isHeroInTeam(heroId) then
				inBag = 2
			elseif self:getHeroInfoInWarehouse(heroId, true) then
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
				local info = self:getBattleHeroInfoInTeam(heroId)

				if info and info.itemUid1 ~= 0 then
					local itemInfo = self:getItemInfoInWarehouse(info.itemUid1)
					local itemCo = Activity191Config.instance:getCollectionCo(itemInfo.itemId)

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

function Act191GameMO:setAutoFight(isAuto)
	local teamInfo = self:getTeamInfo()

	teamInfo.auto = isAuto

	Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)
end

function Act191GameMO:getHeroInfoInWarehouse(heroId, notError)
	local info

	for _, heroInfo in ipairs(self.warehouseInfo.hero) do
		if heroId == heroInfo.heroId then
			info = heroInfo

			break
		end
	end

	if not notError and not info then
		logError(string.format("heroId : %s, heroInfo not found", heroId))
	end

	return info
end

function Act191GameMO:getBattleHeroInfoInTeam(heroId)
	local teamInfo = self:getTeamInfo()

	for _, heroInfo in ipairs(teamInfo.battleHeroInfo) do
		if heroInfo.heroId == heroId then
			return heroInfo
		end
	end
end

function Act191GameMO:getSubHeroInfoInTeam(heroId)
	local teamInfo = self:getTeamInfo()

	for _, heroInfo in ipairs(teamInfo.subHeroInfo) do
		if heroInfo.heroId == heroId then
			return heroInfo
		end
	end
end

function Act191GameMO:isHeroInTeam(heroId, release)
	local teamInfo = self:getTeamInfo()

	for _, heroInfo in ipairs(teamInfo.battleHeroInfo) do
		if heroInfo.heroId == heroId then
			if release then
				heroInfo.heroId = 0
			end

			return true
		end
	end

	for _, heroInfo in ipairs(teamInfo.subHeroInfo) do
		if heroInfo.heroId == heroId then
			if release then
				heroInfo.heroId = 0
			end

			return true
		end
	end
end

function Act191GameMO:teamHasMainHero()
	local teamInfo = self:getTeamInfo()

	for _, info in ipairs(teamInfo.battleHeroInfo) do
		if info.heroId ~= 0 then
			return true
		end
	end

	return false
end

function Act191GameMO:saveQuickGroupInfo(index2HeroMap)
	local teamInfo = self:getTeamInfo()

	for i = 1, 4 do
		local battleHeroInfo = Activity191Helper.getWithBuildBattleHeroInfo(teamInfo.battleHeroInfo, i)

		battleHeroInfo.heroId = index2HeroMap[i] or 0

		local subHeroInfo = Activity191Helper.getWithBuildSubHeroInfo(teamInfo.subHeroInfo, i)

		subHeroInfo.heroId = index2HeroMap[i + 4] or 0
	end

	Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)
end

function Act191GameMO:replaceHeroInTeam(heroId, slotIndex)
	self:isHeroInTeam(heroId, true)

	local teamInfo = self:getTeamInfo()

	if slotIndex <= 4 then
		local battleHeroInfo = Activity191Helper.getWithBuildBattleHeroInfo(teamInfo.battleHeroInfo, slotIndex)

		battleHeroInfo.heroId = heroId
	else
		local subHeroInfo = Activity191Helper.getWithBuildSubHeroInfo(teamInfo.subHeroInfo, slotIndex - 4)

		subHeroInfo.heroId = heroId
	end

	Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)
end

function Act191GameMO:removeHeroInTeam(heroId)
	local teamInfo = self:getTeamInfo()

	for _, info in ipairs(teamInfo.battleHeroInfo) do
		if info.heroId == heroId then
			info.heroId = 0

			Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)

			return
		end
	end

	for _, info in ipairs(teamInfo.subHeroInfo) do
		if info.heroId == heroId then
			info.heroId = 0

			Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)

			return
		end
	end
end

function Act191GameMO:exchangeHero(from, to)
	local teamInfo = self:getTeamInfo()
	local fromInfo, toInfo

	if from <= 4 then
		fromInfo = Activity191Helper.getWithBuildBattleHeroInfo(teamInfo.battleHeroInfo, from)
	else
		fromInfo = Activity191Helper.getWithBuildSubHeroInfo(teamInfo.subHeroInfo, from - 4)
	end

	if to <= 4 then
		toInfo = Activity191Helper.getWithBuildBattleHeroInfo(teamInfo.battleHeroInfo, to)
	else
		toInfo = Activity191Helper.getWithBuildSubHeroInfo(teamInfo.subHeroInfo, to - 4)
	end

	local tempHeroId = fromInfo.heroId

	fromInfo.heroId = toInfo.heroId
	toInfo.heroId = tempHeroId

	Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)
end

function Act191GameMO:getItemInfoInWarehouse(itemUid)
	local info

	for _, itemInfo in ipairs(self.warehouseInfo.item) do
		if itemInfo.uid == itemUid then
			info = itemInfo

			break
		end
	end

	if not info then
		logError(string.format("itemUid : %s, itemInfo not found", itemUid))
	end

	return info
end

function Act191GameMO:isItemInTeam(itemUid)
	local teamInfo = self:getTeamInfo()

	for _, heroInfo in ipairs(teamInfo.battleHeroInfo) do
		if heroInfo.itemUid1 == itemUid then
			return true
		end
	end
end

function Act191GameMO:replaceItemInTeam(itemUid, teamPos)
	self:removeItemInTeam(itemUid)

	local teamInfo = self:getTeamInfo()
	local battleHeroInfo = Activity191Helper.getWithBuildBattleHeroInfo(teamInfo.battleHeroInfo, teamPos)

	battleHeroInfo.itemUid1 = itemUid

	Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)
end

function Act191GameMO:removeItemInTeam(itemUid)
	local remove = false
	local teamInfo = self:getTeamInfo()

	for _, info in ipairs(teamInfo.battleHeroInfo) do
		if info.itemUid1 == itemUid then
			info.itemUid1 = 0
			remove = true
		end
	end

	if remove then
		Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)
	end
end

function Act191GameMO:exchangeItem(from, to)
	local teamInfo = self:getTeamInfo()
	local fromInfo, toInfo

	fromInfo = Activity191Helper.getWithBuildBattleHeroInfo(teamInfo.battleHeroInfo, from)
	toInfo = Activity191Helper.getWithBuildBattleHeroInfo(teamInfo.battleHeroInfo, to)

	local tempUid = fromInfo.itemUid1

	fromInfo.itemUid1 = toInfo.itemUid1
	toInfo.itemUid1 = tempUid

	Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, self.curTeamIndex, teamInfo)
end

function Act191GameMO:isItemEnhance(itemId)
	if tabletool.indexOf(self.enhanceItemList, itemId) then
		return true
	end

	return false
end

function Act191GameMO:autoFill()
	local teamInfo = self:getTeamInfo()
	local itemInfos = self.warehouseInfo.item

	for k, v in ipairs(self.warehouseInfo.hero) do
		if k <= 4 then
			local battleHeroInfo = Activity191Helper.getWithBuildBattleHeroInfo(teamInfo.battleHeroInfo, k)

			battleHeroInfo.heroId = v.heroId

			if itemInfos[k] then
				battleHeroInfo.itemUid1 = itemInfos[k].uid
			end
		elseif k <= 8 then
			local subHeroInfo = Activity191Helper.getWithBuildSubHeroInfo(teamInfo.subHeroInfo, k - 4)

			subHeroInfo.heroId = v.heroId
		end
	end

	Activity191Rpc.instance:sendChangeAct191TeamRequest(self.actId, 1, teamInfo)
end

function Act191GameMO:getAct191Effect(effectId)
	for _, effect in ipairs(self.warehouseInfo.effect) do
		if effect.id == effectId then
			return effect
		end
	end
end

function Act191GameMO:getBestFetterTag()
	local fetterCntDic = self:getTeamFetterCntDic()
	local fetterInfoList = Activity191Helper.getActiveFetterInfoList(fetterCntDic)

	if next(fetterInfoList) then
		return fetterInfoList[1].config.tag
	end
end

function Act191GameMO:clearRankMark()
	self.rankMark = 0
end

function Act191GameMO:getFetterActiveLevel(tag)
	local activeLevel = 0
	local fetterCntDic = self:getTeamFetterCntDic()
	local cnt = fetterCntDic[tag]

	if cnt then
		local config = Activity191Config.instance:getRelationCo(tag, 1)

		if cnt >= config.activeNum and activeLevel < config.level then
			activeLevel = config.level
		end
	end

	return activeLevel
end

function Act191GameMO:getActiveBossId()
	local tag = "remodeling"
	local bossId
	local activeLevel = self:getFetterActiveLevel(tag)
	local remodelingValue = self.recordInfo.remodelingValue
	local bossCfgList = Activity191Config.instance:getBossCfgListByTag(tag)

	for _, v in ipairs(bossCfgList) do
		local conditions = string.splitToNumber(v.condition, "#")

		if activeLevel >= conditions[1] and remodelingValue >= conditions[2] then
			bossId = v.bossId

			break
		end
	end

	return bossId
end

function Act191GameMO:getActiveSummonIdList()
	local summonIdList = {}
	local bossId = self:getActiveBossId()

	if bossId then
		summonIdList[#summonIdList + 1] = bossId
	end

	local fetterCntDic = self:getTeamFetterCntDic()
	local fetterInfoList = Activity191Helper.getActiveFetterInfoList(fetterCntDic)

	for _, info in ipairs(fetterInfoList) do
		local config = info.config

		if config.summon ~= 0 then
			summonIdList[#summonIdList + 1] = config.summon
		end
	end

	return summonIdList
end

function Act191GameMO:getAttrUpDicByRoleId(roleId)
	local attrDic = {}
	local fetterList = {}

	for _, effect in ipairs(self.warehouseInfo.effect) do
		if effect.type == Activity191Enum.EffectType.AttrEffect then
			local roleIdList = string.splitToNumber(effect.param, "#")

			if tabletool.indexOf(roleIdList, roleId) then
				local effectCo = lua_activity191_effect.configDict[effect.id]
				local tag = effectCo.tag

				if not string.nilorempty(tag) and not tabletool.indexOf(fetterList, tag) then
					fetterList[#fetterList + 1] = tag
				end

				local attrString = string.split(effectCo.typeParam, "#")[2]
				local attrParams = GameUtil.splitString2(attrString, true, "|", ",")

				for i = 1, #attrParams do
					local key = attrParams[i][1]
					local value = attrParams[i][2]

					if not attrDic[key] then
						attrDic[key] = 0
					end

					attrDic[key] = attrDic[key] + value
				end
			end
		end
	end

	return attrDic, fetterList
end

function Act191GameMO:getBossAttr()
	local attack, technic, heroCnt = 0, 0, 0
	local teamInfo = self:getTeamInfo()

	for _, v in ipairs(teamInfo.battleHeroInfo) do
		if v.heroId and v.heroId ~= 0 then
			heroCnt = heroCnt + 1

			local heroCo = Activity191Config.instance:getRoleCoByNativeId(v.heroId, 1)
			local attrCo = lua_activity191_template.configDict[heroCo.id]
			local attrUpDic = self:getAttrUpDicByRoleId(v.heroId)
			local attackRatio = attrUpDic[Activity191Enum.AttrIdList[1]] or 0
			local technicRatio = attrUpDic[Activity191Enum.AttrIdList[3]] or 0

			attack = attack + attrCo.attack * (1 + attackRatio / 1000)
			technic = technic + attrCo.technic * (1 + technicRatio / 1000)
		end
	end

	attack = Mathf.Round(attack / heroCnt)
	technic = Mathf.Round(technic / heroCnt)

	return attack, technic
end

function Act191GameMO:getRelationDesc(relationCo)
	if relationCo.tag == "remodeling" then
		local bossId = self:getActiveBossId()

		if bossId then
			local bossCo = lua_activity191_assist_boss.configDict[bossId]

			return GameUtil.getSubPlaceholderLuaLangTwoParam(relationCo.desc, self.recordInfo.remodelingValue, bossCo.name)
		else
			local count = 0
			local txt = string.gsub(relationCo.desc, "%b()", function(match)
				count = count + 1

				return count == 2 and "" or match
			end)

			return GameUtil.getSubPlaceholderLuaLangOneParam(txt, self.recordInfo.remodelingValue)
		end
	end

	local effects = relationCo.effects

	if not string.nilorempty(effects) then
		local effectIds = string.splitToNumber(effects, "|")

		for k, id in ipairs(effectIds) do
			local act191Effect = self:getAct191Effect(id)

			if act191Effect and (not act191Effect["end"] or k == #effectIds) then
				return GameUtil.getSubPlaceholderLuaLangOneParam(relationCo.desc, string.format("%d/%d", act191Effect.count, act191Effect.needCount))
			end
		end
	end

	return string.gsub(relationCo.desc, "（(.-)）", "")
end

function Act191GameMO:getStoneId(config)
	for _, v in ipairs(self.recordInfo.heroFacets) do
		if v.roleId == config.roleId then
			return v.facetsId
		end
	end

	if not string.nilorempty(config.facetsId) then
		return string.splitToNumber(config.facetsId, "#")[1]
	end
end

function Act191GameMO:updateStoneId(roleId, facetsId)
	local info

	for _, v in ipairs(self.recordInfo.heroFacets) do
		if v.roleId == roleId then
			info = v

			break
		end
	end

	if not info then
		info = Activity191Module_pb.Act191HeroFacetsIdInfo()
		info.roleId = roleId

		table.insert(self.recordInfo.heroFacets, info)
	end

	info.facetsId = facetsId
end

return Act191GameMO
