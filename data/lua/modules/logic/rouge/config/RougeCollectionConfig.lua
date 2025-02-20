module("modules.logic.rouge.config.RougeCollectionConfig", package.seeall)

slot0 = class("RougeCollectionConfig", BaseConfig)

function slot0.onInit(slot0)
	slot0._baseBagShapCfgTab = {}

	slot0:LoadCollectionEditorConfig()
	slot0:buildCollectionEditorMap()
end

function slot0.LoadCollectionEditorConfig(slot0)
	slot0._editorConfig = addGlobalModule("modules.configs.rouge.lua_rouge_collection_editor", "lua_rouge_collection_editor")
end

function slot0.buildCollectionEditorMap(slot0)
	slot0._collectionEditorMap = {}
	slot0._interactCollectionMap = {}

	if slot0._editorConfig then
		for slot4, slot5 in ipairs(slot0._editorConfig) do
			if slot0._collectionEditorMap[slot5.id] then
				logError("解析肉鸽造物表 << lua_rouge_collection_editor.lua >> 出错!!! 出错原因:存在重复的造物id :" .. tostring(slot5.id))
			end

			slot0._collectionEditorMap[slot5.id] = slot5

			if slot5.interactable then
				slot0._interactCollectionMap[slot5.id] = slot5
			end
		end
	end
end

function slot0.getAllCollections(slot0)
	return slot0._collectionEditorMap
end

function slot0.getAllInteractCollections(slot0)
	return slot0._interactCollectionMap
end

function slot0.getCollectionCfg(slot0, slot1)
	if not (slot0._collectionEditorMap and slot0._collectionEditorMap[slot1]) then
		logError("无法找到肉鸽造物配置:id = " .. tostring(slot1))

		return
	end

	return slot2
end

function slot0.getCollectionTags(slot0, slot1)
	return slot0:getCollectionCfg(slot1) and slot2.tags
end

function slot0.getCollectionHoleNum(slot0, slot1)
	return slot0:getCollectionCfg(slot1) and slot2.holeNum
end

function slot0.getAllCollectionCfgs(slot0)
	return slot0._editorConfig
end

function slot0.reqConfigNames(slot0)
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

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "rouge_desc" then
		slot0:buildCollectionDescMap(slot2)
	elseif slot1 == "rouge_tag" then
		slot0:buildCollectionTagMap(slot2)
	elseif slot1 == "rogue_collection_backpack" then
		slot0:buildCollectionBackpackMap(slot2)
	elseif slot1 == "rouge_synthesis" then
		slot0:buildCollectionSynthesisMap(slot2)
	elseif slot1 == "rouge_attr" then
		slot0:buildCollectionAttrMap(slot2)
	elseif slot1 == "rouge_item_static_desc" then
		slot0:buildItemStaticDescMap(slot2)
	end
end

function slot0.buildCollectionDescMap(slot0, slot1)
	slot0._collectionDescMap = {}
	slot0._collectionDescTab = slot1

	for slot5 = 1, #slot1.configList do
		slot0._collectionDescMap[slot7] = slot0._collectionDescMap[slot1.configList[slot5].id] or {}

		table.insert(slot0._collectionDescMap[slot7], slot6)
	end
end

function slot0.getAllCollectionDescCfgs(slot0)
	return slot0._collectionDescTab and slot0._collectionDescTab.configList
end

function slot0.getCollectionDescsCfg(slot0, slot1)
	if not (slot0._collectionDescMap and slot0._collectionDescMap[slot1]) then
		logError("无法找到造物描述配置,造物id = " .. tostring(slot1))
	end

	return slot2 or {}
end

function slot0.getCollectionEffectDescCfg(slot0, slot1, slot2)
	return slot0._collectionDescTab.configDict[slot1] and slot3[slot2]
end

function slot0.getCollectionName(slot0, slot1, slot2)
	slot4 = {
		slot0:getCollectionNameWithColor(slot1)
	}

	if slot2 then
		for slot8, slot9 in ipairs(slot2) do
			if slot9 and slot9 > 0 and not string.nilorempty(lua_rouge_extra_desc.configDict[slot9] and slot10.name) then
				table.insert(slot4, string.format("<#%s>%s</color>", slot0:getCollectionRareColor(uv0.instance:getCollectionCfg(slot9) and slot12.showRare or 0), slot11))
			end
		end
	end

	return table.concat(slot4, "")
end

