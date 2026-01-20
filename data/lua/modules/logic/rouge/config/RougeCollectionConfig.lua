-- chunkname: @modules/logic/rouge/config/RougeCollectionConfig.lua

module("modules.logic.rouge.config.RougeCollectionConfig", package.seeall)

local RougeCollectionConfig = class("RougeCollectionConfig", BaseConfig)

function RougeCollectionConfig:onInit()
	self._baseBagShapCfgTab = {}

	self:LoadCollectionEditorConfig()
	self:buildCollectionEditorMap()
end

function RougeCollectionConfig:LoadCollectionEditorConfig()
	self._editorConfig = addGlobalModule("modules.configs.rouge.lua_rouge_collection_editor", "lua_rouge_collection_editor")
end

function RougeCollectionConfig:buildCollectionEditorMap()
	self._collectionEditorMap = {}
	self._interactCollectionMap = {}

	if self._editorConfig then
		for _, v in ipairs(self._editorConfig) do
			if self._collectionEditorMap[v.id] then
				logError("解析肉鸽造物表 << lua_rouge_collection_editor.lua >> 出错!!! 出错原因:存在重复的造物id :" .. tostring(v.id))
			end

			self._collectionEditorMap[v.id] = v

			if v.interactable then
				self._interactCollectionMap[v.id] = v
			end
		end
	end
end

function RougeCollectionConfig:getAllCollections()
	return self._collectionEditorMap
end

function RougeCollectionConfig:getAllInteractCollections()
	return self._interactCollectionMap
end

function RougeCollectionConfig:getCollectionCfg(collectionId)
	local config = self._collectionEditorMap and self._collectionEditorMap[collectionId]

	if not config then
		logError("无法找到肉鸽造物配置:id = " .. tostring(collectionId))

		return
	end

	return config
end

function RougeCollectionConfig:getCollectionTags(collectionId)
	local co = self:getCollectionCfg(collectionId)

	return co and co.tags
end

function RougeCollectionConfig:getCollectionHoleNum(collectionId)
	local co = self:getCollectionCfg(collectionId)

	return co and co.holeNum
end

function RougeCollectionConfig:getAllCollectionCfgs()
	return self._editorConfig
end

function RougeCollectionConfig:reqConfigNames()
	return {
		"rouge_desc",
		"rouge_tag",
		"rogue_collection_backpack",
		"rouge_synthesis",
		"rouge_extra_desc",
		"rouge_attr",
		"rouge_quality",
		"rouge_item_static_desc",
		"rouge_collection_unlock",
		"rouge_write_desc"
	}
end

function RougeCollectionConfig:onConfigLoaded(configName, configTable)
	if configName == "rouge_desc" then
		self:buildCollectionDescMap(configTable)
	elseif configName == "rouge_tag" then
		self:buildCollectionTagMap(configTable)
	elseif configName == "rogue_collection_backpack" then
		self:buildCollectionBackpackMap(configTable)
	elseif configName == "rouge_synthesis" then
		self:buildCollectionSynthesisMap(configTable)
	elseif configName == "rouge_attr" then
		self:buildCollectionAttrMap(configTable)
	elseif configName == "rouge_item_static_desc" then
		self:buildItemStaticDescMap(configTable)
	end
end

function RougeCollectionConfig:buildCollectionDescMap(configTable)
	self._collectionDescMap = {}
	self._collectionDescTab = configTable

	for i = 1, #configTable.configList do
		local cfg = configTable.configList[i]
		local id = cfg.id

		self._collectionDescMap[id] = self._collectionDescMap[id] or {}

		table.insert(self._collectionDescMap[id], cfg)
	end
end

function RougeCollectionConfig:getAllCollectionDescCfgs()
	return self._collectionDescTab and self._collectionDescTab.configList
end

function RougeCollectionConfig:getCollectionDescsCfg(collectionId)
	local descCfg = self._collectionDescMap and self._collectionDescMap[collectionId]

	if not descCfg then
		logError("无法找到造物描述配置,造物id = " .. tostring(collectionId))
	end

	return descCfg or {}
end

function RougeCollectionConfig:getCollectionEffectDescCfg(collectionId, effectId)
	local collectionEffectCfgs = self._collectionDescTab.configDict[collectionId]

	return collectionEffectCfgs and collectionEffectCfgs[effectId]
end

