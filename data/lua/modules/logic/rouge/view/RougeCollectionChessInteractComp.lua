module("modules.logic.rouge.view.RougeCollectionChessInteractComp", package.seeall)

local var_0_0 = class("RougeCollectionChessInteractComp", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_left/#go_btns")
	arg_1_0._gochessContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_chessContainer")
	arg_1_0._gomeshContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_meshContainer")
	arg_1_0._gomeshItem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_meshContainer/#go_meshItem")
	arg_1_0._godragContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragContainer")
	arg_1_0._gocellModel = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_cellModel")
	arg_1_0._gochessitem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragContainer/#go_chessitem")
	arg_1_0._goraychessitem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_raychessitem")
	arg_1_0._goblock = gohelper.findChild(arg_1_0.viewGO, "#go_block")
	arg_1_0._scrollbag = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_bag")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_bag/Viewport/#go_Content")
	arg_1_0._gocollectionItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_bag/Viewport/#go_Content/#go_collectionItem")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "#go_tip")
	arg_1_0._gosingleTipsContent = gohelper.findChild(arg_1_0.viewGO, "#go_tip/attributetip/#go_singleTipsContent")
	arg_1_0._gosingleAttributeItem = gohelper.findChild(arg_1_0.viewGO, "#go_tip/attributetip/#go_singleTipsContent/#go_singleAttributeItem")
	arg_1_0._godragarea = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragarea")
	arg_1_0._btnslotclosetips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_slotclosetips")
	arg_1_0._btnbagclosetips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_bagclosetips")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#go_left")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._click = gohelper.getClick(arg_2_0._godragarea)

	arg_2_0._click:AddClickListener(arg_2_0._onClick, arg_2_0)

	arg_2_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_2_0._godragarea)

	arg_2_0._drag:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
	arg_2_0._drag:AddDragListener(arg_2_0._onDrag, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
	arg_2_0._btnslotclosetips:AddClickListener(arg_2_0._closeCollectionTipView, arg_2_0)
	arg_2_0._btnbagclosetips:AddClickListener(arg_2_0._closeCollectionTipView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0._drag:RemoveDragListener()
	arg_3_0._btnslotclosetips:RemoveClickListener()
	arg_3_0._btnbagclosetips:RemoveClickListener()
end

function var_0_0._closeCollectionTipView(arg_4_0)
	RougeCollectionChessController.instance:deselectCollection()
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

function var_0_0._onClick(arg_5_0)
	if arg_5_0._isDraging then
		return
	end

	local var_5_0 = GamepadController.instance:getMousePosition()
	local var_5_1 = arg_5_0:getPlaceCollectionMO(var_5_0)

	if not var_5_1 then
		arg_5_0:onClickEmptyArea()

		return
	end

	arg_5_0:onClickPlaceCollection(var_5_1)
end

function var_0_0.onClickEmptyArea(arg_6_0)
	RougeCollectionChessController.instance:deselectCollection()
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

function var_0_0.onClickPlaceCollection(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.id

	if not RougeCollectionBagListModel.instance:isCollectionSelect(var_7_0) then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		arg_7_0:try2OpenCollectionTipView(arg_7_1)
		RougeCollectionChessController.instance:selectCollection(var_7_0)

		return
	end

	if arg_7_0._tmpCollection.id ~= var_7_0 then
		arg_7_0._tmpCollection:copyOtherMO(arg_7_1)
	end

	arg_7_0:rotateCollection()
end

function var_0_0.try2OpenCollectionTipView(arg_8_0, arg_8_1)
	if not arg_8_1 or arg_8_1.id <= 0 then
		return
	end

	local var_8_0 = arg_8_1.id
	local var_8_1 = RougeCollectionModel.instance:getCollectionPlaceArea(var_8_0)
	local var_8_2 = {
		useCloseBtn = false,
		collectionId = var_8_0,
		viewPosition = RougeEnum.CollectionTipPos.Slot,
		source = var_8_1
	}

	arg_8_0._attrCallBackId = RougeCollectionChessController.instance:try2OpenCollectionTipView(var_8_0, var_8_2)
end

function var_0_0._onDragBegin(arg_9_0, arg_9_1, arg_9_2)
	if not RougeCollectionHelper.isCanDragCollection() then
		return
	end

	local var_9_0 = arg_9_0:getPlaceCollectionMO(arg_9_2.position)

	if not var_9_0 then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnBeginDragCollection, var_9_0, arg_9_2)
end

function var_0_0.getPlaceCollectionMO(arg_10_0, arg_10_1)
	local var_10_0 = recthelper.screenPosToAnchorPos(arg_10_1, arg_10_0._godragContainer.transform)
	local var_10_1, var_10_2 = RougeCollectionHelper.anchorPos2SlotPos(var_10_0)
	local var_10_3

	if arg_10_0:checkIsClickSuspendCollection(var_10_1, var_10_2) then
		var_10_3 = arg_10_0._suspendCollection.id
	end

	if not var_10_3 or var_10_3 <= 0 then
		var_10_3 = RougeCollectionModel.instance:getSlotFilledCollectionId(var_10_1, var_10_2)

		if arg_10_0._suspendCollection and var_10_3 == arg_10_0._suspendCollection.id then
			return
		end
	end

	return (RougeCollectionModel.instance:getCollectionByUid(var_10_3))
end

function var_0_0.checkIsClickSuspendCollection(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._suspendCollection then
		local var_11_0 = arg_11_0._suspendCollection:getLeftTopPos()
		local var_11_1 = arg_11_0._suspendCollection:getRotation()
		local var_11_2 = RougeCollectionConfig.instance:getShapeMatrix(arg_11_0._suspendCollection.cfgId, var_11_1)
		local var_11_3 = arg_11_1 - var_11_0.x + 1
		local var_11_4 = arg_11_2 - var_11_0.y + 1
		local var_11_5 = var_11_2 and var_11_2[var_11_4] and var_11_2[var_11_4][var_11_3]

		return var_11_5 and var_11_5 > 0
	end
end

function var_0_0.rotateCollection(arg_12_0)
	if not arg_12_0._tmpCollection then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.RotateCollection)

	if RougeCollectionHelper.isCollectionShapeAsSquare(arg_12_0._tmpCollection.cfgId) then
		return
	end

	local var_12_0 = arg_12_0._tmpCollection:getRotation()
	local var_12_1 = Mathf.Clamp((var_12_0 + 1) % 4, 0, 4)

	arg_12_0._tmpCollection:updateRotation(var_12_1)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.RotateSlotCollection, arg_12_0._tmpCollection)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Start2CheckAndPlace, arg_12_0._tmpCollection)
