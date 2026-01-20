-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterWeekMo.lua

module("modules.logic.survival.model.shelter.SurvivalShelterWeekMo", package.seeall)

local SurvivalShelterWeekMo = pureTable("SurvivalShelterWeekMo")

function SurvivalShelterWeekMo:init(data, extendScore)
	self.shelterMapId = data.shelterMapId
	self.day = data.day
	self.extendScore = extendScore
	self.difficulty = data.difficulty
	self.inSurvival = data.inSurvival
	self.bags = self.bags or {}

	for i, v in ipairs(data.bag) do
		local bagType = v.bagType

		self.bags[bagType] = self.bags[bagType] or SurvivalBagMo.New()

		self.bags[bagType]:init(v)
	end

	self.reputationBuilds = {}

	self:updateBuildingInfos(data.buildingBox.building)
	self:updateNpcInfos(data.npcBox.npcs)

	self.mapInfos = GameUtil.rpcInfosToList(data.mapInfo, SurvivalMapInfoMo)
	self.heros = {}
	self.herosByHeroId = {}

	for k, v in ipairs(data.heroBox.heros) do
		local heroMo = SurvivalShelterHeroMo.New()

		heroMo:init(v)
		table.insert(self.heros, heroMo)

		self.herosByHeroId[heroMo.heroId] = heroMo
	end

	self.equipBox = self.equipBox or SurvivalEquipBoxMo.New()

	self.equipBox:init(data.equipBox)

	self.attrs = {}

	for i, v in ipairs(data.attrContainer.values) do
		self.attrs[v.attrId] = v.finalVal
	end

	self.taskPanel = SurvivalTaskPanelMo.New()

	self.taskPanel:init(data.taskPanel)

	self.intrudeBox = self.intrudeBox or SurvivalIntrudeBoxMo.New()

	self.intrudeBox:init(data.intrudeBox)

	self.panel = nil

	if data.panel.type ~= SurvivalEnum.PanelType.None then
		self.panel = SurvivalPanelMo.New()

		self.panel:init(data.panel)
	end

	self:updateRecruitInfo(data.recruitInfo)

	self.preExploreShop = self.preExploreShop or SurvivalShopMo.New()

	self.preExploreShop:init(data.preExploreShop)

	self.clientData = self.clientData or SurvivalWeekClientDataMo.New()

	self.clientData:init(data.clientData, self)

	self.rainType = data.rainType
	self.talents = data.talentBox.talentIds
end

function SurvivalShelterWeekMo:getBag(bagType)
	return self.bags[bagType]
end

function SurvivalShelterWeekMo:updateRecruitInfo(info)
	if not self.recruitInfo then
		self.recruitInfo = SurvivalShelterRecruitMo.New()
	end

	self.recruitInfo:init(info)
end

function SurvivalShelterWeekMo:getMonsterFight()
	return self.intrudeBox and self.intrudeBox.fight
end

function SurvivalShelterWeekMo:isInFight()
	local fight = self.intrudeBox.fight

	return fight:canAbandon() and fight.endTime == self.day and not self.inSurvival
end

function SurvivalShelterWeekMo:updateAttrs(values)
	for i, v in ipairs(values) do
		if self.attrs[v.attrId] ~= v.finalVal then
			self.attrs[v.attrId] = v.finalVal

			SurvivalController.instance:dispatchEvent(SurvivalEvent.OnAttrUpdate, v.attrId)
		end
	end
end

function SurvivalShelterWeekMo:getAttr(attrType, curNum, exAttrPer)
	local attrVal = self:getAttrRaw(attrType)

	if SurvivalEnum.AttrTypePer[attrType] then
		curNum = curNum or 0
		exAttrPer = exAttrPer or 0
		attrVal = math.floor(curNum * math.max(0, 1 + (attrVal + exAttrPer) / 1000))
	end

	return attrVal
end

function SurvivalShelterWeekMo:getAttrRaw(attrType)
	local attrVal = self.attrs[attrType] or 0

	return attrVal
end

function SurvivalShelterWeekMo:getHeroMo(heroId)
	if not self.herosByHeroId[heroId] then
		local heroMo = SurvivalShelterHeroMo.New()

		heroMo:setDefault(heroId)
		table.insert(self.heros, heroMo)

		self.herosByHeroId[heroMo.heroId] = heroMo
	end

	return self.herosByHeroId[heroId]