function slot0.getCollectionNameWithColor(slot0, slot1)
	slot3 = slot0:getCollectionCfg(slot1)

	if not slot0:getCollectionDescsCfg(slot1) or not slot3 then
		return
	end

	return string.format("<#%s>%s</color>", slot0:getCollectionRareColor(slot3.showRare), slot2 and slot2[1].name or "")
end

slot1 = "#FFFFFF"

function slot0.getCollectionRareColor(slot0, slot1)
	if not lua_rouge_quality.configDict[slot1] then
		logError("无法找到造物品质配置,造物品质id = " .. tostring(slot1))

		return uv0
	end

	return slot2.rareColor or uv0
end

function slot0.buildCollectionTagMap(slot0, slot1)
	slot0._collectionTagTab = slot1
	slot0._baseTagList = {}
	slot0._extraTagList = {}
	slot0._allTagList = {}

	for slot5, slot6 in ipairs(slot1.configList) do
		if slot6.id < RougeEnum.MinCollectionExtraTagID then
			table.insert(slot0._baseTagList, slot6)
		else
			table.insert(slot0._extraTagList, slot6)
		end

		slot0._allTagList[slot6.id] = slot6
	end
end

function slot0.buildCollectionBackpackMap(slot0, slot1)
	slot0._collectionBackpackTab = slot1
	slot0._collectionBackpackSizeMap = {}
	slot0._initialCollectionMap = {}

	if slot1 and slot1.configDict then
		for slot5, slot6 in pairs(slot1.configDict) do
			slot7 = string.split(slot6.layout, "#")
			slot0._collectionBackpackSizeMap[slot5] = {
				col = tonumber(slot7[1]),
				row = tonumber(slot7[2])
			}

			if GameUtil.splitString2(slot6.initialCollection, true) then
				slot9 = {}

				for slot13, slot14 in ipairs(slot8) do
					table.insert(slot9, {
						cfgId = slot14[1],
						rotation = slot14[2],
						pos = {
							row = slot14[3],
							col = slot14[4]
						}
					})
				end

				slot0._initialCollectionMap[slot5] = slot9
			end
		end
	end
end

function slot0.getCollectionBackpackCfg(slot0, slot1)
	if not (slot0._collectionBackpackTab and slot0._collectionBackpackTab.configDict[slot1]) then
		logError("找不到流派初始背包配置, 背包id = " .. tostring(slot1))
	end

	return slot2
end

function slot0.getCollectionInitialBagSize(slot0, slot1)
	if not (slot0._collectionBackpackSizeMap and slot0._collectionBackpackSizeMap[slot1]) then
		logError("找不到初始背包大小配置, 背包id = " .. tostring(slot1))
	end

	return slot2
end

function slot0.getStyleCollectionBagSize(slot0, slot1, slot2)
	return uv0.instance:getCollectionInitialBagSize(lua_rouge_style.configDict[slot1][slot2] and slot3.layoutId)
end

function slot0.getStyleInitialCollections(slot0, slot1)
	return slot0._initialCollectionMap and slot0._initialCollectionMap[slot1]
end

function slot0.buildCollectionSynthesisMap(slot0, slot1)
	slot0._collectionSynthesisTab = slot1
	slot0._synthesisMap = {}

	for slot5, slot6 in ipairs(lua_rouge_synthesis.configList) do
		slot0._synthesisMap[slot6.product] = true
	end
end

function slot0.canSynthesized(slot0, slot1)
	return slot0._synthesisMap and slot0._synthesisMap[slot1]
end

function slot0.getCollectionSynthesisList(slot0)
	return slot0._collectionSynthesisTab and slot0._collectionSynthesisTab.configList
end

function slot0.getCollectionCompositeIds(slot0, slot1)
	if not (slot0._collectionCompositeMap and slot0._collectionCompositeMap[slot1]) then
		if not slot0._collectionSynthesisTab.configDict[slot1] then
			return
		end

		slot2 = {}

		for slot8, slot9 in ipairs(string.split(slot3.synthetics, "#")) do
			table.insert(slot2, tonumber(slot9))
		end

		slot0._collectionCompositeMap = slot0._collectionCompositeMap or {}
		slot0._collectionCompositeMap[slot1] = slot2
	end

	return slot2
end

function slot0.getCollectionCompositeIdAndCount(slot0, slot1)
	if not (slot0._composteIdAndCountMap and slot0._composteIdAndCountMap[slot1]) and slot0:getCollectionCompositeIds(slot1) then
		slot2 = {}

		for slot7, slot8 in ipairs(slot3) do
			slot2[slot8] = (slot2[slot8] or 0) + 1
		end

		slot0._composteIdAndCountMap = slot0._composteIdAndCountMap or {}
		slot0._composteIdAndCountMap[slot1] = slot2
	end

	return slot2
