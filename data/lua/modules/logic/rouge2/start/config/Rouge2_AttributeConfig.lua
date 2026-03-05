-- chunkname: @modules/logic/rouge2/start/config/Rouge2_AttributeConfig.lua

module("modules.logic.rouge2.start.config.Rouge2_AttributeConfig", package.seeall)

local Rouge2_AttributeConfig = class("Rouge2_AttributeConfig", BaseConfig)

function Rouge2_AttributeConfig:onInit()
	return
end

function Rouge2_AttributeConfig:reqConfigNames()
	return {
		"rouge2_attribute",
		"rouge2_passive_skill",
		"rouge2_attr_drop"
	}
end

function Rouge2_AttributeConfig:onConfigLoaded(configName, configTable)
	if configName == "rouge2_attribute" then
		self:_onLoadAttributeConfigs(configTable)
	elseif configName == "rouge2_passive_skill" then
		self:_onLoadPassiveSkillConfigs(configTable)
	elseif configName == "rouge2_attr_drop" then
		self:_onLoadAttrDropConfigs(configTable)
	end
end

function Rouge2_AttributeConfig:_onLoadAttributeConfigs(configTable)
	self._id2LevelList = {}
	self._type2AttributeList = {}

	for _, attributeCo in ipairs(configTable.configList) do
		local type = attributeCo.type

		self._type2AttributeList[type] = self._type2AttributeList[type] or {}

		table.insert(self._type2AttributeList[type], attributeCo)

		local attrId = attributeCo.id

		self._id2LevelList[attrId] = GameUtil.splitString2(attributeCo.level)
	end

	for _, attributeList in pairs(self._type2AttributeList) do
		table.sort(attributeList, function(aCo, bCo)
			return aCo.level < bCo.level
		end)
	end

	for _, levelList in pairs(self._id2LevelList) do
		table.sort(levelList, function(aLevel, bLevel)
			return aLevel[1] < bLevel[2]
		end)
	end
end

function Rouge2_AttributeConfig:_onLoadPassiveSkillConfigs(configTable)
	self._skillId2SkillList = {}
	self._skillId2SpSkillList = {}

	for _, skillCo in ipairs(configTable.configList) do
		local skillId = skillCo.id

		self._skillId2SkillList[skillId] = self._skillId2SkillList[skillId] or {}

		table.insert(self._skillId2SkillList[skillId], skillCo)

		local isSp = skillCo.isSpecial ~= 0

		if isSp then
			self._skillId2SpSkillList[skillId] = self._skillId2SpSkillList[skillId] or {}

			table.insert(self._skillId2SpSkillList[skillId], skillCo)
		end
	end

	for _, skillList in pairs(self._skillId2SkillList) do
		table.sort(skillList, self._sortSkillByLevel)
	end

	for _, skillList in pairs(self._skillId2SpSkillList) do
		table.sort(skillList, self._sortSkillByLevel)
	end
end

function Rouge2_AttributeConfig._sortSkillByLevel(aSkill, bSkill)
	local aLevel = aSkill.level
	local bLevel = bSkill.level

	if aLevel ~= bLevel then
		return aLevel < bLevel
	end

	return aSkill.id < bSkill.id
end

function Rouge2_AttributeConfig:_onLoadAttrDropConfigs(configTable)
	self._attrId2DropList = {}

	for _, dropCo in ipairs(configTable.configList) do
		local careerId = dropCo.career
		local attrDropList = self._attrId2DropList[careerId] or {}

		self._attrId2DropList[careerId] = attrDropList

		local attrId = dropCo.attr

		attrDropList[attrId] = attrDropList[attrId] or {}

		table.insert(attrDropList[attrId], dropCo)
	end

	for _, attrDropList in pairs(self._attrId2DropList) do
		for _, dropList in pairs(attrDropList) do
			table.sort(dropList, self._attrDropConfigSortFunc)
		end
	end
end

function Rouge2_AttributeConfig._attrDropConfigSortFunc(aDropCo, bDropCo)
	local aLevel = aDropCo.level
	local bLevel = bDropCo.level

	if aLevel ~= bLevel then
		return aLevel < bLevel
	end

	local aNeedNum = aDropCo.needNum
	local bNeedNum = bDropCo.needNum

	if aNeedNum ~= bNeedNum then
		return aNeedNum < bNeedNum
	end

	return aDropCo.id < bDropCo.id
end

function Rouge2_AttributeConfig:getAttributeConfig(attrId)
	attrId = tonumber(attrId)

	local attributeCo = lua_rouge2_attribute.configDict[attrId]

	if not attributeCo then
		logError(string.format("肉鸽属性配置为空 attributeId = %s", attrId))

		return
	end

	return attributeCo