end

function SurvivalShelterWeekMo:updateHeroHealth(heros)
	for k, v in ipairs(heros) do
		local heroMo = self.herosByHeroId[v.heroId]

		if not heroMo then
			heroMo = SurvivalShelterHeroMo.New()

			table.insert(self.heros, heroMo)
		end

		heroMo:init(v)

		self.herosByHeroId[heroMo.heroId] = heroMo
	end
end

function SurvivalShelterWeekMo:isAllHeroHealth()
	local result = true

	if self.herosByHeroId then
		local healthMax = self:getAttr(SurvivalEnum.AttrType.HeroHealthMax)

		for k, v in pairs(self.herosByHeroId) do
			if healthMax > v.health then
				result = false

				break
			end
		end
	end

	return result
end

function SurvivalShelterWeekMo:updateBuildingInfos(infos)
	if self.buildingDict == nil then
		self.buildingDict = {}
	end

	local newBuildingIds = {}

	if infos then
		for i = 1, #infos do
			local mo = self:updateBuildingInfo(infos[i])

			newBuildingIds[infos[i].id] = true

			local have, pos = self:haveReputationShop(mo)

			if mo:isEqualType(SurvivalEnum.BuildingType.ReputationShop) and not have then
				table.insert(self.reputationBuilds, mo)
			end
		end
	end

	for buildingId, mo in pairs(self.buildingDict) do
		if not newBuildingIds[buildingId] then
			self.buildingDict[buildingId] = nil

			if mo:isEqualType(SurvivalEnum.BuildingType.ReputationShop) then
				local have, pos = self:haveReputationShop(mo)

				if have then
					table.remove(self.reputationBuilds, pos)
				end
			end
		end
	end
end

function SurvivalShelterWeekMo:updateBuildingInfo(info, isUpgrade)
	local buildingInfo = self:getBuildingInfo(info.id)

	if not buildingInfo then
		buildingInfo = SurvivalShelterBuildingMo.New()
		self.buildingDict[info.id] = buildingInfo
	end

	buildingInfo:init(info, isUpgrade)

	return buildingInfo
end

function SurvivalShelterWeekMo:haveReputationShop(mo)
	local pos = tabletool.indexOf(self.reputationBuilds, mo)

	return pos ~= nil, pos
end

function SurvivalShelterWeekMo:getBuildingInfo(buildingId)
	return self.buildingDict[buildingId]
end

function SurvivalShelterWeekMo:lockBuildingLevel(buildingId)
	local buildingInfo = self:getBuildingInfo(buildingId)

	if buildingInfo then
		buildingInfo:lockLevel()
	end
end

function SurvivalShelterWeekMo:getBuildingInfoByBuildType(buildType)
	for k, v in pairs(self.buildingDict) do
		if v:isEqualType(buildType) then
			return v
		end
	end
end

function SurvivalShelterWeekMo:getBuildingInfoByBuildingId(buildingId)
	for k, v in pairs(self.buildingDict) do
		if v.buildingId == buildingId then
			return v
		end
	end
end

function SurvivalShelterWeekMo:getBuildingList()
	local list = {}

	for k, v in pairs(self.buildingDict) do
		table.insert(list, v)
	end

	return list
end

function SurvivalShelterWeekMo:updateNpcInfos(infos)
	if self.npcDict == nil then
		self.npcDict = {}
	end

	local newNpcIds = {}

	if infos then
		for i = 1, #infos do
			self:updateNpcInfo(infos[i])

			newNpcIds[infos[i].id] = true
		end
	end

	for npcId, _ in pairs(self.npcDict) do
		if not newNpcIds[npcId] then
			self.npcDict[npcId] = nil
		end
	end
end

function SurvivalShelterWeekMo:updateNpcInfo(info)
	local npcInfo = self:getNpcInfo(info.id)

	if not npcInfo then
		npcInfo = SurvivalShelterNpcMo.New()
		self.npcDict[info.id] = npcInfo
	end

	npcInfo:init(info)
end

function SurvivalShelterWeekMo:getNpcInfo(npcId)
	return self.npcDict[npcId]
end

