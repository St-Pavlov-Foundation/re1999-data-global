-- chunkname: @modules/logic/rouge2/start/config/Rouge2_CareerConfig.lua

module("modules.logic.rouge2.start.config.Rouge2_CareerConfig", package.seeall)

local Rouge2_CareerConfig = class("Rouge2_CareerConfig", BaseConfig)

function Rouge2_CareerConfig:onInit()
	return
end

function Rouge2_CareerConfig:reqConfigNames()
	return {
		"rouge2_career",
		"rouge2_career_transfer",
		"rouge2_dice",
		"rouge2_dice_check",
		"fight_rouge2_summoner",
		"rouge2_system"
	}
end

function Rouge2_CareerConfig:onConfigLoaded(configName, configTable)
	if configName == "rouge2_career" then
		self:_onCareerConfigLoaded(configTable)
	elseif configName == "rouge2_career_transfer" then
		self:_onCareerTransferConfigLoaded(configTable)
	elseif configName == "fight_rouge2_summoner" then
		self:_onFightRouge2SummonerConfigLoaded(configTable)
	end
end

function Rouge2_CareerConfig:_onCareerConfigLoaded(configTable)
	self._carrerId2PassiveIdMap = {}
	self._careerId2ActiveSkillMap = {}
	self._careerId2AttributeIdMap = {}
	self._careerId2RecommendTeamMap = {}

	for _, careerCo in ipairs(configTable.configList) do
		local passiveSkillMap = {}
		local skillList = GameUtil.splitString2(careerCo.passiveSkills, true)

		for _, passiveSkill in ipairs(skillList or {}) do
			local attributeId = passiveSkill[1]
			local passiveSkillId = passiveSkill[2]

			passiveSkillMap[attributeId] = passiveSkillId
		end

		self._carrerId2PassiveIdMap[careerCo.id] = passiveSkillMap
		self._careerId2ActiveSkillMap[careerCo.id] = string.splitToNumber(careerCo.activeSkills, "#")

		local attributeList = GameUtil.splitString2(careerCo.initialAttribute, true)

		self._careerId2AttributeIdMap[careerCo.id] = attributeList
		self._careerId2RecommendTeamMap[careerCo.id] = string.splitToNumber(careerCo.recommendTeam, "#")
	end
end

function Rouge2_CareerConfig:_onCareerTransferConfigLoaded(configTable)
	self._mainId2TransferCareerMap = {}

	for _, careerCo in ipairs(configTable.configList) do
		local mainCareerId = careerCo.career

		self._mainId2TransferCareerMap[mainCareerId] = self._mainId2TransferCareerMap[mainCareerId] or {}

		table.insert(self._mainId2TransferCareerMap[mainCareerId], careerCo)
	end
end

function Rouge2_CareerConfig:_onFightRouge2SummonerConfigLoaded(configTable)
	self._type2TalentList = {}
	self._nextTalentMap = {}
	self._preTalentMap = {}
	self._holeIndex2TalentMap = {}
	self._stage2TalentList = {}
	self._talentIconUrlMap = {}

	for _, talentCo in ipairs(configTable.configList) do
		local talentId = talentCo.talentId
		local type = talentCo.type

		self._type2TalentList[type] = self._type2TalentList[type] or {}

		table.insert(self._type2TalentList[type], talentCo)

		local keys = string.splitToNumber(talentCo.keys, "#")

		if keys then
			self._preTalentMap[talentId] = {}

			for _, keyId in ipairs(keys) do
				local keyTalentCo = lua_fight_rouge2_summoner.configDict[keyId]

				table.insert(self._preTalentMap[talentId], keyTalentCo)

				self._nextTalentMap[keyId] = self._nextTalentMap[keyId] or {}

				table.insert(self._nextTalentMap[keyId], talentCo)
			end
		end

		if talentCo.ordinal and talentCo.ordinal ~= 0 then
			self._holeIndex2TalentMap[talentCo.ordinal] = talentCo
		end

		self._stage2TalentList[talentCo.stage] = self._stage2TalentList[talentCo.stage] or {}

		table.insert(self._stage2TalentList[talentCo.stage], talentCo)

		local iconUrlStr = string.split(talentCo.icon, "#")

		if iconUrlStr then
			self._talentIconUrlMap[talentId] = {}

			for status, iconUrl in ipairs(iconUrlStr) do
				self._talentIconUrlMap[talentId][status] = iconUrl
			end
		end
	end

	for _, talentList in pairs(self._type2TalentList) do
		table.sort(talentList, self._talentConfigSortFunc)
	end
end