end

function Rouge2_AttributeConfig:getAttrConfigListByType(attrType)
	return self._type2AttributeList and self._type2AttributeList[attrType]
end

function Rouge2_AttributeConfig:getPassiveSkillConfig(skillId, level)
	level = level or 1

	local skillCoDict = lua_rouge2_passive_skill.configDict[skillId]
	local skillCo = skillCoDict and skillCoDict[level]

	if not skillCo then
		logError(string.format("肉鸽特性技能配置为空 skillId = %s, level = %s", skillId, level))
	end

	return skillCo
end

function Rouge2_AttributeConfig:attrIdAndValue2LevelConfig(attrId, attrValue)
	local levelList = self._id2LevelList and self._id2LevelList[tonumber(attrId)]

	if not levelList or #levelList <= 0 then
		logError(string.format("肉鸽属性评级文本配置不存在 attributeId = %s, attributeValue = %s", attrId, attrValue))

		return
	end

	local targetCo

	for _, levelCo in ipairs(levelList) do
		if attrValue < levelCo[1] then
			break
		end

		targetCo = levelCo
	end

	return targetCo
end

function Rouge2_AttributeConfig:getAttributeEffectDescList(attrId, attrValue)
	local levelCo = self:attrIdAndValue2LevelConfig(attrId, attrValue)
	local desc = levelCo and levelCo[3]

	return desc
end

function Rouge2_AttributeConfig:getAttributeLevelKeyworld(attrId, attrValue)
	local levelCo = self:attrIdAndValue2LevelConfig(attrId, attrValue)
	local level = levelCo and levelCo[2]

	return level
end

function Rouge2_AttributeConfig:getAttributeLevelContent(attrId, attrValue)
	local levelCo = self:attrIdAndValue2LevelConfig(attrId, attrValue)
	local level = levelCo and levelCo[3]

	return level
end

function Rouge2_AttributeConfig:getCareerPassiveSkill(careerId, attrId, level)
	local skillId = Rouge2_CareerConfig.instance:getCareerPassiveSkillId(careerId, attrId)

	return skillId and self:getPassiveLevelSkillCo(skillId, level)
end

function Rouge2_AttributeConfig:getPassiveLevelSkillCo(passiveSkillId, level)
	local skillMap = lua_rouge2_passive_skill.configDict[passiveSkillId]
	local skillCo = skillMap and skillMap[level]

	if not skillCo then
		logError(string.format("肉鸽特性技能配置不存在 passiveSkillId = %s, level = %s", passiveSkillId, level))
	end

	return skillCo
end

function Rouge2_AttributeConfig:getPassiveSkillCommonDesc(careerId, attrId, level)
	local skillCo = self:getCareerPassiveSkill(careerId, attrId, level)
	local descStr = skillCo and skillCo.desc or ""

	if string.nilorempty(descStr) then
		return
	end

	local descList = string.split(descStr, "|")
	local resultDescList = {}

	for _, desc in ipairs(descList) do
		local resultDesc = Rouge2_ItemExpressionHelper.getDescResult(nil, nil, desc)

		table.insert(resultDescList, resultDesc)
	end

	return resultDescList
end

function Rouge2_AttributeConfig:getPassiveSkillEffectDescList(careerId, attrId, level)
	local skillCo = self:getCareerPassiveSkill(careerId, attrId, level)
	local effectDesc = skillCo and skillCo.effectDesc or ""

	if string.nilorempty(effectDesc) then
		return
	end

	local effectDescList = string.split(effectDesc, "|")
	local resultDescList = {}

	for _, desc in ipairs(effectDescList) do
		local resultDesc = Rouge2_ItemExpressionHelper.getDescResult(nil, nil, desc)

		table.insert(resultDescList, resultDesc)
	end

	return resultDescList
end

function Rouge2_AttributeConfig:getPassiveSkillDescList(careerId, attrId, level)
	local descList = {}
	local commonDescList = self:getPassiveSkillCommonDesc(careerId, attrId, level)
	local effectDescList = self:getPassiveSkillEffectDescList(careerId, attrId, level)

	tabletool.addValues(descList, commonDescList)
	tabletool.addValues(descList, effectDescList)

	return descList
end

