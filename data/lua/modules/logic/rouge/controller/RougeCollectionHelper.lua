module("modules.logic.rouge.controller.RougeCollectionHelper", package.seeall)

local var_0_0 = _M
local var_0_1 = Vector2.New(0, 0)

var_0_0.CollectionSlotCellSize = Vector2.New(98, 98)

function var_0_0.anchorPos2SlotPos(arg_1_0)
	if not arg_1_0 then
		logError("anchorPos is nil")

		return var_0_1.x, var_0_1.y
	end

	local var_1_0 = Vector2(arg_1_0.x - var_0_1.x, -arg_1_0.y - var_0_1.y)
	local var_1_1 = math.floor(var_1_0.x / var_0_0.CollectionSlotCellSize.x + 0.5)
	local var_1_2 = math.floor(var_1_0.y / var_0_0.CollectionSlotCellSize.y + 0.5)

	return var_1_1, var_1_2
end

function var_0_0.slotPos2AnchorPos(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_0 then
		return Vector2.zero
	end

	arg_2_1 = arg_2_1 or var_0_0.CollectionSlotCellSize.x
	arg_2_2 = arg_2_2 or var_0_0.CollectionSlotCellSize.y

	local var_2_0 = arg_2_0.x * arg_2_1 + var_0_1.x
	local var_2_1 = -arg_2_0.y * arg_2_2 + var_0_1.y

	return var_2_0, var_2_1
end

function var_0_0.getCollectionPlacePosition(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = Vector2(arg_3_0.x - 0.5, arg_3_0.y - 0.5)
	local var_3_1, var_3_2 = var_0_0.slotPos2AnchorPos(var_3_0, arg_3_1, arg_3_2)

	return var_3_1, var_3_2
end

function var_0_0.getSlotCellSize()
	return var_0_0.CollectionSlotCellSize
end

function var_0_0.getSlotCellInsideLine(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0 then
		return
	end

	local var_5_0 = arg_5_1 + Vector2(0, 1)
	local var_5_1 = arg_5_1 - Vector2(0, 1)
	local var_5_2 = arg_5_1 - Vector2(1, 0)
	local var_5_3 = arg_5_1 + Vector2(1, 0)

	if arg_5_2 then
		var_5_1, var_5_0 = var_5_0, var_5_1
	end

	local var_5_4 = {}

	if arg_5_0[var_5_0.x] and arg_5_0[var_5_0.x][var_5_0.y] then
		table.insert(var_5_4, RougeEnum.SlotCellDirection.Top)
	end

	if arg_5_0[var_5_1.x] and arg_5_0[var_5_1.x][var_5_1.y] then
		table.insert(var_5_4, RougeEnum.SlotCellDirection.Bottom)
	end

	if arg_5_0[var_5_2.x] and arg_5_0[var_5_2.x][var_5_2.y] then
		table.insert(var_5_4, RougeEnum.SlotCellDirection.Left)
	end

	if arg_5_0[var_5_3.x] and arg_5_0[var_5_3.x][var_5_3.y] then
		table.insert(var_5_4, RougeEnum.SlotCellDirection.Right)
	end

	return var_5_4
end

function var_0_0.getCollectionTopLeftSlotPos(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = var_0_0.getCollectionTopLeftPos(arg_6_0, arg_6_2)

	return Vector2(arg_6_1.x + var_6_0.x, arg_6_1.y - var_6_0.y)
end

function var_0_0.getCollectionCenterSlotPos(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = var_0_0.getCollectionTopLeftPos(arg_7_0, arg_7_1)

	if not var_7_0 then
		return arg_7_2
	end

	local var_7_1 = arg_7_2.y + var_7_0.y
	local var_7_2 = arg_7_2.x - var_7_0.x

	return Vector2(var_7_2, var_7_1)
end

function var_0_0.getCollectionTopLeftPos(arg_8_0, arg_8_1)
	local var_8_0 = RougeCollectionConfig.instance:getRotateEditorParam(arg_8_0, arg_8_1, RougeEnum.CollectionEditorParamType.Shape)
	local var_8_1 = 1000
	local var_8_2 = 1000
	local var_8_3 = -1000
	local var_8_4 = -1000

	if var_8_0 then
		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			if var_8_1 > iter_8_1.x then
				var_8_1 = iter_8_1.x
			end

			if var_8_2 > iter_8_1.y then
				var_8_2 = iter_8_1.x
			end

			if var_8_3 < iter_8_1.y then
				var_8_3 = iter_8_1.x
			end

			if var_8_4 < iter_8_1.y then
				var_8_4 = iter_8_1.y
			end
		end
	end

	return Vector2(var_8_1, var_8_4)
end

function var_0_0.getRotateAngleByRotation(arg_9_0)
	arg_9_0 = arg_9_0 or 0
	arg_9_0 = Mathf.Clamp(arg_9_0, 0, 3)

	return arg_9_0 * -90
end

function var_0_0.getCollectionIconUrl(arg_10_0)
	local var_10_0 = RougeCollectionConfig.instance:getCollectionCfg(arg_10_0)

	if var_10_0 then
		return ResUrl.getRougeIcon("collection/" .. var_10_0.iconPath)
	end
end

function var_0_0.getCollectionSizeAfterRotation(arg_11_0, arg_11_1)
	local var_11_0, var_11_1 = RougeCollectionConfig.instance:getShapeSize(arg_11_0)

	arg_11_1 = arg_11_1 or 0

	if arg_11_1 % 2 == 0 then
		return var_11_0, var_11_1
	else
		return var_11_1, var_11_0
	end
end

function var_0_0.loadShapeGrid(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	gohelper.setActive(arg_12_2, false)

	local var_12_0 = RougeCollectionConfig.instance:getShapeMatrix(arg_12_0)
	local var_12_1, var_12_2 = RougeCollectionConfig.instance:getShapeSize(arg_12_0)

	if arg_12_4 == nil or arg_12_4 == true then
		local var_12_3 = var_0_0.getCollectionBgScaleSize(var_12_1, var_12_2)

		transformhelper.setLocalScale(arg_12_1.transform, var_12_3, var_12_3, 1)
	end

	gohelper.onceAddComponent(arg_12_1, gohelper.Type_GridLayoutGroup).constraintCount = var_12_1

	local var_12_4 = 0

	for iter_12_0 = 1, var_12_2 do
		for iter_12_1 = 1, var_12_1 do
			var_12_4 = var_12_4 + 1

			local var_12_5

			if arg_12_3 then
				var_12_5 = arg_12_3[var_12_4]

				if not var_12_5 then
					var_12_5 = gohelper.cloneInPlace(arg_12_2)

					table.insert(arg_12_3, var_12_5)
				end
			else
				var_12_5 = gohelper.cloneInPlace(arg_12_2)
			end

			gohelper.setActive(var_12_5, true)

			local var_12_6 = var_12_5:GetComponent(gohelper.Type_Image)
			local var_12_7 = tonumber(var_12_0[iter_12_0][iter_12_1]) == 1

			var_12_6.enabled = var_12_7

			if var_12_7 then
				local var_12_8 = RougeCollectionConfig.instance:getCollectionCfg(arg_12_0)
				local var_12_9 = var_12_8 and var_12_8.showRare

				UISpriteSetMgr.instance:setRougeSprite(var_12_6, "rouge_collection_grid_big_" .. tostring(var_12_9))
			end
		end
	end

	if arg_12_3 then
		for iter_12_2 = var_12_4 + 1, #arg_12_3 do
			gohelper.setActive(arg_12_3[iter_12_2], false)
		end
	end
end

function var_0_0.getCollectionBgScaleSize(arg_13_0, arg_13_1)
	if arg_13_0 == 0 or arg_13_1 == 0 then
		logError("get collection size zero, please check")

		return 0
	end

	if arg_13_1 < arg_13_0 then
		return RougeEnum.CollectionBgMaxSize / arg_13_0
	end

	return RougeEnum.CollectionBgMaxSize / arg_13_1
end

function var_0_0.loadTags(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = RougeCollectionConfig.instance:getCollectionTags(arg_14_0)

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_1

		if arg_14_2 then
			var_14_1 = arg_14_2[iter_14_0]

			if not var_14_1 then
				var_14_1 = gohelper.cloneInPlace(arg_14_1)

				table.insert(arg_14_2, var_14_1)
			end
		else
			var_14_1 = gohelper.cloneInPlace(arg_14_1)
		end

		local var_14_2 = RougeCollectionConfig.instance:getCollectioTagCo(iter_14_1)

		gohelper.setActive(var_14_1, true)

		local var_14_3 = gohelper.findChildImage(var_14_1, "image_tagicon")

		UISpriteSetMgr.instance:setRougeSprite(var_14_3, var_14_2 and var_14_2.iconUrl)
	end

	for iter_14_2 = #var_14_0 + 1, #arg_14_2 do
		gohelper.setActive(arg_14_2[iter_14_2], false)
	end
end

function var_0_0.loadCollectionAndEnchantTagsById(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = RougeCollectionModel.instance:getCollectionByUid(arg_15_0)

	if not var_15_0 then
		return
	end

	local var_15_1 = var_15_0.cfgId
	local var_15_2 = var_15_0:getAllEnchantCfgId()

	var_0_0.loadCollectionAndEnchantTags(var_15_1, var_15_2, arg_15_1, arg_15_2)
end

function var_0_0.loadCollectionAndEnchantTags(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0, var_16_1 = var_0_0.getCollectionAndEnchantTagIds(arg_16_0, arg_16_1)
	local var_16_2 = var_16_0 and #var_16_0 or 0

	var_16_0 = var_16_0 or {}

	tabletool.addValues(var_16_0, var_16_1)
	gohelper.CreateObjList(nil, var_0_0._loadCollectionTagCallBack, var_16_0, arg_16_2, arg_16_3, nil, 1, var_16_2)
	gohelper.CreateObjList(nil, var_0_0._loadEnchantTagCallBack, var_16_0, arg_16_2, arg_16_3, nil, var_16_2 + 1)
end

function var_0_0.loadCollectionTags(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = RougeCollectionConfig.instance:getCollectionCfg(arg_17_0)

	if not var_17_0 then
		return
	end

	local var_17_1 = var_17_0.tags or {}

	gohelper.CreateObjList(nil, var_0_0._loadCollectionTagCallBack, var_17_1, arg_17_1, arg_17_2)
end

function var_0_0._loadCollectionTagCallBack(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	var_0_0._loadCollectionIconFunc(arg_18_1, arg_18_2, arg_18_3)

	local var_18_0 = gohelper.findChildImage(arg_18_1, "image_tagframe")

	UISpriteSetMgr.instance:setRougeSprite(var_18_0, "rouge_collection_tagframe_1")
end

function var_0_0._loadEnchantTagCallBack(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	var_0_0._loadCollectionIconFunc(arg_19_1, arg_19_2, arg_19_3)

	local var_19_0 = gohelper.findChildImage(arg_19_1, "image_tagframe")

	UISpriteSetMgr.instance:setRougeSprite(var_19_0, "rouge_collection_tagframe_2")
end

function var_0_0._loadCollectionIconFunc(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = gohelper.findChildImage(arg_20_0, "image_tagicon")
	local var_20_1 = RougeCollectionConfig.instance:getCollectioTagCo(arg_20_1)

	UISpriteSetMgr.instance:setRougeSprite(var_20_0, var_20_1 and var_20_1.iconUrl)
end

function var_0_0.getCollectionAndEnchantTagIds(arg_21_0, arg_21_1)
	local var_21_0 = {}
	local var_21_1 = {}
	local var_21_2 = {}
	local var_21_3 = RougeCollectionConfig.instance:getCollectionCfg(arg_21_0)
	local var_21_4 = var_21_3 and var_21_3.tags

	var_0_0._getFilterCollectionTags(var_21_4, var_21_0, var_21_2)

	if arg_21_1 then
		for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
			if iter_21_1 > 0 then
				local var_21_5 = RougeCollectionConfig.instance:getCollectionCfg(iter_21_1)
				local var_21_6 = var_21_5 and var_21_5.tags

				var_0_0._getFilterCollectionTags(var_21_6, var_21_1, var_21_2, true)
			end
		end
	end

	return var_21_0, var_21_1
end

function var_0_0._getFilterCollectionTags(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if not arg_22_0 then
		return
	end

	arg_22_1 = arg_22_1 or {}
	arg_22_2 = arg_22_2 or {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_0) do
		if var_0_0._isCollectionTagSatisfy(iter_22_1, arg_22_2, arg_22_3) then
			table.insert(arg_22_1, iter_22_1)

			arg_22_2[iter_22_1] = true
		end
	end
end

function var_0_0._isCollectionTagSatisfy(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_0 or arg_23_1[arg_23_0] then
		return false
	end

	if arg_23_2 then
		return arg_23_0 < RougeEnum.MinCollectionExtraTagID
	end

	return true
end

function var_0_0.loadCollectionAndEnchantTagNames(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	local var_24_0, var_24_1 = var_0_0.getCollectionAndEnchantTagIds(arg_24_0, arg_24_1)

	var_24_0 = var_24_0 or {}

	tabletool.addValues(var_24_0, var_24_1)

	arg_24_4 = arg_24_4 or var_0_0._loadCollectionTagNameWithIconCallBack
	arg_24_5 = arg_24_5 or var_0_0

	gohelper.CreateObjList(arg_24_5, arg_24_4, var_24_0, arg_24_2, arg_24_3)
end

function var_0_0._loadCollectionTagNameWithIconCallBack(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = gohelper.findChildImage(arg_25_1, "image_tagicon")
	local var_25_1 = RougeCollectionConfig.instance:getCollectioTagCo(arg_25_2)

	UISpriteSetMgr.instance:setRougeSprite(var_25_0, var_25_1 and var_25_1.iconUrl)

	arg_25_1:GetComponent(gohelper.Type_TextMesh).text = var_25_1 and var_25_1.name
end

function var_0_0._loadCollectionTagNameCallBack(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = RougeCollectionConfig.instance:getCollectioTagCo(arg_26_2)

	arg_26_1:GetComponent(gohelper.Type_TextMesh).text = var_26_0 and var_26_0.name
end

function var_0_0.computeAndSetCollectionIconScale(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0, var_27_1 = RougeCollectionConfig.instance:getShapeSize(arg_27_0)
	local var_27_2 = var_27_0 * arg_27_2

	if var_27_0 < var_27_1 then
		var_27_2 = var_27_1 * arg_27_3
	end

	recthelper.setSize(arg_27_1, var_27_2, var_27_2)
end

function var_0_0.checkCollectionHasAnyOneTag(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	if GameUtil.tabletool_dictIsEmpty(arg_28_2) and GameUtil.tabletool_dictIsEmpty(arg_28_3) then
		return true
	end

	local var_28_0, var_28_1 = var_0_0.getCollectionAndEnchantTagIds(arg_28_0, arg_28_1)
	local var_28_2 = {}

	tabletool.addValues(var_28_2, var_28_0)
	tabletool.addValues(var_28_2, var_28_1)

	local var_28_3 = arg_28_2 and tabletool.len(arg_28_2) > 0
	local var_28_4 = arg_28_3 and tabletool.len(arg_28_3) > 0
	local var_28_5 = not var_28_3
	local var_28_6 = not var_28_4

	if var_28_2 then
		for iter_28_0, iter_28_1 in ipairs(var_28_2) do
			if var_28_3 and arg_28_2[iter_28_1] then
				var_28_5 = true
			end

			if var_28_4 and arg_28_3[iter_28_1] then
				var_28_6 = true
			end

			if var_28_5 and var_28_6 then
				return true
			end
		end
	end
end

function var_0_0.checkCollectionHasAnyOneTag1(arg_29_0, arg_29_1)
	if GameUtil.tabletool_dictIsEmpty(arg_29_1) then
		return true
	end

	local var_29_0 = RougeCollectionConfig.instance:getCollectionTags(arg_29_0)

	if var_29_0 then
		for iter_29_0, iter_29_1 in ipairs(var_29_0) do
			if arg_29_1[iter_29_1] then
				return true
			end
		end
	end
end

function var_0_0.removeInValidItem(arg_30_0)
	if GameUtil.tabletool_dictIsEmpty(arg_30_0) then
		return
	end

	for iter_30_0, iter_30_1 in pairs(arg_30_0) do
		if not arg_30_0[iter_30_0] then
			arg_30_0[iter_30_0] = nil
		end
	end
end

function var_0_0.buildCollectionSlotMOs(arg_31_0)
	if not arg_31_0 then
		return
	end

	local var_31_0 = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_0) do
		local var_31_1 = var_0_0.buildNewCollectionSlotMO(iter_31_1)

		table.insert(var_31_0, var_31_1)
	end

	return var_31_0
end

function var_0_0.buildNewCollectionSlotMO(arg_32_0)
	local var_32_0 = RougeCollectionSlotMO.New()

	var_32_0:init(arg_32_0)

	return var_32_0
end

function var_0_0.buildNewBagCollectionMO(arg_33_0)
	local var_33_0 = RougeCollectionMO.New()

	var_33_0:init(arg_33_0)

	return var_33_0
end

function var_0_0.isCollectionShapeAsSquare(arg_34_0)
	local var_34_0, var_34_1 = RougeCollectionConfig.instance:getShapeSize(arg_34_0)

	if var_34_0 ~= var_34_1 then
		return false
	end

	local var_34_2 = var_34_0 * var_34_1
	local var_34_3 = RougeCollectionConfig.instance:getOriginEditorParam(arg_34_0, RougeEnum.CollectionEditorParamType.Shape)

	return var_34_2 == (var_34_3 and #var_34_3 or 0)
end

function var_0_0.getCollectionCellSlotPos(arg_35_0, arg_35_1)
	return (Vector2(arg_35_1.x + arg_35_0.x, arg_35_0.y - arg_35_1.y))
end

function var_0_0.isNewGetCollection(arg_36_0)
	return arg_36_0 == RougeEnum.CollectionReason.Product or arg_36_0 == RougeEnum.CollectionReason.Composite
end

local var_0_2 = Vector2(1, 1)

function var_0_0.getCollectionDragPos(arg_37_0, arg_37_1)
	if not RougeCollectionConfig.instance:getCollectionCfg(arg_37_0) then
		return
	end

	local var_37_0 = RougeCollectionConfig.instance:getShapeMatrix(arg_37_0, arg_37_1)
	local var_37_1 = tabletool.len(var_37_0)
	local var_37_2 = var_37_0[var_37_1]

	if var_37_1 <= 1 and #var_37_2 <= 1 then
		return var_0_2.x, var_0_2.y
	end

	if var_37_2 then
		for iter_37_0, iter_37_1 in ipairs(var_37_2) do
			if iter_37_1 and iter_37_1 > 0 then
				return iter_37_0, var_37_1
			end
		end
	end
end

function var_0_0.checkIsCollectionSlotArea(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	if not arg_38_0 or not arg_38_1 or not arg_38_2 then
		return
	end

	local var_38_0 = RougeCollectionConfig.instance:getShapeMatrix(arg_38_0, arg_38_2)

	if var_38_0 then
		for iter_38_0, iter_38_1 in ipairs(var_38_0) do
			for iter_38_2, iter_38_3 in ipairs(iter_38_1) do
				if iter_38_3 and iter_38_3 > 0 then
					local var_38_1 = arg_38_1.x + iter_38_2 - 1
					local var_38_2 = arg_38_1.y + iter_38_0 - 1
					local var_38_3 = var_0_0.isSlotPosInSlotArea(var_38_2, var_38_1)

					if arg_38_3 and not var_38_3 then
						return true
					elseif not arg_38_3 and var_38_3 then
						return true
					end
				end
			end
		end
	end
end

function var_0_0.isSlotPosInSlotArea(arg_39_0, arg_39_1)
	local var_39_0 = RougeCollectionModel.instance:getCurSlotAreaSize()
	local var_39_1 = var_39_0.row or 0
	local var_39_2 = var_39_0.col or 0

	if var_39_0 then
		return arg_39_0 >= 0 and arg_39_0 < var_39_1 and arg_39_1 >= 0 and arg_39_1 < var_39_2
	end
end

var_0_0.DefaultSlotParam = RougeCollectionSlotCompParam.New()
var_0_0.StyleShowCollectionSlotParam = RougeCollectionSlotCompParam.New()

local var_0_3 = {
	[RougeEnum.LineState.Grey] = "rouge_bagline_yellow",
	[RougeEnum.LineState.Green] = "rouge_bagline_yellow_light"
}

var_0_0.StyleShowCollectionSlotParam.cellLineNameMap = var_0_3
var_0_0.StyleCollectionSlotParam = RougeCollectionSlotCompParam.New()

local var_0_4 = {
	[RougeEnum.LineState.Grey] = "rouge_bagline_black",
	[RougeEnum.LineState.Green] = "rouge_bagline_grey"
}

var_0_0.StyleCollectionSlotParam.cellLineNameMap = var_0_4
var_0_0.ResultReViewCollectionSlotParam = RougeCollectionSlotCompParam.New()
var_0_0.ResultReViewCollectionSlotParam.cellWidth = var_0_0.CollectionSlotCellSize.x
var_0_0.ResultReViewCollectionSlotParam.cellHeight = var_0_0.CollectionSlotCellSize.y

local var_0_5 = {
	[RougeEnum.LineState.Grey] = "rouge_collection_gridline_grey",
	[RougeEnum.LineState.Green] = "rouge_collection_gridline_green",
	[RougeEnum.LineState.Red] = "rouge_collection_gridline_red",
	[RougeEnum.LineState.Blue] = "rouge_collection_gridline_blue"
}

var_0_0.ResultReViewCollectionSlotParam.cellLineNameMap = var_0_5
var_0_0.ResultReViewCollectionSlotParam.showIcon = true

function var_0_0.foreachCollectionCells(arg_40_0, arg_40_1, arg_40_2, ...)
	if not arg_40_0 then
		return
	end

	local var_40_0 = arg_40_0.cfgId
	local var_40_1 = arg_40_0:getRotation()
	local var_40_2 = RougeCollectionConfig.instance:getShapeMatrix(var_40_0, var_40_1)

	if var_40_2 then
		for iter_40_0, iter_40_1 in ipairs(var_40_2) do
			for iter_40_2, iter_40_3 in ipairs(iter_40_1) do
				if iter_40_3 and iter_40_3 > 0 then
					arg_40_1(arg_40_2, arg_40_0, iter_40_0, iter_40_2, ...)
				end
			end
		end
	end
end

function var_0_0.getTwoCollectionConnectCell(arg_41_0, arg_41_1)
	if not arg_41_0 or not arg_41_1 then
		return
	end

	local var_41_0 = arg_41_1.cfgId
	local var_41_1 = {}

	var_0_0.foreachCollectionCells(arg_41_0, var_0_0._checkIsTwoCollectionCellNear, nil, arg_41_1, var_41_1)

	if var_41_1 and #var_41_1 > 0 then
		return var_41_1[1], var_41_1[2]
	end
end

function var_0_0._checkIsTwoCollectionCellNear(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5)
	if (not arg_42_1 or not arg_42_4) and arg_42_5 then
		return
	end

	local var_42_0 = arg_42_1:getLeftTopPos()
	local var_42_1 = var_42_0.x + arg_42_3 - 1
	local var_42_2 = var_42_0.y + arg_42_2 - 1
	local var_42_3 = var_0_0._checkIsCellNearCollection(var_42_1 - 1, var_42_2, arg_42_4)
	local var_42_4 = var_0_0._checkIsCellNearCollection(var_42_1 + 1, var_42_2, arg_42_4)
	local var_42_5 = var_0_0._checkIsCellNearCollection(var_42_1, var_42_2 - 1, arg_42_4)
	local var_42_6 = var_0_0._checkIsCellNearCollection(var_42_1, var_42_2 + 1, arg_42_4)

	if var_42_3 or var_42_4 or var_42_5 or var_42_6 then
		table.insert(arg_42_5, Vector2(var_42_1, var_42_2))

		if var_42_3 then
			table.insert(arg_42_5, Vector2(var_42_1 - 1, var_42_2))
		elseif var_42_4 then
			table.insert(arg_42_5, Vector2(var_42_1 + 1, var_42_2))
		elseif var_42_5 then
			table.insert(arg_42_5, Vector2(var_42_1, var_42_2 - 1))
		else
			table.insert(arg_42_5, Vector2(var_42_1, var_42_2 + 1))
		end
	end
end

function var_0_0._checkIsCellNearCollection(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_2 then
		return
	end

	local var_43_0 = arg_43_2:getLeftTopPos()
	local var_43_1 = arg_43_0 - var_43_0.x + 1
	local var_43_2 = arg_43_1 - var_43_0.y + 1
	local var_43_3 = RougeCollectionConfig.instance:getShapeMatrix(arg_43_2.cfgId, arg_43_2:getRotation())
	local var_43_4 = false

	if var_43_3 then
		local var_43_5 = var_43_3[var_43_2] and var_43_3[var_43_2][var_43_1]

		var_43_4 = var_43_5 and var_43_5 > 0
	end

	return var_43_4
end

function var_0_0.isCanDragCollection()
	return UnityEngine.Input.touchCount <= 1
end

function var_0_0.isUniqueCollection(arg_45_0)
	local var_45_0 = RougeCollectionConfig.instance:getCollectionCfg(arg_45_0)

	return var_45_0 and var_45_0.isUnique
end

function var_0_0.isUnremovableCollection(arg_46_0)
	local var_46_0 = RougeCollectionConfig.instance:getCollectionCfg(arg_46_0)

	return var_46_0 and var_46_0.unremovable
end

function var_0_0.getNotUniqueCollectionNum()
	local var_47_0 = RougeCollectionModel.instance:getAllCollections()
	local var_47_1 = 0

	for iter_47_0, iter_47_1 in ipairs(var_47_0) do
		if not var_0_0.isUniqueCollection(iter_47_1.cfgId) then
			var_47_1 = var_47_1 + 1
		end
	end

	return var_47_1
end

return var_0_0