end

function slot0.buildCollectionAttrMap(slot0, slot1)
	slot0._collectionAttrTab = slot1
	slot0._collectionAttrFlagMap = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1.configList) do
			if slot0._collectionAttrFlagMap[slot6.flag] then
				logError("肉鸽造物属性表存在相同的Flag, Flag = " .. tostring(slot7))
			end

			slot0._collectionAttrFlagMap[slot7] = slot6
		end
	end
end

function slot0.getAllCollectionAttrMap(slot0)
	return slot0._collectionAttrTab and slot0._collectionAttrTab.configDict
end

function slot0.getCollectionAttrCfg(slot0, slot1)
	return slot0:getAllCollectionAttrMap()[slot1]
end

function slot0.getCollectionAttrByFlag(slot0, slot1)
	if not (slot0._collectionAttrFlagMap and slot0._collectionAttrFlagMap[slot1]) then
		logError(string.format("肉鸽造物静态属性Flag = %s 不存在", slot1))
	end

	return slot2
end

function slot0.getCollectionShapeParam(slot0, slot1)
	return slot0:getCollectionCfg(slot1) and slot2.shapeParam
end

function slot0.getOriginEditorParam(slot0, slot1, slot2)
	return slot0:getCollectionShapeParam(slot1) and slot3[slot2]
end

slot2 = Vector2(0, 0)

function slot0.getRotateEditorParam(slot0, slot1, slot2, slot3)
	if not slot0:getOriginEditorParam(slot1, slot3) then
		logError(string.format("找不到造物编辑器配置:造物id = %s, 配置类型 = %s", slot1, slot3))

		return
	end

	if slot3 == RougeEnum.CollectionEditorParamType.CenterPos then
		return slot4
	end

	slot5 = nil

	return (not slot0:isMultiParam(slot3) or slot0:getRotateParamsResultInternal(slot4, uv0, slot2)) and slot0:computeSlotPosAfterRotate(slot4, uv0, slot2)
end

function slot0.getRotateParamsResultInternal(slot0, slot1, slot2, slot3)
	if slot1 then
		slot4 = {}

		for slot8, slot9 in ipairs(slot1) do
			table.insert(slot4, slot0:computeSlotPosAfterRotate(slot9, slot2 or Vector2.zero, RougeCollectionHelper.getRotateAngleByRotation(slot3) * Mathf.PI / 180))
		end

		return slot4
	end
end

function slot0.computeSlotPosAfterRotate(slot0, slot1, slot2, slot3)
	slot4 = slot1.x - slot2.x
	slot5 = slot1.y - slot2.y
	slot6 = Mathf.Cos(slot3)
	slot7 = Mathf.Sin(slot3)

	return Vector2(math.floor(slot4 * slot6 - slot5 * slot7 + slot2.x + 0.5), math.floor(slot4 * slot7 + slot5 * slot6 + slot2.y + 0.5))
end

function slot0.isMultiParam(slot0, slot1)
	return slot1 == RougeEnum.CollectionEditorParamType.Shape or slot1 == RougeEnum.CollectionEditorParamType.Effect
end

function slot0.getCollectionCellCount(slot0, slot1, slot2)
	return slot0:getOriginEditorParam(slot1, slot2) and #slot3 or 0
end

function slot0.getOrBuildCollectionShapeMap(slot0, slot1, slot2)
	slot0._collectionShapeMap = slot0._collectionShapeMap or {}

	if not (slot0._collectionShapeMap[slot1] and slot3[slot2]) then
		slot9 = slot2
		slot10 = RougeEnum.CollectionEditorParamType.Shape
		slot4 = {}

		for slot9, slot10 in ipairs(uv0.instance:getRotateEditorParam(slot1, slot9, slot10)) do
			if not slot4[slot10.x] then
				slot4[slot10.x] = {}
			end

			slot4[slot10.x][slot10.y] = true
		end

		slot0._collectionShapeMap[slot1] = slot0._collectionShapeMap[slot1] or {}
		slot0._collectionShapeMap[slot1][slot2] = slot4
	end

	return slot4
end

function slot0.getCollectionBaseTags(slot0)
	return slot0._baseTagList
end

function slot0.getCollectionExtraTags(slot0)
	return slot0._extraTagList
end

function slot0.getTagConfig(slot0, slot1)
	return slot0._allTagList[slot1]