end

function var_0_0._onDrag(arg_13_0, arg_13_1, arg_13_2)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnDragCollection, arg_13_2)
end

function var_0_0._onDragEnd(arg_14_0, arg_14_1, arg_14_2)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnEndDragCollection, arg_14_2)
end

function var_0_0._editableInitView(arg_15_0)
	arg_15_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.OnBeginDragCollection, arg_15_0._beginDragCollectionCallBack, arg_15_0)
	arg_15_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.OnDragCollection, arg_15_0._dragCollectionCallBack, arg_15_0)
	arg_15_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.OnEndDragCollection, arg_15_0._endDragCollectionCallBack, arg_15_0)
	arg_15_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.DeleteSlotCollection, arg_15_0._deleteSlotCollection, arg_15_0)
	arg_15_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.NullSpace2PlaceCollection, arg_15_0.onNullSpace2PlaceCollection, arg_15_0)
	arg_15_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.ClearTmpCollection, arg_15_0._clearTmpCollection, arg_15_0)
	arg_15_0:addEventCb(RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, arg_15_0._failed2PlaceSlotCollection, arg_15_0)
	arg_15_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_15_0._onOpenViewCallBack, arg_15_0)
	arg_15_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_15_0._onCloseViewCallBack, arg_15_0)

	arg_15_0._leftTopPos = Vector2.zero
	arg_15_0._isDraging = false
	arg_15_0._goleftCanvasGroup = gohelper.onceAddComponent(arg_15_0._goleft, gohelper.Type_CanvasGroup)
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0._poolView = arg_16_0.viewContainer:getRougePoolComp()
	arg_16_0._tmpCollection = RougeCollectionSlotMO.New()