function RougeCollectionConfig:getCollectionName(collectionCfgId, enchantCfgIds)
	local baseCollectionName = self:getCollectionNameWithColor(collectionCfgId)
	local fullName = {
		baseCollectionName
	}

	if enchantCfgIds then
		for _, enchantCfgId in ipairs(enchantCfgIds) do
			if enchantCfgId and enchantCfgId > 0 then
				local extraCfg = lua_rouge_extra_desc.configDict[enchantCfgId]
				local extraName = extraCfg and extraCfg.name

				if not string.nilorempty(extraName) then
					local enchantCfg = RougeCollectionConfig.instance:getCollectionCfg(enchantCfgId)
					local showRare = enchantCfg and enchantCfg.showRare or 0
					local rareColor = self:getCollectionRareColor(showRare)
					local resultExtraName = string.format("<#%s>%s</color>", rareColor, extraName)

					table.insert(fullName, resultExtraName)
				end
			end
		end
	end

	local fullNameStr = table.concat(fullName, "")

	return fullNameStr
end

function RougeCollectionConfig:getCollectionNameWithColor(collectionCfgId)
	local descCfg = self:getCollectionDescsCfg(collectionCfgId)
	local collectionCfg = self:getCollectionCfg(collectionCfgId)

	if not descCfg or not collectionCfg then
		return
	end

	local collectionName = descCfg and descCfg[1].name or ""
	local rareColor = self:getCollectionRareColor(collectionCfg.showRare)
	local resultName = string.format("<#%s>%s</color>", rareColor, collectionName)

	return resultName
end

local defaultCollectionRareColor = "#FFFFFF"

function RougeCollectionConfig:getCollectionRareColor(rare)
	local rareCfg = lua_rouge_quality.configDict[rare]

	if not rareCfg then
		logError("无法找到造物品质配置,造物品质id = " .. tostring(rare))

		return defaultCollectionRareColor
	end

	local color = rareCfg.rareColor or defaultCollectionRareColor

	return color
end

function RougeCollectionConfig:buildCollectionTagMap(configTable)
	self._collectionTagTab = configTable
	self._baseTagList = {}
	self._extraTagList = {}
	self._allTagList = {}

	for _, tagCfg in ipairs(configTable.configList) do
		if tagCfg.id < RougeEnum.MinCollectionExtraTagID then
			table.insert(self._baseTagList, tagCfg)
		else
			table.insert(self._extraTagList, tagCfg)
		end

		self._allTagList[tagCfg.id] = tagCfg
	end
end

function RougeCollectionConfig:buildCollectionBackpackMap(configTable)
	self._collectionBackpackTab = configTable
	self._collectionBackpackSizeMap = {}
	self._initialCollectionMap = {}

	if configTable and configTable.configDict then
		for id, backpackCfg in pairs(configTable.configDict) do
			local bagSize = string.split(backpackCfg.layout, "#")

			self._collectionBackpackSizeMap[id] = {
				col = tonumber(bagSize[1]),
				row = tonumber(bagSize[2])
			}

			local initialCollections = GameUtil.splitString2(backpackCfg.initialCollection, true)

			if initialCollections then
				local collections = {}

				for _, collectionCfg in ipairs(initialCollections) do
					local row = collectionCfg[3]
					local col = collectionCfg[4]
					local result = {
						cfgId = collectionCfg[1],
						rotation = collectionCfg[2],
						pos = {
							row = row,
							col = col
						}
					}

					table.insert(collections, result)
				end

				self._initialCollectionMap[id] = collections
			end
		end
	end
end

function RougeCollectionConfig:getCollectionBackpackCfg(bagId)
	local bagCo = self._collectionBackpackTab and self._collectionBackpackTab.configDict[bagId]

	if not bagCo then
		logError("找不到流派初始背包配置, 背包id = " .. tostring(bagId))
	end

	return bagCo
end

function RougeCollectionConfig:getCollectionInitialBagSize(bagId)
	local bagSize = self._collectionBackpackSizeMap and self._collectionBackpackSizeMap[bagId]

	if not bagSize then
		logError("找不到初始背包大小配置, 背包id = " .. tostring(bagId))
	end

	return bagSize
end