function SurvivalShelterWeekMo:hasNpc(npcId)
	local npcInfo = self:getNpcInfo(npcId)

	return npcInfo ~= nil
end

function SurvivalShelterWeekMo:getNpcPostion(npcId)
	if not self:hasNpc(npcId) then
		return
	end

	for k, v in pairs(self.buildingDict) do
		if v:isNpcInBuilding(npcId) then
			return k, v:getNpcPos(npcId)
		end
	end
end

function SurvivalShelterWeekMo:getNpcByBuildingPosition(buildingId, position)
	local buildingInfo = self:getBuildingInfo(buildingId)

	if not buildingInfo then
		return
	end

	return buildingInfo:getNpcByPosition(position)
end

function SurvivalShelterWeekMo:changeNpcPostion(npcId, buildingId, position)
	if not self:hasNpc(npcId) then
		return
	end

	local oldBuildingId = self:getNpcPostion(npcId)

	if oldBuildingId then
		local buildingInfo = self:getBuildingInfo(oldBuildingId)

		buildingInfo:removeNpc(npcId)
	end

	local buildingInfo = self:getBuildingInfo(buildingId)

	buildingInfo:addNpc(npcId, position)
end

function SurvivalShelterWeekMo:exchangeNpcPosition(srcNpcId, targetNpcId)
	local srcBuildingId, srcPos = self:getNpcPostion(srcNpcId)
	local targetBuildingId, targetPos = self:getNpcPostion(targetNpcId)

	if srcBuildingId and targetBuildingId then
		self:changeNpcPostion(srcNpcId, targetBuildingId, targetPos)
		self:changeNpcPostion(targetNpcId, srcBuildingId, srcPos)
	end
end

function SurvivalShelterWeekMo:hasHero(heroId)
	local heroInfo = self.herosByHeroId[heroId]

	return heroInfo ~= nil
end

function SurvivalShelterWeekMo:getHeroPostion(heroId)
	if not self:hasHero(heroId) then
		return
	end

	for k, v in pairs(self.buildingDict) do
		if v:isHeroInBuilding(heroId) then
			return k, v:getHeroPos(heroId)
		end
	end
end

function SurvivalShelterWeekMo:batchHeroPostion(heros, buildingId)
	local buildingInfo = self:getBuildingInfo(buildingId)

	if not buildingInfo then
		return
	end

	buildingInfo:batchHeros(heros)
end

function SurvivalShelterWeekMo:changeHeroPostion(heroId, buildingId, position)
	if not self:hasHero(heroId) then
		return
	end

	local oldBuildingId = self:getHeroPostion(heroId)

	if oldBuildingId then
		local buildingInfo = self:getBuildingInfo(oldBuildingId)

		buildingInfo:removeHero(heroId)
	end

	local buildingInfo = self:getBuildingInfo(buildingId)

	buildingInfo:addHero(heroId, position)
end

function SurvivalShelterWeekMo:exchangeHeroPosition(srcHeroId, targetHeroId)
	local srcBuildingId, srcPos = self:getHeroPostion(srcHeroId)
	local targetBuildingId, targetPos = self:getHeroPostion(targetHeroId)

	if srcBuildingId and targetBuildingId then
		self:changeHeroPostion(srcHeroId, targetBuildingId, targetPos)
		self:changeHeroPostion(targetHeroId, srcBuildingId, srcPos)
	end
end

function SurvivalShelterWeekMo:checkBuildingLev(buildingId, lev)
	for k, v in pairs(self.buildingDict) do
		if v.buildingId == buildingId and lev <= v.level then
			return true
		end
	end

	return false
end

function SurvivalShelterWeekMo:checkBuildingTypeLev(buildingType, lev)
	for k, v in pairs(self.buildingDict) do
		if v:isEqualType(buildingType) and lev <= v.level then
			return true
		end
	end

	return false
end

function SurvivalShelterWeekMo:isBuildingUnlock(buildingId, level, backReason)
	local config = SurvivalConfig.instance:getBuildingConfig(buildingId, level, true)

	if not config then
		return true
	end

	local condition = config.unlockCondition

	if string.nilorempty(condition) then
		return true
	end

	local list = GameUtil.splitString2(condition, false)
	local unlock = false
	local reason

	for i, v in ipairs(list) do
		unlock, reason = self:_checkBuildUnLockCondition(v, backReason)

		if not unlock then
			break
		end
	end

	return unlock, reason