function Rouge2_CareerConfig._talentConfigSortFunc(aTalentCo, bTalentCo)
	local aStage = aTalentCo.stage
	local bStage = bTalentCo.stage

	if aStage ~= bStage then
		return aStage < bStage
	end

	return aTalentCo.talentId < bTalentCo.talentId
end

function Rouge2_CareerConfig:getCareerConfig(careerId)
	local careerCo = lua_rouge2_career.configDict[careerId]

	careerCo = careerCo or lua_rouge2_career_transfer.configDict[careerId]

	if not careerCo then
		logError(string.format("肉鸽职业配置为空 careerId = %s", careerId))

		return
	end

	return careerCo
end

function Rouge2_CareerConfig:mainCareerId2TransferCareerConfigs(mainCareerId)
	local transferCareerList = self._mainId2TransferCareerMap and self._mainId2TransferCareerMap[mainCareerId]

	if not transferCareerList then
		logError(string.format("肉鸽转职配置不存在 mainCareerId = %s", mainCareerId))
	end

	return transferCareerList
end

function Rouge2_CareerConfig:getCareerInitialAttributeConfigAndValue(careerId)
	local attrBaseInfoList = {}
	local careerCo = self:getCareerConfig(careerId)
	local initialAttribute = careerCo and careerCo.initialAttribute or ""

	if string.nilorempty(initialAttribute) then
		logError(string.format("肉鸽职业初始属性配置为空 careerId = %s", careerId))

		return {}
	end

	local attributeList = GameUtil.splitString2(initialAttribute, true)

	for _, list in ipairs(attributeList) do
		local attrId = list[1]
		local attrValue = list[2]

		table.insert(attrBaseInfoList, {
			attrId = attrId,
			value = attrValue
		})
	end

	return attrBaseInfoList
end

function Rouge2_CareerConfig:getCareerInitialAttributeId(careerId)
	local attributeIdList = {}
	local attributeList = self._careerId2AttributeIdMap and self._careerId2AttributeIdMap[careerId]

	if attributeList then
		for _, attributeInfo in ipairs(attributeList) do
			table.insert(attributeIdList, attributeInfo[1])
		end
	end

	return attributeIdList
end

function Rouge2_CareerConfig:getAttrSortIndex(careerId, attrId)
	local sortAttrMap = self._sortAttrIdMap and self._sortAttrIdMap[careerId]

	if not sortAttrMap then
		local careerCo = self:getCareerConfig(careerId)
		local sortAttributeStr = careerCo and careerCo.sortAttribute
		local sortAttrList = GameUtil.splitString2(sortAttributeStr, true)

		sortAttrMap = {}

		for _, sortAttrInfo in ipairs(sortAttrList) do
			local attrId = sortAttrInfo[1]
			local sortIndex = sortAttrInfo[2]

			sortAttrMap[attrId] = sortIndex
		end

		self._sortAttrIdMap = self._sortAttrIdMap or {}
		self._sortAttrIdMap[careerId] = sortAttrMap
	end

	return sortAttrMap and sortAttrMap[attrId] or 0
end

function Rouge2_CareerConfig:getCareerRecommendAttributeIds(careerId)
	local recommendAttrList = self._recommendAttrMap and self._recommendAttrMap[careerId]

	if not recommendAttrList then
		self._recommendAttrMap = self._recommendAttrMap or {}

		local careerCo = self:getCareerConfig(careerId)
		local recommendAttrStr = careerCo and careerCo.recommendAttribute or ""

		recommendAttrList = string.splitToNumber(recommendAttrStr, "|") or {}
		self._recommendAttrMap[careerId] = recommendAttrList
	end

	return recommendAttrList
end

function Rouge2_CareerConfig:isAttrRecommend(careerId, attrId)
	local recommendIds = self:getCareerRecommendAttributeIds(careerId)

	return recommendIds and tabletool.indexOf(recommendIds, attrId)
end

function Rouge2_CareerConfig:getCareerRecommendTeamStr(careerId)
	local careerCo = self:getCareerConfig(careerId)

	return careerCo and careerCo.recommendTeam
end

function Rouge2_CareerConfig:getAllCareerConfigs()
	return lua_rouge2_career.configList
end

function Rouge2_CareerConfig:getCareerPassiveSkillIdMap(careerId)
	local passiveSkillMap = self._carrerId2PassiveIdMap and self._carrerId2PassiveIdMap[careerId]

	if not passiveSkillMap then
		logError(string.format("肉鸽职业没有特性技能 careerId = %s", careerId))
	end

	return passiveSkillMap
end

