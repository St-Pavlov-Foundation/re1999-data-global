module("modules.logic.rouge.view.RougeCollectionSizeBagItem", package.seeall)

local var_0_0 = class("RougeCollectionSizeBagItem", RougeCollectionBaseSlotItem)

function var_0_0.onInit(arg_1_0, arg_1_1)
	var_0_0.super.onInit(arg_1_0, arg_1_1)

	arg_1_0._gomodelcontainer = gohelper.findChild(arg_1_0.viewGO, "go_center/go_modelcontainer")
	arg_1_0._gocell = gohelper.findChild(arg_1_0.viewGO, "go_center/go_modelcontainer/go_cell")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	var_0_0.super._editableInitView(arg_2_0)
	arg_2_0:addClickListener()
	arg_2_0:addDragListeners()

	arg_2_0._edgeTab = arg_2_0:getUserDataTb_()

	arg_2_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.SelectCollection, arg_2_0._selectCollection, arg_2_0)
end

function var_0_0.addClickListener(arg_3_0)
	arg_3_0._btnclick = gohelper.getClick(arg_3_0.viewGO)

	arg_3_0._btnclick:AddClickListener(arg_3_0._btnclickOnClick, arg_3_0)
end

function var_0_0.addDragListeners(arg_4_0)
	arg_4_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_4_0.viewGO)

	arg_4_0._drag:AddDragBeginListener(arg_4_0._onDragBegin, arg_4_0)
	arg_4_0._drag:AddDragListener(arg_4_0._onDrag, arg_4_0)
	arg_4_0._drag:AddDragEndListener(arg_4_0._onDragEnd, arg_4_0)
end

function var_0_0.releaseAllListeners(arg_5_0)
	if arg_5_0._drag then
		arg_5_0._drag:RemoveDragBeginListener()
		arg_5_0._drag:RemoveDragEndListener()
		arg_5_0._drag:RemoveDragListener()

		arg_5_0._drag = nil
	end

	arg_5_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_6_0)
	if not arg_6_0._mo then
		return
	end

	local var_6_0 = {
		useCloseBtn = false,
		collectionId = arg_6_0._mo.id,
		viewPosition = RougeEnum.CollectionTipPos.Bag,
		source = RougeEnum.OpenCollectionTipSource.BagArea
	}

	RougeController.instance:openRougeCollectionTipView(var_6_0)
	RougeCollectionChessController.instance:selectCollection(arg_6_0._mo.id)
end

function var_0_0._onDragBegin(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = RougeCollectionHelper.isCanDragCollection()

	arg_7_0._isDraging = var_7_0

	if not var_7_0 then
		return
	end

	arg_7_0:setCanvasGroupVisible(false)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnBeginDragCollection, arg_7_0._mo, arg_7_2)
end

function var_0_0._onDrag(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._isDraging then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnDragCollection, arg_8_2)
end

function var_0_0._onDragEnd(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._isDraging then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnEndDragCollection, arg_9_2)

	arg_9_0._isDraging = false
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	var_0_0.super.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0:setShapeCellsVisible(true)
end

function var_0_0.onUpdateRotateAngle(arg_11_0)
	var_0_0.super.onUpdateRotateAngle(arg_11_0)
	arg_11_0:refreshShapeGrids()
end

function var_0_0.refreshShapeGrids(arg_12_0)
	local var_12_0 = arg_12_0._mo:getRotation()
	local var_12_1 = RougeCollectionConfig.instance:getRotateEditorParam(arg_12_0._mo.cfgId, var_12_0, RougeEnum.CollectionEditorParamType.Shape) or {}

	gohelper.CreateObjList(arg_12_0, arg_12_0.refreshSlotCell, var_12_1, arg_12_0._gomodelcontainer, arg_12_0._gocell)
end