function RougeCollectionConfig:getStyleCollectionBagSize(season, style)
	local styleCfg = lua_rouge_style.configDict[season][style]
	local layoutId = styleCfg and styleCfg.layoutId
	local bagSize = RougeCollectionConfig.instance:getCollectionInitialBagSize(layoutId)

	return bagSize
end

function RougeCollectionConfig:getStyleInitialCollections(bagId)
	return self._initialCollectionMap and self._initialCollectionMap[bagId]
end

function RougeCollectionConfig:buildCollectionSynthesisMap(configTable)
	self._collectionSynthesisTab = configTable
	self._synthesisMap = {}

	for i, v in ipairs(lua_rouge_synthesis.configList) do
		self._synthesisMap[v.product] = true
	end
end

function RougeCollectionConfig:canSynthesized(productId)
	return self._synthesisMap and self._synthesisMap[productId]
end

function RougeCollectionConfig:getCollectionSynthesisList()
	return self._collectionSynthesisTab and self._collectionSynthesisTab.configList
end

function RougeCollectionConfig:getCollectionCompositeIds(synthesisCfgId)
	local result = self._collectionCompositeMap and self._collectionCompositeMap[synthesisCfgId]

	if not result then
		local synthesisCfg = self._collectionSynthesisTab.configDict[synthesisCfgId]

		if not synthesisCfg then
			return
		end

		local synthetics = string.split(synthesisCfg.synthetics, "#")

		result = {}

		for _, synthetic in ipairs(synthetics) do
			table.insert(result, tonumber(synthetic))
		end

		self._collectionCompositeMap = self._collectionCompositeMap or {}
		self._collectionCompositeMap[synthesisCfgId] = result
	end

	return result
end

function RougeCollectionConfig:getCollectionCompositeIdAndCount(synthesisCfgId)
	local idAndCountMap = self._composteIdAndCountMap and self._composteIdAndCountMap[synthesisCfgId]

	if not idAndCountMap then
		local compositeIds = self:getCollectionCompositeIds(synthesisCfgId)

		if compositeIds then
			idAndCountMap = {}

			for _, compositeId in ipairs(compositeIds) do
				local count = idAndCountMap[compositeId] or 0

				count = count + 1
				idAndCountMap[compositeId] = count
			end

			self._composteIdAndCountMap = self._composteIdAndCountMap or {}
			self._composteIdAndCountMap[synthesisCfgId] = idAndCountMap
		end
	end

	return idAndCountMap
end

function RougeCollectionConfig:buildCollectionAttrMap(configTable)
	self._collectionAttrTab = configTable
	self._collectionAttrFlagMap = {}

	if configTable then
		for _, cfg in ipairs(configTable.configList) do
			local flag = cfg.flag

			if self._collectionAttrFlagMap[flag] then
				logError("肉鸽造物属性表存在相同的Flag, Flag = " .. tostring(flag))
			end

			self._collectionAttrFlagMap[flag] = cfg
		end
	end
end

function RougeCollectionConfig:getAllCollectionAttrMap()
	return self._collectionAttrTab and self._collectionAttrTab.configDict
end

function RougeCollectionConfig:getCollectionAttrCfg(attrId)
	local attrDict = self:getAllCollectionAttrMap()

	return attrDict[attrId]
end

function RougeCollectionConfig:getCollectionAttrByFlag(attrFlag)
	local cfg = self._collectionAttrFlagMap and self._collectionAttrFlagMap[attrFlag]

	if not cfg then
		logError(string.format("肉鸽造物静态属性Flag = %s 不存在", attrFlag))
	end

	return cfg
end

function RougeCollectionConfig:getCollectionShapeParam(collectionId)
	local collectionCfg = self:getCollectionCfg(collectionId)

	return collectionCfg and collectionCfg.shapeParam
end

function RougeCollectionConfig:getOriginEditorParam(collectionId, paramType)
	local params = self:getCollectionShapeParam(collectionId)

	return params and params[paramType]
end

local centerSlotPos = Vector2(0, 0)

function RougeCollectionConfig:getRotateEditorParam(collectionId, rotation, paramType)
	local originParam = self:getOriginEditorParam(collectionId, paramType)

	if not originParam then
		logError(string.format("找不到造物编辑器配置:造物id = %s, 配置类型 = %s", collectionId, paramType))

		return
	end

	if paramType == RougeEnum.CollectionEditorParamType.CenterPos then
		return originParam
	end

	local result
	local isMultiParam = self:isMultiParam(paramType)

	if isMultiParam then
		result = self:getRotateParamsResultInternal(originParam, centerSlotPos, rotation)
	else
		result = self:computeSlotPosAfterRotate(originParam, centerSlotPos, rotation)
	end

	return result
