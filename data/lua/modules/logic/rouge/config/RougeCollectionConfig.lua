module("modules.logic.rouge.config.RougeCollectionConfig", package.seeall)

local var_0_0 = class("RougeCollectionConfig", BaseConfig)

function var_0_0.onInit(arg_1_0)
	arg_1_0._baseBagShapCfgTab = {}

	arg_1_0:LoadCollectionEditorConfig()
	arg_1_0:buildCollectionEditorMap()
end

function var_0_0.LoadCollectionEditorConfig(arg_2_0)
	arg_2_0._editorConfig = addGlobalModule("modules.configs.rouge.lua_rouge_collection_editor", "lua_rouge_collection_editor")
end

function var_0_0.buildCollectionEditorMap(arg_3_0)
	arg_3_0._collectionEditorMap = {}
	arg_3_0._interactCollectionMap = {}

	if arg_3_0._editorConfig then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0._editorConfig) do
			if arg_3_0._collectionEditorMap[iter_3_1.id] then
				logError("解析肉鸽造物表 << lua_rouge_collection_editor.lua >> 出错!!! 出错原因:存在重复的造物id :" .. tostring(iter_3_1.id))
			end

			arg_3_0._collectionEditorMap[iter_3_1.id] = iter_3_1

			if iter_3_1.interactable then
				arg_3_0._interactCollectionMap[iter_3_1.id] = iter_3_1
			end
		end
	end
end

function var_0_0.getAllCollections(arg_4_0)
	return arg_4_0._collectionEditorMap
end

function var_0_0.getAllInteractCollections(arg_5_0)
	return arg_5_0._interactCollectionMap
end