end

function var_0_0._beginDragCollectionCallBack(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_1 or not (arg_17_1.id > 0) then
		return
	end

	if not RougeCollectionHelper.isCanDragCollection() then
		return
	end

	arg_17_0._isDraging = true
	arg_17_0._pointerId = arg_17_2.pointerId
	arg_17_0._suspendCollection = nil

	gohelper.setActive(arg_17_0._godragContainer, true)

	if arg_17_0._tmpCollection.id ~= arg_17_1.id then
		arg_17_0._tmpCollection:copyOtherMO(arg_17_1)
	end

	if RougeCollectionModel.instance:isCollectionPlaceInBag(arg_17_1.id) then
		RougeCollectionChessController.instance:closeCollectionTipView()
	else
		if ViewMgr.instance:isOpen(ViewName.RougeCollectionTipView) then
			arg_17_0:try2OpenCollectionTipView(arg_17_1)
		end

		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.SetCollectionTipViewInteractable, false)
	end

	RougeCollectionChessController.instance:selectCollection(arg_17_1.id)
	arg_17_0:updateDragCollection(arg_17_2)
	AudioMgr.instance:trigger(AudioEnum.UI.DragCollection)
end

function var_0_0._dragCollectionCallBack(arg_18_0, arg_18_1)
	if not arg_18_0:checkIsResponeDragEvent(arg_18_1) then
		return
	end

	arg_18_0:updateDragCollection(arg_18_1)
end

function var_0_0._endDragCollectionCallBack(arg_19_0, arg_19_1)
	if not arg_19_0:checkIsResponeDragEvent(arg_19_1) then
		return
	end

	arg_19_0:updateDragCollection(arg_19_1)
	arg_19_0:onAfterEndDragCollection()
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.SetCollectionTipViewInteractable, true)
end

function var_0_0.updateDragCollection(arg_20_0, arg_20_1)
	if not arg_20_0._isDraging or not arg_20_0._tmpCollection then
		return
	end

	local var_20_0 = arg_20_0._tmpCollection
	local var_20_1 = recthelper.screenPosToAnchorPos(arg_20_1.position, arg_20_0._godragContainer.transform)
	local var_20_2 = var_20_0.cfgId
	local var_20_3 = var_20_0:getRotation()
	local var_20_4, var_20_5 = RougeCollectionHelper.getCollectionDragPos(var_20_2, var_20_3)

	if var_20_4 and var_20_5 then
		local var_20_6 = RougeCollectionHelper.getSlotCellSize()
		local var_20_7 = var_20_1.x - var_20_6.x * (var_20_4 - 0.5)
		local var_20_8 = var_20_1.y + var_20_6.y * (var_20_5 - 0.5)
		local var_20_9, var_20_10 = RougeCollectionHelper.anchorPos2SlotPos(var_20_1)

		arg_20_0._leftTopPos.x = var_20_9 - var_20_4 + 1
		arg_20_0._leftTopPos.y = var_20_10 - var_20_5 + 1

		var_20_0:updateLeftTopPos(arg_20_0._leftTopPos)

		arg_20_0._curDragItem = arg_20_0:_getOrCreateTmpCollection()

		arg_20_0._curDragItem:onUpdateMO(var_20_0)
		arg_20_0._curDragItem:setCollectionPosition(var_20_7, var_20_8)
		arg_20_0._curDragItem:setShapeCellsVisible(true)
		arg_20_0._curDragItem:setSelectFrameVisible(true)
		arg_20_0._curDragItem:setHoleToolVisible(false)
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateSlotCellState, var_20_0)
	end
end

function var_0_0.checkIsResponeDragEvent(arg_21_0, arg_21_1)
	return arg_21_1 and arg_21_1.pointerId == arg_21_0._pointerId and arg_21_0._isDraging