end

function RougeCollectionConfig:getRotateParamsResultInternal(shapeCfg, rotatePointPos, rotation)
	if shapeCfg then
		local rotateShapCfg = {}

		rotation = RougeCollectionHelper.getRotateAngleByRotation(rotation) * Mathf.PI / 180
		rotatePointPos = rotatePointPos or Vector2.zero

		for _, param in ipairs(shapeCfg) do
			local rotatePosition = self:computeSlotPosAfterRotate(param, rotatePointPos, rotation)

			table.insert(rotateShapCfg, rotatePosition)
		end

		return rotateShapCfg
	end
end

function RougeCollectionConfig:computeSlotPosAfterRotate(slotPos, rotatePointPos, rotateAngle)
	local posXBaseRotatePoint = slotPos.x - rotatePointPos.x
	local posYBaseRotatePoint = slotPos.y - rotatePointPos.y
	local cosAngleValue = Mathf.Cos(rotateAngle)
	local sinAngleValue = Mathf.Sin(rotateAngle)
	local rotatePositionX = posXBaseRotatePoint * cosAngleValue - posYBaseRotatePoint * sinAngleValue
	local rotatePositionY = posXBaseRotatePoint * sinAngleValue + posYBaseRotatePoint * cosAngleValue

	rotatePositionX = rotatePositionX + rotatePointPos.x + 0.5
	rotatePositionY = rotatePositionY + rotatePointPos.y + 0.5

	local rotatePosition = Vector2(math.floor(rotatePositionX), math.floor(rotatePositionY))

	return rotatePosition
end

function RougeCollectionConfig:isMultiParam(editorType)
	local isMultiParam = editorType == RougeEnum.CollectionEditorParamType.Shape or editorType == RougeEnum.CollectionEditorParamType.Effect

	return isMultiParam
end

function RougeCollectionConfig:getCollectionCellCount(collectionId, paramType)
	local params = self:getOriginEditorParam(collectionId, paramType)

	return params and #params or 0
end

function RougeCollectionConfig:getOrBuildCollectionShapeMap(collectionCfgId, rotation)
	self._collectionShapeMap = self._collectionShapeMap or {}

	local shapeMap = self._collectionShapeMap[collectionCfgId]
	local shapeAngleMap = shapeMap and shapeMap[rotation]

	if not shapeAngleMap then
		local shapeCfg = RougeCollectionConfig.instance:getRotateEditorParam(collectionCfgId, rotation, RougeEnum.CollectionEditorParamType.Shape)

		shapeAngleMap = {}

		for _, cell in ipairs(shapeCfg) do
			if not shapeAngleMap[cell.x] then
				shapeAngleMap[cell.x] = {}
			end

			shapeAngleMap[cell.x][cell.y] = true
		end

		self._collectionShapeMap[collectionCfgId] = self._collectionShapeMap[collectionCfgId] or {}
		self._collectionShapeMap[collectionCfgId][rotation] = shapeAngleMap
	end

	return shapeAngleMap
end

function RougeCollectionConfig:getCollectionBaseTags()
	return self._baseTagList
end

function RougeCollectionConfig:getCollectionExtraTags()
	return self._extraTagList
end

function RougeCollectionConfig:getTagConfig(id)
	return self._allTagList[id]
end

function RougeCollectionConfig:getShapeMatrix(collectionId, rotation)
	self._rotationMatrixMap = self._rotationMatrixMap or {}

	local matrixMap = self._rotationMatrixMap[collectionId]

	if not matrixMap then
		matrixMap = {}
		self._rotationMatrixMap[collectionId] = matrixMap
	end

	rotation = rotation or RougeEnum.CollectionRotation.Rotation_0

	local rotationMatrix = matrixMap[rotation]

	if not rotationMatrix then
		local params = self:getCollectionShapeParam(collectionId)
		local matrix = params and params.shapeMatrix

		rotationMatrix = self:getRotationMatrix(matrix, rotation)
		self._rotationMatrixMap[collectionId][rotation] = rotationMatrix
	end

	return rotationMatrix
end

