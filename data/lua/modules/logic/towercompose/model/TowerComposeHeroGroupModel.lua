-- chunkname: @modules/logic/towercompose/model/TowerComposeHeroGroupModel.lua

module("modules.logic.towercompose.model.TowerComposeHeroGroupModel", package.seeall)

local TowerComposeHeroGroupModel = class("TowerComposeHeroGroupModel", HeroGroupModel)

function TowerComposeHeroGroupModel:onInit()
	self:reInit()
end

function TowerComposeHeroGroupModel:reInit()
	TowerComposeHeroGroupModel.super.reInit(self)

	self.themePlaneBuffDataMap = {}
	self.curSelectPlaneId = 0
	self.curSelectBuffType = TowerComposeEnum.TeamBuffType.Support
end

function TowerComposeHeroGroupModel:isTowerComposeEpisode(episodeId)
	local episodeCO = DungeonConfig.instance:getEpisodeCO(episodeId or HeroGroupModel.instance.episodeId)

	return episodeCO and episodeCO.type == DungeonEnum.EpisodeType.TowerCompose
end

function TowerComposeHeroGroupModel:initSaveThemePlaneBuffId()
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local saveStr = curGroupMO:getSaveParams()
	local saveData = string.nilorempty(saveStr) and {} or cjson.decode(saveStr)
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local themeId = recordFightParam.themeId
	local layerId = recordFightParam.layerId
	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(themeId, layerId)

	if towerEpisodeConfig.plane == 0 then
		self:buildEmptyPlaneBuffMap(themeId, 0)

		local planeData = string.splitToNumber(saveData.buffParamsStr or "", "#") or {}

		for buffType, saveId in ipairs(planeData) do
			self.themePlaneBuffDataMap[themeId] = self.themePlaneBuffDataMap[themeId] or {}
			self.themePlaneBuffDataMap[themeId][0] = self.themePlaneBuffDataMap[themeId][0] or {}
			self.themePlaneBuffDataMap[themeId][0][buffType] = saveId
		end
	else
		for plane = 1, 2 do
			self:buildEmptyPlaneBuffMap(themeId, plane)
		end

		local dataList = GameUtil.splitString2(saveData.buffParamsStr or "", true) or {}

		for planeId, planeData in ipairs(dataList) do
			for buffType, saveId in pairs(planeData) do
				self.themePlaneBuffDataMap[themeId] = self.themePlaneBuffDataMap[themeId] or {}
				self.themePlaneBuffDataMap[themeId][planeId] = self.themePlaneBuffDataMap[themeId][planeId] or {}
				self.themePlaneBuffDataMap[themeId][planeId][buffType] = saveId
			end
		end
	end
end

function TowerComposeHeroGroupModel:buildEmptyPlaneBuffMap(themeId, planeId)
	self.themePlaneBuffDataMap[themeId] = self.themePlaneBuffDataMap[themeId] or {}
	self.themePlaneBuffDataMap[themeId][planeId] = {}

	for buffType = 1, 3 do
		self.themePlaneBuffDataMap[themeId][planeId][buffType] = 0
	end

	return self.themePlaneBuffDataMap
end

function TowerComposeHeroGroupModel:getThemePlaneBuffId(themeId, planeId, buffType)
	if not self.themePlaneBuffDataMap[themeId] or not self.themePlaneBuffDataMap[themeId][planeId] then
		self:initSaveThemePlaneBuffId()
	end

	local buffId = self.themePlaneBuffDataMap[themeId] and self.themePlaneBuffDataMap[themeId][planeId] and self.themePlaneBuffDataMap[themeId][planeId][buffType] or 0

	if buffType == TowerComposeEnum.TeamBuffType.Research and buffId > 0 then
		buffId = TowerComposeModel.instance:checkCurThemeResearchUnlock(themeId, buffId) and buffId or 0
	elseif buffType == TowerComposeEnum.TeamBuffType.Support and buffId > 0 then
		buffId = self:getCurRealSupportId(themeId, buffId)
	elseif buffType == TowerComposeEnum.TeamBuffType.Cloth and buffId > 0 then
		-- block empty
	end

	return buffId
end

function TowerComposeHeroGroupModel:getCurRealSupportId(themeId, supportId)
	local supportCo = TowerComposeConfig.instance:getSupportCo(supportId)

	if not supportCo then
		logError(supportId .. "援助角色id配置不存在")

		supportId = 0

		return supportId
	end

	local heroMo = HeroModel.instance:getByHeroId(supportCo.heroId)

	if heroMo then
		local curSupportCo = TowerComposeConfig.instance:getThemeCurLvHeroIdSupportCo(themeId, heroMo.heroId, heroMo.exSkillLevel)

		supportId = curSupportCo and curSupportCo.id or 0
	else
		supportId = 0
	end

	return supportId