end

function SurvivalShelterWeekMo:_checkBuildUnLockCondition(condition, backReason)
	if not condition then
		return true
	end

	local unlock = false
	local reason

	if condition[1] == "npcNum" then
		local npcNum = tonumber(condition[2]) or 0
		local count = tabletool.len(self.npcDict)

		unlock = npcNum <= count

		if not unlock and backReason then
			reason = formatLuaLang("survivalbuildingmanageview_buildinglock_reason1", npcNum)
		end
	elseif condition[1] == "building" then
		local checkBuildingId = tonumber(condition[2]) or 0
		local checkBuildingLev = tonumber(condition[3]) or 0

		unlock = self:checkBuildingLev(checkBuildingId, checkBuildingLev)

		if not unlock and backReason then
			local buildingConfig = SurvivalConfig.instance:getBuildingConfig(checkBuildingId, 1, true)

			reason = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survivalbuildingmanageview_buildinglock_reason2"), buildingConfig and buildingConfig.name or "", checkBuildingLev)
		end
	end

	return unlock, reason
end

function SurvivalShelterWeekMo:isBuildingCanLevup(buildingInfo, level, noCheckCost)
	if not buildingInfo then
		return false
	end

	local buildingId = buildingInfo.buildingId
	local config = SurvivalConfig.instance:getBuildingConfig(buildingId, level, true)

	if not config then
		return false
	end

	if not self:isBuildingUnlock(buildingId, level) then
		return false
	end

	if noCheckCost then
		return true
	end

	local lvUpCost = config.lvUpCost
	local isEnough = self:getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(lvUpCost, buildingInfo, SurvivalEnum.AttrType.BuildCost)

	return isEnough
end

function SurvivalShelterWeekMo:canShowNpcInShelter(npcId)
	return true
end

function SurvivalShelterWeekMo:getBuildingBtnStatus()
	local hasDestoryedBuilding = false
	local hasNewBuilding = false
	local hasLevupBuilding = false

	for k, v in pairs(self.buildingDict) do
		if v:isDestoryed() then
			hasDestoryedBuilding = true

			break
		end

		if self:isBuildingCanLevup(v, v.level + 1, false) then
			if v:isBuild() then
				hasLevupBuilding = true
			else
				hasNewBuilding = true
			end
		end
	end

	if hasDestoryedBuilding then
		return SurvivalEnum.ShelterBuildingBtnStatus.Destroy
	end

	if hasNewBuilding then
		return SurvivalEnum.ShelterBuildingBtnStatus.New
	end

	if hasLevupBuilding then
		return SurvivalEnum.ShelterBuildingBtnStatus.Levelup
	end

	return SurvivalEnum.ShelterBuildingBtnStatus.Normal
end

function SurvivalShelterWeekMo:getRecruitInfo()
	return self.recruitInfo
end

function SurvivalShelterWeekMo:getNpcCost()
	local costCount = 0

	return costCount
end

function SurvivalShelterWeekMo:getBuildShop(shopId)
	for k, mo in pairs(self.buildingDict) do
		local shop = mo:getShop(shopId)

		if shop.id == shopId then
			return shop
		end
	end
end

function SurvivalShelterWeekMo:getReputationBuilds()
	return self.reputationBuilds
end

function SurvivalShelterWeekMo:getBuildingMoByReputationId(reputationId)
	for i, survivalShelterBuildingMo in ipairs(self.reputationBuilds) do
		if reputationId == survivalShelterBuildingMo.survivalReputationPropMo.prop.reputationId then
			return survivalShelterBuildingMo
		end
	end
end

function SurvivalShelterWeekMo:isAllReputationShopMaxLevel()
	for i, survivalShelterBuildingMo in ipairs(self.reputationBuilds) do
		if not survivalShelterBuildingMo.survivalReputationPropMo:isMaxLevel() then
			return false
		end
	end

	return true
end

function SurvivalShelterWeekMo:getSurvivalMapInfoMo(mapId)
	for i, v in ipairs(self.mapInfos) do
		if mapId == v.mapId then
			return v
		end
	end
end

return SurvivalShelterWeekMo
