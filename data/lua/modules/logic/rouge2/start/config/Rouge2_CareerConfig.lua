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
		"rouge2_dice_check"
	}
end

function Rouge2_CareerConfig:onConfigLoaded(configName, configTable)
	if configName == "rouge2_career" then
		self:_onCareerConfigLoaded(configTable)
	elseif configName == "rouge2_career_transfer" then
		self:_onCareerTransferConfigLoaded(configTable)
	end
end

function Rouge2_CareerConfig:_onCareerConfigLoaded(configTable)
	self._carrerId2PassiveIdMap = {}
	self._careerId2ActiveSkillMap = {}
	self._careerId2AttributeIdMap = {}

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
	local careerCo = self:getCareerConfig(careerId)

	if not careerCo then
		return {}
	end

	return string.splitToNumber(careerCo.recommendAttribute, "|")
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

	return string.splitToNumber(careerCo.initialColletions, "|")
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

Rouge2_CareerConfig.instance = Rouge2_CareerConfig.New()

return Rouge2_CareerConfig