end

function TowerComposeHeroGroupModel:setThemePlaneBuffId(themeId, planeId, buffType, buffId)
	self.themePlaneBuffDataMap[themeId] = self.themePlaneBuffDataMap[themeId] or {}
	self.themePlaneBuffDataMap[themeId][planeId] = self.themePlaneBuffDataMap[themeId][planeId] or {}
	self.themePlaneBuffDataMap[themeId][planeId][buffType] = buffId
end

function TowerComposeHeroGroupModel:saveThemePlaneBuffData()
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local themeId = recordFightParam.themeId
	local layerId = recordFightParam.layerId
	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(themeId, layerId)
	local saveBuffParamsStr = ""

	if towerEpisodeConfig.plane == 0 then
		local buffMap = self.themePlaneBuffDataMap[themeId] and self.themePlaneBuffDataMap[themeId][0] or {}

		saveBuffParamsStr = table.concat(buffMap, "#")
	else
		local planeMap = self.themePlaneBuffDataMap[themeId] or {}
		local saveStrList = {}

		for planeId = 1, 2 do
			local buffMap = planeMap[planeId] or {}

			saveBuffParamsStr = table.concat(buffMap, "#")
			saveStrList[planeId] = saveBuffParamsStr
		end

		saveBuffParamsStr = table.concat(saveStrList, "|")
	end

	self:buildSaveParams(saveBuffParamsStr)
end

function TowerComposeHeroGroupModel:buildSaveParams(saveBuffParamsStr)
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local saveParamData = {}

	saveParamData.heroList = curGroupMO.heroList
	saveParamData.buffParamsStr = saveBuffParamsStr

	local saveParamsStr = cjson.encode(saveParamData)

	curGroupMO:setSaveParams(saveParamsStr)
	HeroGroupModel.instance:saveCurGroupData()
end

function TowerComposeHeroGroupModel:checkBuffInPlane(themeId, buffType, buffId, isNormalEpisode)
	if isNormalEpisode then
		local saveId = self:getThemePlaneBuffId(themeId, 0, buffType)

		if saveId == buffId then
			return 0
		end

		return -1
	end

	for planeId = 1, 2 do
		local saveId = self:getThemePlaneBuffId(themeId, planeId, buffType)

		if saveId == buffId then
			return planeId
		end
	end

	return 0
end

function TowerComposeHeroGroupModel:setCurSelectPlaneIdAndType(planeId, buffType)
	self.curSelectPlaneId = planeId
	self.curSelectBuffType = buffType
end

function TowerComposeHeroGroupModel:getCurSelectPlaneIdAndType()
	return self.curSelectPlaneId, self.curSelectBuffType
end

function TowerComposeHeroGroupModel:checkCanSelectTrialHero(trialCo, index, isQuickEdit)
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local plane = recordFightParam.plane
	local canSelect = false
	local canQuickSelect = true
	local startCheckPos = index > 4 and 5 or 1
	local endCheckPos = index > 4 and 8 or 4
	local hasTrialMo
	local hasTrialPos = 0

	for pos = startCheckPos, endCheckPos do
		if isQuickEdit then
			local posHeroUid = HeroGroupQuickEditListModel.instance:getHeroUidByPos(pos)

			if tonumber(posHeroUid) < 0 then
				local heroMo = HeroGroupTrialModel.instance:getById(posHeroUid)

				if trialCo and heroMo.trialCo and heroMo.trialCo.id ~= trialCo.id and index ~= pos then
					canQuickSelect = false

					break
				end
			end
		else
			local heroSingleGroupMO = HeroSingleGroupModel.instance:getById(pos)

			if heroSingleGroupMO.trial and heroSingleGroupMO.trial ~= 0 then
				hasTrialMo = heroSingleGroupMO
				hasTrialPos = pos

				break
			end
		end
	end

	canSelect = (not hasTrialMo or not trialCo or hasTrialPos == index or trialCo.id == hasTrialMo.trial) and canQuickSelect

	return canSelect
end