function RougeCollectionConfig:getRotationMatrix(originMatrix, rotation)
	local rotationMatrix = {}
	local row = tabletool.len(originMatrix)
	local col = tabletool.len(originMatrix[1])

	if rotation == RougeEnum.CollectionRotation.Rotation_0 then
		rotationMatrix = originMatrix
	elseif rotation == RougeEnum.CollectionRotation.Rotation_90 then
		for i = 1, row do
			for j = 1, col do
				rotationMatrix[j] = rotationMatrix[j] or {}
				rotationMatrix[j][row - i + 1] = originMatrix[i][j]
			end
		end
	elseif rotation == RougeEnum.CollectionRotation.Rotation_180 then
		for i = 1, row do
			for j = 1, col do
				rotationMatrix[row - i + 1] = rotationMatrix[row - i + 1] or {}
				rotationMatrix[row - i + 1][col - j + 1] = originMatrix[i][j]
			end
		end
	elseif rotation == RougeEnum.CollectionRotation.Rotation_270 then
		for i = 1, row do
			for j = 1, col do
				rotationMatrix[col - j + 1] = rotationMatrix[col - j + 1] or {}
				rotationMatrix[col - j + 1][i] = originMatrix[i][j]
			end
		end
	else
		logError("旋转角度非法:rotation = " .. tostring(rotation))
	end

	return rotationMatrix
end

function RougeCollectionConfig:getShapeSize(collectionId)
	local params = self:getCollectionShapeParam(collectionId)
	local size = params and params.shapeSize

	if size then
		return size.x, size.y
	end
end

function RougeCollectionConfig:buildItemStaticDescMap(configTable)
	self._itemStaticDescTab = configTable
	self._itemAttrValueMap = {}
end

function RougeCollectionConfig:getAllItemStaticDescCfgs()
	return self._itemStaticDescTab and self._itemStaticDescTab.configList
end

function RougeCollectionConfig:getItemStaticDescCfg(collectionId)
	local cfg = self._itemStaticDescTab.configDict[collectionId]

	if not cfg then
		logError("找不到造物属性静态描述, 造物id = " .. tostring(collectionId))
	end

	return cfg
end

function RougeCollectionConfig:getCollectionStaticAttrValueMap(collectionId)
	if not collectionId then
		return
	end

	local attrValueMap = self._itemAttrValueMap[collectionId]

	if not attrValueMap then
		attrValueMap = {}

		local staticCfg = self:getItemStaticDescCfg(collectionId)

		if staticCfg then
			self:buildEnchantAttrMap(staticCfg.item1, staticCfg.item1_attr, attrValueMap)
			self:buildEnchantAttrMap(staticCfg.item2, staticCfg.item2_attr, attrValueMap)
			self:buildEnchantAttrMap(staticCfg.item3, staticCfg.item3_attr, attrValueMap)
		end

		self._itemAttrValueMap[collectionId] = attrValueMap
	end

	return attrValueMap
end

function RougeCollectionConfig:buildEnchantAttrMap(enchantId, attrStr, attrValueMap)
	enchantId = tonumber(enchantId)

	if enchantId and enchantId ~= 0 then
		local map = self:parseCollectionItemAttr(attrStr)

		if map then
			attrValueMap[enchantId] = map
		end
	end
end

function RougeCollectionConfig:parseCollectionItemAttr(str)
	local map = {}

	if not string.nilorempty(str) then
		local splitRes = GameUtil.splitString2(str)

		if splitRes then
			for _, part in ipairs(splitRes) do
				local attrName = part[1]
				local attrValue = tonumber(part[2])

				map[attrName] = attrValue
			end
		end
	end

	return map
end

function RougeCollectionConfig:getCollectioTagCo(tagId)
	local tagCo = lua_rouge_tag.configDict[tagId]

	if not tagCo then
		logError("无法找到造物标签配置:" .. tostring(tagId))
	end

	return tagCo
end

function RougeCollectionConfig:getCollectionOfficialDesc(collectionCfgId)
	local writeDescConfig = lua_rouge_write_desc.configDict[collectionCfgId]

	if not writeDescConfig then
		logError("无法找到造物文案描述，造物id = " .. tostring(collectionCfgId))

		return
	end

	return writeDescConfig.desc
end

RougeCollectionConfig.instance = RougeCollectionConfig.New()

return RougeCollectionConfig