end

function var_0_0.onAfterEndDragCollection(arg_22_0)
	if not arg_22_0._curDragItem or not arg_22_0._tmpCollection then
		return
	end

	arg_22_0._isDraging = false

	gohelper.setActive(arg_22_0._godragContainer, arg_22_0._isDraging)

	local var_22_0 = arg_22_0._curDragItem:getCollectionTransform()
	local var_22_1 = recthelper.rectToRelativeAnchorPos(var_22_0.position, arg_22_0._godragContainer.transform)

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Start2CheckAndPlace, arg_22_0._tmpCollection, var_22_1)
	arg_22_0:_recycleDragCollection()
end

function var_0_0.onNullSpace2PlaceCollection(arg_23_0, arg_23_1)
	arg_23_0._suspendCollection = arg_23_1
end

function var_0_0._getOrCreateTmpCollection(arg_24_0)
	if not arg_24_0._curDragItem then
		arg_24_0._curDragItem = arg_24_0._poolView:getCollectionItem(RougeCollectionDragItem.__cname)

		arg_24_0._curDragItem:setParent(arg_24_0._godragContainer.transform, false)
	end

	return arg_24_0._curDragItem
end

function var_0_0._recycleDragCollection(arg_25_0)
	if arg_25_0._curDragItem then
		arg_25_0._poolView:recycleCollectionItem(RougeCollectionDragItem.__cname, arg_25_0._curDragItem)

		arg_25_0._curDragItem = nil
	end
end

function var_0_0._recycleSuspendCollection(arg_26_0)
	if arg_26_0._suspendCollection then
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Failed2PlaceSlotCollection, arg_26_0._suspendCollection.id)

		arg_26_0._suspendCollection = nil
	end
end

function var_0_0._clearTmpCollection(arg_27_0)
	arg_27_0._isDraging = false

	arg_27_0:_recycleDragCollection()
	arg_27_0:_recycleSuspendCollection()
	RougeCollectionChessController.instance:deselectCollection()
end

function var_0_0._deleteSlotCollection(arg_28_0, arg_28_1)
	if arg_28_0._tmpCollection and arg_28_0._tmpCollection.id == arg_28_1 then
		arg_28_0._tmpCollection:reset()
	end
end

function var_0_0._failed2PlaceSlotCollection(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0:_deleteSlotCollection(arg_29_1)
end

function var_0_0._onOpenViewCallBack(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1 == ViewName.RougeCollectionTipView then
		arg_30_0:_setLeftInteractable(false)

		local var_30_0 = arg_30_2 and arg_30_2.source == RougeEnum.OpenCollectionTipSource.SlotArea
		local var_30_1 = arg_30_2 and arg_30_2.source == RougeEnum.OpenCollectionTipSource.BagArea

		gohelper.setActive(arg_30_0._btnslotclosetips.gameObject, var_30_0)
		gohelper.setActive(arg_30_0._btnbagclosetips.gameObject, var_30_1)
	end
end

function var_0_0._onCloseViewCallBack(arg_31_0, arg_31_1)
	if arg_31_1 == ViewName.RougeCollectionTipView then
		arg_31_0:_setLeftInteractable(true)
		gohelper.setActive(arg_31_0._btnslotclosetips.gameObject, false)
		gohelper.setActive(arg_31_0._btnbagclosetips.gameObject, false)
	end
end

function var_0_0._setLeftInteractable(arg_32_0, arg_32_1)
	arg_32_0._goleftCanvasGroup.blocksRaycasts = arg_32_1
end

function var_0_0.onClose(arg_33_0)
	return
end

function var_0_0.onDestroyView(arg_34_0)
	arg_34_0._poolView = nil

	if arg_34_0._curDragItem then
		arg_34_0._curDragItem:destroy()

		arg_34_0._curDragItem = nil
	end

	if arg_34_0._attrCallBackId then
		RougeRpc.instance:removeCallbackById(arg_34_0._attrCallBackId)

		arg_34_0._attrCallBackId = nil
	end
end

return var_0_0