function TowerComposeHeroGroupModel:getQuickSelectOrder()
	local inTeamHeroUidList = HeroGroupQuickEditListModel.instance:getHeroUids()
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local themeId = recordFightParam.themeId
	local startIndex = 1
	local endIndex = #inTeamHeroUidList
	local curLockPlaneId = TowerComposeModel.instance:getCurLockPlaneId(themeId)

	if curLockPlaneId == 1 then
		startIndex = #inTeamHeroUidList / 2 + 1
	elseif curLockPlaneId == 2 then
		endIndex = #inTeamHeroUidList / 2
	end

	for pos = startIndex, endIndex do
		local heroUid = inTeamHeroUidList[pos]

		if heroUid == "0" then
			return pos
		end
	end
end

function TowerComposeHeroGroupModel:checkEquipedSupportHero(heroId)
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local themeId = recordFightParam.themeId
	local layerId = recordFightParam.layerId
	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(themeId, layerId)

	if towerEpisodeConfig.plane > 0 then
		for planeId = 1, 2 do
			local supportId = self:getThemePlaneBuffId(themeId, planeId, TowerComposeEnum.TeamBuffType.Support)

			if supportId > 0 then
				local supportConfig = TowerComposeConfig.instance:getSupportCo(supportId)

				if supportConfig.heroId == heroId then
					return true
				end
			end
		end
	elseif towerEpisodeConfig.plane == 0 then
		local supportId = self:getThemePlaneBuffId(themeId, 0, TowerComposeEnum.TeamBuffType.Support)

		if supportId > 0 then
			local supportConfig = TowerComposeConfig.instance:getSupportCo(supportId)

			if supportConfig.heroId == heroId then
				return true
			end
		end
	end

	return false
end

function TowerComposeHeroGroupModel:checkHeroIsInTeam(heroId)
	local heroList = HeroSingleGroupModel.instance:getList()

	for _, heroSingleGroupMO in ipairs(heroList) do
		if tonumber(heroSingleGroupMO.heroUid) > 0 and not heroSingleGroupMO.trial then
			local heroMo = heroSingleGroupMO:getHeroMO()

			if heroMo and heroMo.heroId == heroId then
				return true
			end
		elseif tonumber(heroSingleGroupMO.heroUid) < 0 and heroSingleGroupMO.trial then
			local trialCo = heroSingleGroupMO:getTrialCO()

			if trialCo and trialCo.heroId == heroId then
				return true
			end
		end
	end

	return false
end

function TowerComposeHeroGroupModel:getPlaneExtraHeroList(themeId, planeId)
	local startPos = planeId < 2 and 1 or 5
	local endPos = planeId < 2 and 4 or 8
	local heroList = HeroSingleGroupModel.instance:getList()
	local extraHeroIdList = {}

	for index = startPos, endPos do
		local heroSingleGroupMO = heroList[index]

		if heroSingleGroupMO and tonumber(heroSingleGroupMO.heroUid) > 0 and not heroSingleGroupMO.trial then
			local heroMo = heroSingleGroupMO:getHeroMO()

			if heroMo then
				local isExtraHero, extraCo = TowerComposeConfig.instance:checkIsExtraHero(themeId, heroMo.heroId)

				if isExtraHero then
					table.insert(extraHeroIdList, extraCo.id)
				end
			end
		elseif heroSingleGroupMO and tonumber(heroSingleGroupMO.heroUid) < 0 and heroSingleGroupMO.trial then
			local trialCo = heroSingleGroupMO:getTrialCO()

			if trialCo then
				local isExtraHero, extraCo = TowerComposeConfig.instance:checkIsExtraHero(themeId, trialCo.heroId)

				if isExtraHero then
					table.insert(extraHeroIdList, extraCo.id)
				end
			end
		end
	end

	return extraHeroIdList
end

function TowerComposeHeroGroupModel:getHeroIdByHeroSingleGroupMO(heroSingleGroupMO)
	if heroSingleGroupMO and tonumber(heroSingleGroupMO.heroUid) > 0 and not heroSingleGroupMO.trial then
		local heroMo = heroSingleGroupMO:getHeroMO()

		if heroMo then
			return heroMo.heroId
		end
	elseif heroSingleGroupMO and tonumber(heroSingleGroupMO.heroUid) < 0 and heroSingleGroupMO.trial then
		local trialCo = heroSingleGroupMO:getTrialCO()

		if trialCo then
			return trialCo.heroId
		end
	end
end