function var_0_0.getCollectionCfg(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._collectionEditorMap and arg_6_0._collectionEditorMap[arg_6_1]

	if not var_6_0 then
		logError("无法找到肉鸽造物配置:id = " .. tostring(arg_6_1))

		return
	end

	return var_6_0
end

function var_0_0.getCollectionTags(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getCollectionCfg(arg_7_1)

	return var_7_0 and var_7_0.tags
end

function var_0_0.getCollectionHoleNum(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getCollectionCfg(arg_8_1)

	return var_8_0 and var_8_0.holeNum
end

function var_0_0.getAllCollectionCfgs(arg_9_0)
	return arg_9_0._editorConfig
end

function var_0_0.reqConfigNames(arg_10_0)
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

function var_0_0.onConfigLoaded(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == "rouge_desc" then
		arg_11_0:buildCollectionDescMap(arg_11_2)
	elseif arg_11_1 == "rouge_tag" then
		arg_11_0:buildCollectionTagMap(arg_11_2)
	elseif arg_11_1 == "rogue_collection_backpack" then
		arg_11_0:buildCollectionBackpackMap(arg_11_2)
	elseif arg_11_1 == "rouge_synthesis" then
		arg_11_0:buildCollectionSynthesisMap(arg_11_2)
	elseif arg_11_1 == "rouge_attr" then
		arg_11_0:buildCollectionAttrMap(arg_11_2)
	elseif arg_11_1 == "rouge_item_static_desc" then
		arg_11_0:buildItemStaticDescMap(arg_11_2)
	end
end

function var_0_0.buildCollectionDescMap(arg_12_0, arg_12_1)
	arg_12_0._collectionDescMap = {}
	arg_12_0._collectionDescTab = arg_12_1

	for iter_12_0 = 1, #arg_12_1.configList do
		local var_12_0 = arg_12_1.configList[iter_12_0]
		local var_12_1 = var_12_0.id

		arg_12_0._collectionDescMap[var_12_1] = arg_12_0._collectionDescMap[var_12_1] or {}

		table.insert(arg_12_0._collectionDescMap[var_12_1], var_12_0)
	end
end

function var_0_0.getAllCollectionDescCfgs(arg_13_0)
	return arg_13_0._collectionDescTab and arg_13_0._collectionDescTab.configList
end

function var_0_0.getCollectionDescsCfg(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._collectionDescMap and arg_14_0._collectionDescMap[arg_14_1]

	if not var_14_0 then
		logError("无法找到造物描述配置,造物id = " .. tostring(arg_14_1))
	end

	return var_14_0 or {}
end

function var_0_0.getCollectionEffectDescCfg(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0._collectionDescTab.configDict[arg_15_1]

	return var_15_0 and var_15_0[arg_15_2]
end

function var_0_0.getCollectionName(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:getCollectionNameWithColor(arg_16_1)
	local var_16_1 = {
		var_16_0
	}

	if arg_16_2 then
		for iter_16_0, iter_16_1 in ipairs(arg_16_2) do
			if iter_16_1 and iter_16_1 > 0 then
				local var_16_2 = lua_rouge_extra_desc.configDict[iter_16_1]
				local var_16_3 = var_16_2 and var_16_2.name

				if not string.nilorempty(var_16_3) then
					local var_16_4 = var_0_0.instance:getCollectionCfg(iter_16_1)
					local var_16_5 = var_16_4 and var_16_4.showRare or 0
					local var_16_6 = arg_16_0:getCollectionRareColor(var_16_5)
					local var_16_7 = string.format("<#%s>%s</color>", var_16_6, var_16_3)

					table.insert(var_16_1, var_16_7)
				end
			end
		end
	end

	return (table.concat(var_16_1, ""))
end

function var_0_0.getCollectionNameWithColor(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getCollectionDescsCfg(arg_17_1)
	local var_17_1 = arg_17_0:getCollectionCfg(arg_17_1)

	if not var_17_0 or not var_17_1 then
		return
	end

	local var_17_2 = var_17_0 and var_17_0[1].name or ""
	local var_17_3 = arg_17_0:getCollectionRareColor(var_17_1.showRare)

	return (string.format("<#%s>%s</color>", var_17_3, var_17_2))
end

local var_0_1 = "#FFFFFF"

function var_0_0.getCollectionRareColor(arg_18_0, arg_18_1)
	local var_18_0 = lua_rouge_quality.configDict[arg_18_1]

	if not var_18_0 then
		logError("无法找到造物品质配置,造物品质id = " .. tostring(arg_18_1))

		return var_0_1
	end

	return var_18_0.rareColor or var_0_1
end

function var_0_0.buildCollectionTagMap(arg_19_0, arg_19_1)
	arg_19_0._collectionTagTab = arg_19_1
	arg_19_0._baseTagList = {}
	arg_19_0._extraTagList = {}
	arg_19_0._allTagList = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_1.configList) do
		if iter_19_1.id < RougeEnum.MinCollectionExtraTagID then
			table.insert(arg_19_0._baseTagList, iter_19_1)
		else
			table.insert(arg_19_0._extraTagList, iter_19_1)
		end

		arg_19_0._allTagList[iter_19_1.id] = iter_19_1
	end
end

function var_0_0.buildCollectionBackpackMap(arg_20_0, arg_20_1)
	arg_20_0._collectionBackpackTab = arg_20_1
	arg_20_0._collectionBackpackSizeMap = {}
	arg_20_0._initialCollectionMap = {}

	if arg_20_1 and arg_20_1.configDict then
		for iter_20_0, iter_20_1 in pairs(arg_20_1.configDict) do
			local var_20_0 = string.split(iter_20_1.layout, "#")

			arg_20_0._collectionBackpackSizeMap[iter_20_0] = {
				col = tonumber(var_20_0[1]),
				row = tonumber(var_20_0[2])
			}

			local var_20_1 = GameUtil.splitString2(iter_20_1.initialCollection, true)

			if var_20_1 then
				local var_20_2 = {}

				for iter_20_2, iter_20_3 in ipairs(var_20_1) do
					local var_20_3 = iter_20_3[3]
					local var_20_4 = iter_20_3[4]
					local var_20_5 = {
						cfgId = iter_20_3[1],
						rotation = iter_20_3[2],
						pos = {
							row = var_20_3,
							col = var_20_4
						}
					}

					table.insert(var_20_2, var_20_5)
				end

				arg_20_0._initialCollectionMap[iter_20_0] = var_20_2
			end
		end
	end
end

function var_0_0.getCollectionBackpackCfg(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._collectionBackpackTab and arg_21_0._collectionBackpackTab.configDict[arg_21_1]

	if not var_21_0 then
		logError("找不到流派初始背包配置, 背包id = " .. tostring(arg_21_1))
	end

	return var_21_0
end

function var_0_0.getCollectionInitialBagSize(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._collectionBackpackSizeMap and arg_22_0._collectionBackpackSizeMap[arg_22_1]

	if not var_22_0 then
		logError("找不到初始背包大小配置, 背包id = " .. tostring(arg_22_1))
	end

	return var_22_0
end

function var_0_0.getStyleCollectionBagSize(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = lua_rouge_style.configDict[arg_23_1][arg_23_2]
	local var_23_1 = var_23_0 and var_23_0.layoutId

	return (var_0_0.instance:getCollectionInitialBagSize(var_23_1))
end

function var_0_0.getStyleInitialCollections(arg_24_0, arg_24_1)
	return arg_24_0._initialCollectionMap and arg_24_0._initialCollectionMap[arg_24_1]
end

function var_0_0.buildCollectionSynthesisMap(arg_25_0, arg_25_1)
	arg_25_0._collectionSynthesisTab = arg_25_1
	arg_25_0._synthesisMap = {}

	for iter_25_0, iter_25_1 in ipairs(lua_rouge_synthesis.configList) do
		arg_25_0._synthesisMap[iter_25_1.product] = true
	end
end

function var_0_0.canSynthesized(arg_26_0, arg_26_1)
	return arg_26_0._synthesisMap and arg_26_0._synthesisMap[arg_26_1]
end

function var_0_0.getCollectionSynthesisList(arg_27_0)
	return arg_27_0._collectionSynthesisTab and arg_27_0._collectionSynthesisTab.configList
end

function var_0_0.getCollectionCompositeIds(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0._collectionCompositeMap and arg_28_0._collectionCompositeMap[arg_28_1]

	if not var_28_0 then
		local var_28_1 = arg_28_0._collectionSynthesisTab.configDict[arg_28_1]

		if not var_28_1 then
			return
		end

		local var_28_2 = string.split(var_28_1.synthetics, "#")

		var_28_0 = {}

		for iter_28_0, iter_28_1 in ipairs(var_28_2) do
			table.insert(var_28_0, tonumber(iter_28_1))
		end

		arg_28_0._collectionCompositeMap = arg_28_0._collectionCompositeMap or {}
		arg_28_0._collectionCompositeMap[arg_28_1] = var_28_0
	end

	return var_28_0
end

function var_0_0.getCollectionCompositeIdAndCount(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0._composteIdAndCountMap and arg_29_0._composteIdAndCountMap[arg_29_1]

	if not var_29_0 then
		local var_29_1 = arg_29_0:getCollectionCompositeIds(arg_29_1)

		if var_29_1 then
			var_29_0 = {}

			for iter_29_0, iter_29_1 in ipairs(var_29_1) do
				var_29_0[iter_29_1] = (var_29_0[iter_29_1] or 0) + 1
			end

			arg_29_0._composteIdAndCountMap = arg_29_0._composteIdAndCountMap or {}
			arg_29_0._composteIdAndCountMap[arg_29_1] = var_29_0
		end
	end

	return var_29_0
end

function var_0_0.buildCollectionAttrMap(arg_30_0, arg_30_1)
	arg_30_0._collectionAttrTab = arg_30_1
	arg_30_0._collectionAttrFlagMap = {}

	if arg_30_1 then
		for iter_30_0, iter_30_1 in ipairs(arg_30_1.configList) do
			local var_30_0 = iter_30_1.flag

			if arg_30_0._collectionAttrFlagMap[var_30_0] then
				logError("肉鸽造物属性表存在相同的Flag, Flag = " .. tostring(var_30_0))
			end

			arg_30_0._collectionAttrFlagMap[var_30_0] = iter_30_1
		end
	end
end

function var_0_0.getAllCollectionAttrMap(arg_31_0)
	return arg_31_0._collectionAttrTab and arg_31_0._collectionAttrTab.configDict
end

function var_0_0.getCollectionAttrCfg(arg_32_0, arg_32_1)
	return arg_32_0:getAllCollectionAttrMap()[arg_32_1]
end

function var_0_0.getCollectionAttrByFlag(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0._collectionAttrFlagMap and arg_33_0._collectionAttrFlagMap[arg_33_1]

	if not var_33_0 then
		logError(string.format("肉鸽造物静态属性Flag = %s 不存在", arg_33_1))
	end

	return var_33_0
end

function var_0_0.getCollectionShapeParam(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:getCollectionCfg(arg_34_1)

	return var_34_0 and var_34_0.shapeParam
end

function var_0_0.getOriginEditorParam(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0:getCollectionShapeParam(arg_35_1)

	return var_35_0 and var_35_0[arg_35_2]
end

local var_0_2 = Vector2(0, 0)

function var_0_0.getRotateEditorParam(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = arg_36_0:getOriginEditorParam(arg_36_1, arg_36_3)

	if not var_36_0 then
		logError(string.format("找不到造物编辑器配置:造物id = %s, 配置类型 = %s", arg_36_1, arg_36_3))

		return
	end

	if arg_36_3 == RougeEnum.CollectionEditorParamType.CenterPos then
		return var_36_0
	end

	local var_36_1

	if arg_36_0:isMultiParam(arg_36_3) then
		var_36_1 = arg_36_0:getRotateParamsResultInternal(var_36_0, var_0_2, arg_36_2)
	else
		var_36_1 = arg_36_0:computeSlotPosAfterRotate(var_36_0, var_0_2, arg_36_2)
	end

	return var_36_1
end

function var_0_0.getRotateParamsResultInternal(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	if arg_37_1 then
		local var_37_0 = {}

		arg_37_3 = RougeCollectionHelper.getRotateAngleByRotation(arg_37_3) * Mathf.PI / 180
		arg_37_2 = arg_37_2 or Vector2.zero

		for iter_37_0, iter_37_1 in ipairs(arg_37_1) do
			local var_37_1 = arg_37_0:computeSlotPosAfterRotate(iter_37_1, arg_37_2, arg_37_3)

			table.insert(var_37_0, var_37_1)
		end

		return var_37_0
	end
end

function var_0_0.computeSlotPosAfterRotate(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_1.x - arg_38_2.x
	local var_38_1 = arg_38_1.y - arg_38_2.y
	local var_38_2 = Mathf.Cos(arg_38_3)
	local var_38_3 = Mathf.Sin(arg_38_3)
	local var_38_4 = var_38_0 * var_38_2 - var_38_1 * var_38_3
	local var_38_5 = var_38_0 * var_38_3 + var_38_1 * var_38_2
	local var_38_6 = var_38_4 + arg_38_2.x + 0.5
	local var_38_7 = var_38_5 + arg_38_2.y + 0.5

	return (Vector2(math.floor(var_38_6), math.floor(var_38_7)))
end

function var_0_0.isMultiParam(arg_39_0, arg_39_1)
	return arg_39_1 == RougeEnum.CollectionEditorParamType.Shape or arg_39_1 == RougeEnum.CollectionEditorParamType.Effect
end

function var_0_0.getCollectionCellCount(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0:getOriginEditorParam(arg_40_1, arg_40_2)

	return var_40_0 and #var_40_0 or 0
end

function var_0_0.getOrBuildCollectionShapeMap(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0._collectionShapeMap = arg_41_0._collectionShapeMap or {}

	local var_41_0 = arg_41_0._collectionShapeMap[arg_41_1]
	local var_41_1 = var_41_0 and var_41_0[arg_41_2]

	if not var_41_1 then
		local var_41_2 = var_0_0.instance:getRotateEditorParam(arg_41_1, arg_41_2, RougeEnum.CollectionEditorParamType.Shape)

		var_41_1 = {}

		for iter_41_0, iter_41_1 in ipairs(var_41_2) do
			if not var_41_1[iter_41_1.x] then
				var_41_1[iter_41_1.x] = {}
			end

			var_41_1[iter_41_1.x][iter_41_1.y] = true
		end

		arg_41_0._collectionShapeMap[arg_41_1] = arg_41_0._collectionShapeMap[arg_41_1] or {}
		arg_41_0._collectionShapeMap[arg_41_1][arg_41_2] = var_41_1
	end

	return var_41_1
end

function var_0_0.getCollectionBaseTags(arg_42_0)
	return arg_42_0._baseTagList
end

function var_0_0.getCollectionExtraTags(arg_43_0)
	return arg_43_0._extraTagList
end

function var_0_0.getTagConfig(arg_44_0, arg_44_1)
	return arg_44_0._allTagList[arg_44_1]
end

function var_0_0.getShapeMatrix(arg_45_0, arg_45_1, arg_45_2)
	arg_45_0._rotationMatrixMap = arg_45_0._rotationMatrixMap or {}

	local var_45_0 = arg_45_0._rotationMatrixMap[arg_45_1]

	if not var_45_0 then
		var_45_0 = {}
		arg_45_0._rotationMatrixMap[arg_45_1] = var_45_0
	end

	arg_45_2 = arg_45_2 or RougeEnum.CollectionRotation.Rotation_0

	local var_45_1 = var_45_0[arg_45_2]

	if not var_45_1 then
		local var_45_2 = arg_45_0:getCollectionShapeParam(arg_45_1)
		local var_45_3 = var_45_2 and var_45_2.shapeMatrix

		var_45_1 = arg_45_0:getRotationMatrix(var_45_3, arg_45_2)
		arg_45_0._rotationMatrixMap[arg_45_1][arg_45_2] = var_45_1
	end

	return var_45_1
end

function var_0_0.getRotationMatrix(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = {}
	local var_46_1 = tabletool.len(arg_46_1)
	local var_46_2 = tabletool.len(arg_46_1[1])

	if arg_46_2 == RougeEnum.CollectionRotation.Rotation_0 then
		var_46_0 = arg_46_1
	elseif arg_46_2 == RougeEnum.CollectionRotation.Rotation_90 then
		for iter_46_0 = 1, var_46_1 do
			for iter_46_1 = 1, var_46_2 do
				var_46_0[iter_46_1] = var_46_0[iter_46_1] or {}
				var_46_0[iter_46_1][var_46_1 - iter_46_0 + 1] = arg_46_1[iter_46_0][iter_46_1]
			end
		end
	elseif arg_46_2 == RougeEnum.CollectionRotation.Rotation_180 then
		for iter_46_2 = 1, var_46_1 do
			for iter_46_3 = 1, var_46_2 do
				var_46_0[var_46_1 - iter_46_2 + 1] = var_46_0[var_46_1 - iter_46_2 + 1] or {}
				var_46_0[var_46_1 - iter_46_2 + 1][var_46_2 - iter_46_3 + 1] = arg_46_1[iter_46_2][iter_46_3]
			end
		end
	elseif arg_46_2 == RougeEnum.CollectionRotation.Rotation_270 then
		for iter_46_4 = 1, var_46_1 do
			for iter_46_5 = 1, var_46_2 do
				var_46_0[var_46_2 - iter_46_5 + 1] = var_46_0[var_46_2 - iter_46_5 + 1] or {}
				var_46_0[var_46_2 - iter_46_5 + 1][iter_46_4] = arg_46_1[iter_46_4][iter_46_5]
			end
		end
	else
		logError("旋转角度非法:rotation = " .. tostring(arg_46_2))
	end

	return var_46_0
end

function var_0_0.getShapeSize(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0:getCollectionShapeParam(arg_47_1)
	local var_47_1 = var_47_0 and var_47_0.shapeSize

	if var_47_1 then
		return var_47_1.x, var_47_1.y
	end
end

function var_0_0.buildItemStaticDescMap(arg_48_0, arg_48_1)
	arg_48_0._itemStaticDescTab = arg_48_1
	arg_48_0._itemAttrValueMap = {}
end

function var_0_0.getAllItemStaticDescCfgs(arg_49_0)
	return arg_49_0._itemStaticDescTab and arg_49_0._itemStaticDescTab.configList
end

function var_0_0.getItemStaticDescCfg(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0._itemStaticDescTab.configDict[arg_50_1]

	if not var_50_0 then
		logError("找不到造物属性静态描述, 造物id = " .. tostring(arg_50_1))
	end

	return var_50_0
end

function var_0_0.getCollectionStaticAttrValueMap(arg_51_0, arg_51_1)
	if not arg_51_1 then
		return
	end

	local var_51_0 = arg_51_0._itemAttrValueMap[arg_51_1]

	if not var_51_0 then
		var_51_0 = {}

		local var_51_1 = arg_51_0:getItemStaticDescCfg(arg_51_1)

		if var_51_1 then
			arg_51_0:buildEnchantAttrMap(var_51_1.item1, var_51_1.item1_attr, var_51_0)
			arg_51_0:buildEnchantAttrMap(var_51_1.item2, var_51_1.item2_attr, var_51_0)
			arg_51_0:buildEnchantAttrMap(var_51_1.item3, var_51_1.item3_attr, var_51_0)
		end

		arg_51_0._itemAttrValueMap[arg_51_1] = var_51_0
	end

	return var_51_0
end

function var_0_0.buildEnchantAttrMap(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	arg_52_1 = tonumber(arg_52_1)

	if arg_52_1 and arg_52_1 ~= 0 then
		local var_52_0 = arg_52_0:parseCollectionItemAttr(arg_52_2)

		if var_52_0 then
			arg_52_3[arg_52_1] = var_52_0
		end
	end
end

function var_0_0.parseCollectionItemAttr(arg_53_0, arg_53_1)
	local var_53_0 = {}

	if not string.nilorempty(arg_53_1) then
		local var_53_1 = GameUtil.splitString2(arg_53_1)

		if var_53_1 then
			for iter_53_0, iter_53_1 in ipairs(var_53_1) do
				var_53_0[iter_53_1[1]] = tonumber(iter_53_1[2])
			end
		end
	end

	return var_53_0
end

function var_0_0.getCollectioTagCo(arg_54_0, arg_54_1)
	local var_54_0 = lua_rouge_tag.configDict[arg_54_1]

	if not var_54_0 then
		logError("无法找到造物标签配置:" .. tostring(arg_54_1))
	end

	return var_54_0
end

function var_0_0.getCollectionOfficialDesc(arg_55_0, arg_55_1)
	local var_55_0 = lua_rouge_write_desc.configDict[arg_55_1]

	if not var_55_0 then
		logError("无法找到造物文案描述，造物id = " .. tostring(arg_55_1))

		return
	end

	return var_55_0.desc
end

var_0_0.instance = var_0_0.New()

return var_0_0
