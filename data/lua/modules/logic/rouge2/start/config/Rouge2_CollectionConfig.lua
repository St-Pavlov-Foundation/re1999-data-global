-- chunkname: @modules/logic/rouge2/start/config/Rouge2_CollectionConfig.lua

module("modules.logic.rouge2.start.config.Rouge2_CollectionConfig", package.seeall)

local Rouge2_CollectionConfig = class("Rouge2_CollectionConfig", BaseConfig)

function Rouge2_CollectionConfig:onInit()
	return
end

function Rouge2_CollectionConfig:reqConfigNames()
	return {
		"rouge2_relics",
		"rouge2_active_skill",
		"rouge2_buff",
		"rouge2_tag",
		"rouge2_quality",
		"rouge2_relics_attr"
	}
end

function Rouge2_CollectionConfig:onConfigLoaded(configName, configTable)
	if configName == "rouge2_tag" then
		self:_onLoadedTagConfigs(configTable)
	elseif configName == "rouge2_relics_attr" then
		self:_onLoadedAttrConfigs(configTable)
	elseif configName == "rouge2_relics" then
		self:_onLoadRelicsConfigs(configTable)
	end
end

function Rouge2_CollectionConfig:_onLoadedTagConfigs(configTable)
	self._baseTagList = {}
	self._extraTagList = {}

	for _, tagCo in ipairs(configTable.configList) do
		if tagCo.id < Rouge2_OutsideEnum.MinCollectionExtraTagID then
			table.insert(self._baseTagList, tagCo)
		else
			table.insert(self._extraTagList, tagCo)
		end
	end
end

function Rouge2_CollectionConfig:_onLoadedAttrConfigs(configTable)
	self._flagName2ConfigMap = {}

	for _, flagCo in ipairs(configTable.configList) do
		local flagName = flagCo.flag

		if self._flagName2ConfigMap[flagName] then
			logNormal(string.format("肉鸽构筑物属性表配置错误, 存在相同的flag, id = %s, flag = %s", flagCo.id, flagCo.flag))
		else
			self._flagName2ConfigMap[flagName] = flagCo
		end
	end
end

function Rouge2_CollectionConfig:_onLoadRelicsConfigs(configTable)
	self._attr2RelicsMap = {}
	self._updateId2BaseRelicsMap = {}

	for _, relicsCo in ipairs(configTable.configList) do
		local attrUpdate = relicsCo.attrUpdate

		if not string.nilorempty(attrUpdate) then
			local attrUpdateInfo = string.splitToNumber(attrUpdate, "#")
			local attrId = attrUpdateInfo[1] or 0
			local attrValue = attrUpdateInfo[2] or 0

			self._attr2RelicsMap[attrId] = self._attr2RelicsMap[attrId] or {}

			table.insert(self._attr2RelicsMap[attrId], {
				attrValue = attrValue,
				config = relicsCo
			})

			local updateId = relicsCo.updateId

			if updateId and updateId ~= 0 then
				self._updateId2BaseRelicsMap[updateId] = relicsCo.id
			end
		end
	end

	for _, relicsList in pairs(self._attr2RelicsMap) do
		table.sort(relicsList, self._relicsSortFunc)
	end
end

function Rouge2_CollectionConfig._relicsSortFunc(aInfo, bInfo)
	local aAttrValue = aInfo.attrValue
	local bAttrValue = bInfo.attrValue

	if aAttrValue ~= bAttrValue then
		return aAttrValue < bAttrValue
	end

	local aRelicsCo = aInfo.config
	local bRelcisCo = bInfo.config
	local aRelicsRare = aRelicsCo and aRelicsCo.rare or 0
	local bRelicsRare = bRelcisCo and bRelcisCo.rare or 0

	if aRelicsRare ~= bRelicsRare then
		return aRelicsRare < bRelicsRare
	end

	return aRelicsCo.id < bRelcisCo.id
end

function Rouge2_CollectionConfig:getRelicsConfig(relicsId)
	local relicsCo = relicsId and lua_rouge2_relics.configDict[relicsId]

	if not relicsCo then
		logNormal(string.format("肉鸽造物配置不存在 relicsId = %s", relicsId))
	end

	return relicsCo
end

function Rouge2_CollectionConfig:getRelicsTagIds(relicsId)
	local relicsCo = self:getRelicsConfig(relicsId)
	local tagIdStr = relicsCo and relicsCo.tag or ""

	return string.splitToNumber(tagIdStr, "#")
end

function Rouge2_CollectionConfig:getActiveSkillConfig(skillId)
	local skillCo = skillId and lua_rouge2_active_skill.configDict[skillId]

	if not skillCo then
		logNormal(string.format("肉鸽主动技能配置不存在 skillId = %s", skillId))
	end

	return skillCo
end

function Rouge2_CollectionConfig:getAllTags()
	return lua_rouge2_tag.configList
end

function Rouge2_CollectionConfig:getTagConfig(tagId)
	local tagCo = lua_rouge2_tag.configDict[tagId]

	if not tagCo then
		logNormal(string.format("肉鸽构造物标签配置不存在 tagId = %s", tagId))
	end

	return tagCo
end

function Rouge2_CollectionConfig:getBuffConfig(buffId)
	local buffCo = lua_rouge2_buff.configDict[buffId]

	if not buffCo then
		logNormal(string.format("肉鸽谐波配置不存在 buffId = %s", buffId))
	end

	return buffCo
end

function Rouge2_CollectionConfig:getCollectionName(collectionId)
	local relicsCo = self:getRelicsConfig(collectionId)

	return relicsCo and relicsCo.name
end

function Rouge2_CollectionConfig:getRareConfig(rareId)
	local rareCo = lua_rouge2_quality.configDict[rareId]

	if not rareCo then
		logNormal(string.format("肉鸽品质配置不存在 rareId = %s", rareId))
	end

	return rareCo
end

function Rouge2_CollectionConfig:getRareName(rareId)
	local rareCo = self:getRareConfig(rareId)

	return rareCo and rareCo.name or ""
end

function Rouge2_CollectionConfig:getCollectionBaseTags()
	return self._baseTagList
end

function Rouge2_CollectionConfig:getCollectionExtraTags()
	return self._extraTagList
end

function Rouge2_CollectionConfig:getAttrMap()
	return lua_rouge2_relics_attr.configDict
end

function Rouge2_CollectionConfig:getAttrFlagConfigByName(flagName)
	local flagCo = self._flagName2ConfigMap and self._flagName2ConfigMap[flagName]

	if not flagCo then
		logNormal(string.format("肉鸽构筑物属性表配置不存在 flagName = %s", flagName))
	end

	return flagCo
end

function Rouge2_CollectionConfig:getAttrUpdateRelicsList(attrId)
	local relicsList = self._attr2RelicsMap[attrId]

	return relicsList
end

function Rouge2_CollectionConfig:getBaseRelicsId(updateId)
	local baseRelicsId = self._updateId2BaseRelicsMap and self._updateId2BaseRelicsMap[updateId]

	return baseRelicsId
end

Rouge2_CollectionConfig.instance = Rouge2_CollectionConfig.New()

return Rouge2_CollectionConfig