end

function slot0.getShapeMatrix(slot0, slot1, slot2)
	slot0._rotationMatrixMap = slot0._rotationMatrixMap or {}

	if not slot0._rotationMatrixMap[slot1] then
		slot0._rotationMatrixMap[slot1] = {}
	end

	if not slot3[slot2 or RougeEnum.CollectionRotation.Rotation_0] then
		slot0._rotationMatrixMap[slot1][slot2] = slot0:getRotationMatrix(slot0:getCollectionShapeParam(slot1) and slot5.shapeMatrix, slot2)
	end

	return slot4
end

function slot0.getRotationMatrix(slot0, slot1, slot2)
	slot3 = {}
	slot4 = tabletool.len(slot1)
	slot5 = tabletool.len(slot1[1])

	if slot2 == RougeEnum.CollectionRotation.Rotation_0 then
		slot3 = slot1
	elseif slot2 == RougeEnum.CollectionRotation.Rotation_90 then
		for slot9 = 1, slot4 do
			for slot13 = 1, slot5 do
				slot3[slot13] = slot3[slot13] or {}
				slot3[slot13][slot4 - slot9 + 1] = slot1[slot9][slot13]
			end
		end
	elseif slot2 == RougeEnum.CollectionRotation.Rotation_180 then
		for slot9 = 1, slot4 do
			for slot13 = 1, slot5 do
				slot3[slot4 - slot9 + 1] = slot3[slot4 - slot9 + 1] or {}
				slot3[slot4 - slot9 + 1][slot5 - slot13 + 1] = slot1[slot9][slot13]
			end
		end
	elseif slot2 == RougeEnum.CollectionRotation.Rotation_270 then
		for slot9 = 1, slot4 do
			for slot13 = 1, slot5 do
				slot3[slot5 - slot13 + 1] = slot3[slot5 - slot13 + 1] or {}
				slot3[slot5 - slot13 + 1][slot9] = slot1[slot9][slot13]
			end
		end
	else
		logError("旋转角度非法:rotation = " .. tostring(slot2))
	end

	return slot3
end

function slot0.getShapeSize(slot0, slot1)
	if slot0:getCollectionShapeParam(slot1) and slot2.shapeSize then
		return slot3.x, slot3.y
	end
end

function slot0.buildItemStaticDescMap(slot0, slot1)
	slot0._itemStaticDescTab = slot1
	slot0._itemAttrValueMap = {}
end

function slot0.getAllItemStaticDescCfgs(slot0)
	return slot0._itemStaticDescTab and slot0._itemStaticDescTab.configList
end

function slot0.getItemStaticDescCfg(slot0, slot1)
	if not slot0._itemStaticDescTab.configDict[slot1] then
		logError("找不到造物属性静态描述, 造物id = " .. tostring(slot1))
	end

	return slot2
end

function slot0.getCollectionStaticAttrValueMap(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0._itemAttrValueMap[slot1] then
		slot2 = {}

		if slot0:getItemStaticDescCfg(slot1) then
			slot0:buildEnchantAttrMap(slot3.item1, slot3.item1_attr, slot2)
			slot0:buildEnchantAttrMap(slot3.item2, slot3.item2_attr, slot2)
			slot0:buildEnchantAttrMap(slot3.item3, slot3.item3_attr, slot2)
		end

		slot0._itemAttrValueMap[slot1] = slot2
	end

	return slot2
end

function slot0.buildEnchantAttrMap(slot0, slot1, slot2, slot3)
	if tonumber(slot1) and slot1 ~= 0 and slot0:parseCollectionItemAttr(slot2) then
		slot3[slot1] = slot4
	end
end

function slot0.parseCollectionItemAttr(slot0, slot1)
	slot2 = {}

	if not string.nilorempty(slot1) and GameUtil.splitString2(slot1) then
		for slot7, slot8 in ipairs(slot3) do
			slot2[slot8[1]] = tonumber(slot8[2])
		end
	end

	return slot2
end

function slot0.getCollectioTagCo(slot0, slot1)
	if not lua_rouge_tag.configDict[slot1] then
		logError("无法找到造物标签配置:" .. tostring(slot1))
	end

	return slot2
end

function slot0.getCollectionOfficialDesc(slot0, slot1)
	if not lua_rouge_write_desc.configDict[slot1] then
		logError("无法找到造物文案描述，造物id = " .. tostring(slot1))

		return
	end

	return slot2.desc
end

slot0.instance = slot0.New()

return slot0