function TowerComposeHeroGroupModel:getPlaneRealExtraCoList(themeId, planeId)
	local extraHeroIdList = self:getPlaneExtraHeroList(themeId, planeId)
	local maxExtraPointBase1 = 0
	local maxExtraPointBase2 = 0
	local maxExtraCo1, maxExtraCo2

	for _, heroId in ipairs(extraHeroIdList) do
		local isExtraHero, extraCo = TowerComposeConfig.instance:checkIsExtraHero(themeId, heroId)

		if isExtraHero and extraCo then
			if not maxExtraCo1 then
				maxExtraCo1 = extraCo
				maxExtraPointBase1 = extraCo.bossPointBase
			elseif maxExtraPointBase1 < extraCo.bossPointBase then
				maxExtraCo2 = maxExtraCo1
				maxExtraPointBase2 = maxExtraPointBase1
				maxExtraCo1 = extraCo
				maxExtraPointBase1 = extraCo.bossPointBase
			elseif not maxExtraCo2 or maxExtraPointBase2 < extraCo.bossPointBase then
				maxExtraCo2 = extraCo
				maxExtraPointBase2 = extraCo.bossPointBase
			end
		end
	end

	local realExtraHeroCoList = {}

	if maxExtraCo1 then
		table.insert(realExtraHeroCoList, maxExtraCo1)
	end

	if maxExtraCo2 then
		table.insert(realExtraHeroCoList, maxExtraCo2)
	end

	return realExtraHeroCoList
end

function TowerComposeHeroGroupModel:replaceLockPlaneHeroList(heroGroupMo, lockHeroList)
	heroGroupMo.heroList = lockHeroList
	heroGroupMo.equips = {}
	heroGroupMo.trialDict = {}

	for pos, heroData in ipairs(lockHeroList) do
		heroGroupMo.heroList[pos] = heroData.heroUid

		local equipUid = heroData.equipUid

		if equipUid then
			local index = pos - 1

			heroGroupMo.equips[index] = HeroGroupEquipMO.New()

			heroGroupMo.equips[index]:init({
				index = index,
				equipUid = equipUid
			})
		end

		local heroUid = heroData.heroUid

		if tonumber(heroUid) < 0 then
			local heroMO = HeroGroupTrialModel.instance:getById(heroUid)

			if heroMO then
				heroGroupMo.trialDict[pos] = {
					heroMO.trialCo.id,
					0
				}
			else
				heroGroupMo.heroList[pos] = "0"
			end
		end
	end
end

function TowerComposeHeroGroupModel:checkHeroUidIsInLockPlane(heroUid)
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local themeId = recordFightParam.themeId
	local themeMo = TowerComposeModel.instance:getThemeMo(themeId)
	local heroGroupMo = HeroGroupModel.instance:getCurGroupMO()

	for pos, uid in ipairs(heroGroupMo.heroList) do
		if heroUid == uid then
			local planeId = Mathf.Ceil(pos / 4)
			local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(themeId, planeId)
			local planeMo = themeMo:getPlaneMo(planeId)

			return isPlaneLock and planeMo.hasFight
		end
	end

	return false
end

function TowerComposeHeroGroupModel:checkEquipUidIsInLockPlane(equipUid)
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local themeId = recordFightParam.themeId
	local themeMo = TowerComposeModel.instance:getThemeMo(themeId)
	local heroGroupMo = HeroGroupModel.instance:getCurGroupMO()

	for pos, heroGroupEquipMo in ipairs(heroGroupMo.equips) do
		if equipUid == heroGroupEquipMo.equipUid[1] then
			local planeId = Mathf.Ceil(pos / 4)
			local isPlaneLock = TowerComposeModel.instance:checkPlaneLock(themeId, planeId)
			local planeMo = themeMo:getPlaneMo(planeId)

			return isPlaneLock and planeMo.hasFight
		end
	end

	return false
end

function TowerComposeHeroGroupModel:replaceLockPlaneBuffItem()
	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local themeId = recordFightParam.themeId
	local themeMo = TowerComposeModel.instance:getThemeMo(themeId)
	local curBossMo = themeMo:getCurBossMo()

	if curBossMo and curBossMo.lock then
		self:initSaveThemePlaneBuffId()

		for planeId = 1, 2 do
			local planeMo = curBossMo:getPlaneMo(planeId)
			local teamInfoData = planeMo:getTeamInfoData()

			self:setThemePlaneBuffId(themeId, planeId, TowerComposeEnum.TeamBuffType.Support, teamInfoData.supportId)
			self:setThemePlaneBuffId(themeId, planeId, TowerComposeEnum.TeamBuffType.Research, teamInfoData.researchId)
			self:setThemePlaneBuffId(themeId, planeId, TowerComposeEnum.TeamBuffType.Cloth, teamInfoData.clothId)
		end
	end
end

TowerComposeHeroGroupModel.instance = TowerComposeHeroGroupModel.New()

return TowerComposeHeroGroupModel