function var_0_0.refreshSlotCell(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0:setCellAnchor(arg_13_1, arg_13_2)
	arg_13_0:setCellIconImage(arg_13_1)
	arg_13_0:checkAndPlaceAroundLine(arg_13_1, arg_13_2)
end

function var_0_0.checkAndPlaceAroundLine(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = RougeCollectionConfig.instance:getOrBuildCollectionShapeMap(arg_14_0._mo.cfgId, arg_14_0._mo:getRotation())
	local var_14_1 = RougeCollectionHelper.getSlotCellInsideLine(var_14_0, arg_14_2)
	local var_14_2 = gohelper.findChild(arg_14_1, "go_edge")
	local var_14_3 = gohelper.findChild(arg_14_1, "go_edge/go_left")
	local var_14_4 = gohelper.findChild(arg_14_1, "go_edge/go_right")
	local var_14_5 = gohelper.findChild(arg_14_1, "go_edge/go_bottom")
	local var_14_6 = gohelper.findChild(arg_14_1, "go_edge/go_top")

	gohelper.setActive(var_14_3, true)
	gohelper.setActive(var_14_4, true)
	gohelper.setActive(var_14_5, true)
	gohelper.setActive(var_14_6, true)

	if var_14_1 then
		for iter_14_0, iter_14_1 in pairs(var_14_1) do
			if iter_14_1 == RougeEnum.SlotCellDirection.Left then
				gohelper.setActive(var_14_3, false)
			elseif iter_14_1 == RougeEnum.SlotCellDirection.Right then
				gohelper.setActive(var_14_4, false)
			elseif iter_14_1 == RougeEnum.SlotCellDirection.Bottom then
				gohelper.setActive(var_14_5, false)
			elseif iter_14_1 == RougeEnum.SlotCellDirection.Top then
				gohelper.setActive(var_14_6, false)
			end
		end
	end

	if not arg_14_0._edgeTab[var_14_2] then
		arg_14_0._edgeTab[var_14_2] = true
	end
end

function var_0_0.setCellAnchor(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0._mo:getRotation()
	local var_15_1 = arg_15_2 - RougeCollectionHelper.getCollectionTopLeftPos(arg_15_0._mo.cfgId, var_15_0)
	local var_15_2 = var_15_1.x * arg_15_0._perCellWidth
	local var_15_3 = var_15_1.y * arg_15_0._perCellHeight

	recthelper.setAnchor(arg_15_1.transform, var_15_2, var_15_3)
end

function var_0_0.setCellIconImage(arg_16_0, arg_16_1)
	local var_16_0 = gohelper.findChildImage(arg_16_1, "icon")
	local var_16_1 = arg_16_0._collectionCfg and arg_16_0._collectionCfg.showRare

	UISpriteSetMgr.instance:setRougeSprite(var_16_0, "rouge_collection_grid_big_" .. tostring(var_16_1))
	recthelper.setSize(arg_16_1.transform, arg_16_0._perCellWidth, arg_16_0._perCellHeight)
end

function var_0_0._selectCollection(arg_17_0)
	local var_17_0 = arg_17_0._mo and arg_17_0._mo.id
	local var_17_1 = RougeCollectionBagListModel.instance:isCollectionSelect(var_17_0)

	arg_17_0:setSelectFrameVisible(var_17_1)
end

function var_0_0.setSelectFrameVisible(arg_18_0, arg_18_1)
	if arg_18_0._edgeTab then
		for iter_18_0, iter_18_1 in pairs(arg_18_0._edgeTab) do
			gohelper.setActive(iter_18_0, arg_18_1)
		end
	end
end

function var_0_0.reset(arg_19_0)
	var_0_0.super.reset(arg_19_0)
	arg_19_0:setSelectFrameVisible(false)

	arg_19_0._isDraging = false
end

function var_0_0.setShapeCellsVisible(arg_20_0, arg_20_1)
	gohelper.setActive(arg_20_0._gomodelcontainer, arg_20_1)
end

function var_0_0.destroy(arg_21_0)
	arg_21_0:releaseAllListeners()
	var_0_0.super.destroy(arg_21_0)
end

return var_0_0