function Rouge2_AttributeConfig:getPassiveSkillDescListByType(careerId, attrId, level, descType)
	local filedName = Rouge2_Enum.PassiveSkillDescType2FieldName[descType]
	local skillCo = self:getCareerPassiveSkill(careerId, attrId, level)
	local descStr = skillCo and skillCo[filedName]

	if not descStr then
		logError(string.format("肉鸽特性技能描述字段不存在 careerId = %s, attrId = %s, level = %s, descType = %s,", careerId, attrId, level, descType))

		return
	end

	if string.nilorempty(descStr) then
		return
	end

	local descList = string.split(descStr, "|")
	local resultDescList = {}

	for _, desc in ipairs(descList) do
		local resultDesc = Rouge2_ItemExpressionHelper.getDescResult(nil, nil, desc)

		table.insert(resultDescList, resultDesc)
	end

	return resultDescList
end

function Rouge2_AttributeConfig:getPassiveSkillUpDescList(careerId, attrId, level)
	local descList = {}
	local skillCo = self:getCareerPassiveSkill(careerId, attrId, level)
	local upDescStr = skillCo and skillCo.upDesc or ""

	if not string.nilorempty(upDescStr) then
		local upDescList = string.split(upDescStr, "|")

		tabletool.addValues(descList, upDescList)
	end

	local levelUpDesc = skillCo.ImLevelUpDesc

	if not string.nilorempty(levelUpDesc) then
		local levelUpDescList = string.split(levelUpDesc, "|")

		tabletool.addValues(descList, levelUpDescList)
	end

	return descList
end

function Rouge2_AttributeConfig:getCareerPassiveSkillList(careerId, attrId)
	local skillId = Rouge2_CareerConfig.instance:getCareerPassiveSkillId(careerId, attrId)
	local skillList = self._skillId2SkillList and self._skillId2SkillList[skillId]

	return skillList
end

function Rouge2_AttributeConfig:getCareerPassiveSkillList_Sp(careerId, attrId)
	local skillId = Rouge2_CareerConfig.instance:getCareerPassiveSkillId(careerId, attrId)
	local skillList = self._skillId2SpSkillList and self._skillId2SpSkillList[skillId]

	return skillList
end

function Rouge2_AttributeConfig:getPassiveSkillImLevelUpDesc(skillId, level)
	local skillCo = self:getPassiveSkillConfig(skillId, level)
	local imLevelUpDescList = string.split(skillCo.imLevelUpDesc, "|") or {}
	local imLevelUpDescStr = table.concat(imLevelUpDescList, "\n")

	return imLevelUpDescStr
end

function Rouge2_AttributeConfig:getAttrMaxValue(attrId)
	local attrCo = self:getAttributeConfig(attrId)

	return attrCo and attrCo.showMax or 0
end

function Rouge2_AttributeConfig:getAttrDropConfig(dropId)
	local dropCo = lua_rouge2_attr_drop.configDict[dropId]

	if not dropCo then
		logError(string.format("肉鸽属性掉落配置不存在 dropId = %s", dropId))
	end

	return dropCo
end

function Rouge2_AttributeConfig:getAttrDropList(careerId, attrId)
	local attrList = self._attrId2DropList and self._attrId2DropList[careerId]

	return attrList and attrList[attrId]
end

function Rouge2_AttributeConfig:getAttrDropListByAttrValue(careerId, attrId, attrValue)
	attrValue = attrValue or 0

	local allDropList = self:getAttrDropList(careerId, attrId)

	if allDropList then
		local dropList = {}

		for _, dropCo in ipairs(allDropList) do
			if attrValue < dropCo.needNum then
				break
			end

			table.insert(dropList, dropCo)
		end

		return dropList
	end
end

function Rouge2_AttributeConfig:getAttrDropConfigByAttrValue(careerId, attrId, attrValue)
	attrValue = attrValue or 0

	local allDropList = self:getAttrDropList(careerId, attrId)

	if allDropList then
		for _, dropCo in ipairs(allDropList) do
			if dropCo.needNum == attrValue then
				return dropCo
			end
		end
	end
end

function Rouge2_AttributeConfig:getNextAttrDropConfig(careerId, attrId, attrValue)
	attrValue = attrValue or 0

	local allDropList = self:getAttrDropList(careerId, attrId)

	if allDropList then
		for _, dropCo in ipairs(allDropList) do
			if attrValue < dropCo.needNum then
				return dropCo
			end
		end
	end
end

function Rouge2_AttributeConfig:getIndexAttrDropConfig(careerId, attrId, index)
	index = index or 1

	local dropConfigList = self:getAttrDropList(careerId, attrId)

	return dropConfigList and dropConfigList[index]
end

Rouge2_AttributeConfig.instance = Rouge2_AttributeConfig.New()

return Rouge2_AttributeConfig