function Rouge2_CareerConfig:getCareerPassiveSkillId(careerId, attributeId)
	local skillMap = self:getCareerPassiveSkillIdMap(careerId)
	local skillId = skillMap and skillMap[attributeId]

	if not skillId then
		logError(string.format("肉鸽职业属性特性技能不存在 careerId = %s, attributeId = %s", careerId, attributeId))
	end

	return skillId
end

function Rouge2_CareerConfig:getCareerActiveSkillIds(careerId)
	local activeSkills = self._careerId2ActiveSkillMap and self._careerId2ActiveSkillMap[careerId]

	if not activeSkills then
		logError(string.format("肉鸽职业没有主动技能 careerId = %s", careerId))
	end

	return activeSkills
end

function Rouge2_CareerConfig:getCareerInitialColletions(careerId)
	local careerCo = self:getCareerConfig(careerId)

	if not careerCo then
		return {}
	end

	return string.splitToNumber(careerCo.initialColletions, "#")
end

function Rouge2_CareerConfig:getDiceCheckConfig(checkId, checkResult)
	local checkList = lua_rouge2_dice_check.configDict[checkId]
	local checkCo = checkList and checkList[checkResult]

	if not checkCo then
		logError(string.format("肉鸽检定配置不存在 checkId = %s, checkResult = %s", checkId, checkResult))
	end

	return checkCo
end

function Rouge2_CareerConfig:getDicePointList(diceId)
	local diceCo = lua_rouge2_dice.configDict[diceId]

	if not diceCo then
		logError(string.format("肉鸽骰子配置不存在 diceId = %s", diceId))
	end

	local pointList = diceCo and GameUtil.splitString2(diceCo.point, true)

	return pointList
end

function Rouge2_CareerConfig:getTalentConfig(talentId)
	local talentCo = lua_fight_rouge2_summoner.configDict[talentId]

	if not talentCo then
		logError(string.format("肉鸽局内天赋点配置不存在 talentId = %s", talentId))
	end

	return talentCo
end

function Rouge2_CareerConfig:getTalentListByType(talentType)
	local talentList = self._type2TalentList and self._type2TalentList[talentType]

	return talentList
end

function Rouge2_CareerConfig:getPreTalentList(talentId)
	local preTalentList = self._preTalentMap and self._preTalentMap[talentId]

	return preTalentList
end

function Rouge2_CareerConfig:getNextTalentList(talentId)
	local nextTalentList = self._nextTalentMap and self._nextTalentMap[talentId]

	return nextTalentList
end

function Rouge2_CareerConfig:getTalentConfigByHoleIndex(index)
	return self._holeIndex2TalentMap and self._holeIndex2TalentMap[index]
end

function Rouge2_CareerConfig:getTalentConfigsByStage(stage)
	return self._stage2TalentList and self._stage2TalentList[stage]
end

function Rouge2_CareerConfig:getAllStageTalentConfigs()
	return self._stage2TalentList
end

function Rouge2_CareerConfig:getTalentIcon(talentId, status)
	local status2UrlMap = self._talentIconUrlMap and self._talentIconUrlMap[talentId]
	local iconUrl = status2UrlMap and status2UrlMap[status]

	if string.nilorempty(iconUrl) then
		logError(string.format("天赋点图标配置不存在 talentId = %s, status = %s", talentId, status))
	end

	return iconUrl
end

function Rouge2_CareerConfig:getTalentTransformIdList()
	if not self._talentTransformIdList then
		local talentIdStr = lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.TalentResetIds].value

		self._talentTransformIdList = string.splitToNumber(talentIdStr, "#") or {}
	end

	return self._talentTransformIdList
end

function Rouge2_CareerConfig:getSystemConfig(systemId)
	local systemCo = systemId and lua_rouge2_system.configDict[systemId]

	if not systemCo then
		logError(string.format("肉鸽配队体系配置不存在 systemId = %s", systemId))
	end

	return systemCo
end

function Rouge2_CareerConfig:getCareerRecommendTeamList(careerId)
	local recommendIdLsit = self._careerId2RecommendTeamMap and self._careerId2RecommendTeamMap[careerId]

	return recommendIdLsit
end

function Rouge2_CareerConfig:getBattleTagConfigBySystemId(systemId)
	local battleTag = systemId and HeroConfig.instance:getBattleTagConfigCO(tostring(systemId))

	if not battleTag then
		logError(string.format("肉鸽战斗标签配置不存在 systemId = %s", systemId))
	end

	return battleTag
end

Rouge2_CareerConfig.instance = Rouge2_CareerConfig.New()

return Rouge2_CareerConfig
