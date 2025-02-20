module("modules.logic.rouge.view.RougeCollectionChessInteractComp", package.seeall)

slot0 = class("RougeCollectionChessInteractComp", BaseView)

function slot0.onInitView(slot0)
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_left/#go_btns")
	slot0._gochessContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_chessContainer")
	slot0._gomeshContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_meshContainer")
	slot0._gomeshItem = gohelper.findChild(slot0.viewGO, "chessboard/#go_meshContainer/#go_meshItem")
	slot0._godragContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_dragContainer")
	slot0._gocellModel = gohelper.findChild(slot0.viewGO, "chessboard/#go_cellModel")
	slot0._gochessitem = gohelper.findChild(slot0.viewGO, "chessboard/#go_dragContainer/#go_chessitem")
	slot0._goraychessitem = gohelper.findChild(slot0.viewGO, "chessboard/#go_raychessitem")
	slot0._goblock = gohelper.findChild(slot0.viewGO, "#go_block")
	slot0._scrollbag = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_bag")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_bag/Viewport/#go_Content")
	slot0._gocollectionItem = gohelper.findChild(slot0.viewGO, "#scroll_bag/Viewport/#go_Content/#go_collectionItem")
	slot0._gotip = gohelper.findChild(slot0.viewGO, "#go_tip")
	slot0._gosingleTipsContent = gohelper.findChild(slot0.viewGO, "#go_tip/attributetip/#go_singleTipsContent")
	slot0._gosingleAttributeItem = gohelper.findChild(slot0.viewGO, "#go_tip/attributetip/#go_singleTipsContent/#go_singleAttributeItem")
	slot0._godragarea = gohelper.findChild(slot0.viewGO, "chessboard/#go_dragarea")
	slot0._btnslotclosetips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_slotclosetips")
	slot0._btnbagclosetips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_bagclosetips")
	slot0._goleft = gohelper.findChild(slot0.viewGO, "#go_left")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._click = gohelper.getClick(slot0._godragarea)

	slot0._click:AddClickListener(slot0._onClick, slot0)

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._godragarea)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._btnslotclosetips:AddClickListener(slot0._closeCollectionTipView, slot0)
	slot0._btnbagclosetips:AddClickListener(slot0._closeCollectionTipView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._click:RemoveClickListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0._drag:RemoveDragListener()
	slot0._btnslotclosetips:RemoveClickListener()
	slot0._btnbagclosetips:RemoveClickListener()
end

function slot0._closeCollectionTipView(slot0)
	RougeCollectionChessController.instance:deselectCollection()
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

function slot0._onClick(slot0)
	if slot0._isDraging then
		return
	end

	if not slot0:getPlaceCollectionMO(GamepadController.instance:getMousePosition()) then
		slot0:onClickEmptyArea()

		return
	end

	slot0:onClickPlaceCollection(slot2)
end

function slot0.onClickEmptyArea(slot0)
	RougeCollectionChessController.instance:deselectCollection()
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

function slot0.onClickPlaceCollection(slot0, slot1)
	if not RougeCollectionBagListModel.instance:isCollectionSelect(slot1.id) then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		slot0:try2OpenCollectionTipView(slot1)
		RougeCollectionChessController.instance:selectCollection(slot2)

		return
	end

	if slot0._tmpCollection.id ~= slot2 then
		slot0._tmpCollection:copyOtherMO(slot1)
	end

	slot0:rotateCollection()
end

function slot0.try2OpenCollectionTipView(slot0, slot1)
	if not slot1 or slot1.id <= 0 then
		return
	end

	slot2 = slot1.id
	slot0._attrCallBackId = RougeCollectionChessController.instance:try2OpenCollectionTipView(slot2, {
		useCloseBtn = false,
		collectionId = slot2,
		viewPosition = RougeEnum.CollectionTipPos.Slot,
		source = RougeCollectionModel.instance:getCollectionPlaceArea(slot2)
	})
end

function slot0._onDragBegin(slot0, slot1, slot2)
	if not RougeCollectionHelper.isCanDragCollection() then
		return
	end

	if not slot0:getPlaceCollectionMO(slot2.position) then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnBeginDragCollection, slot4, slot2)
end

function slot0.getPlaceCollectionMO(slot0, slot1)
	slot3, slot4 = RougeCollectionHelper.anchorPos2SlotPos(recthelper.screenPosToAnchorPos(slot1, slot0._godragContainer.transform))
	slot5 = nil

	if slot0:checkIsClickSuspendCollection(slot3, slot4) then
		slot5 = slot0._suspendCollection.id
	end

	if not slot5 or slot5 <= 0 then
		if slot0._suspendCollection and RougeCollectionModel.instance:getSlotFilledCollectionId(slot3, slot4) == slot0._suspendCollection.id then
			return
		end
	end

	return RougeCollectionModel.instance:getCollectionByUid(slot5)
end

function slot0.checkIsClickSuspendCollection(slot0, slot1, slot2)
	if slot0._suspendCollection then
		slot3 = slot0._suspendCollection:getLeftTopPos()
		slot7 = slot2 - slot3.y + 1
		slot8 = RougeCollectionConfig.instance:getShapeMatrix(slot0._suspendCollection.cfgId, slot0._suspendCollection:getRotation()) and slot5[slot7] and slot5[slot7][slot1 - slot3.x + 1]

		return slot8 and slot8 > 0
	end
end

function slot0.rotateCollection(slot0)
	if not slot0._tmpCollection then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.RotateCollection)

	if RougeCollectionHelper.isCollectionShapeAsSquare(slot0._tmpCollection.cfgId) then
		return
	end

	slot0._tmpCollection:updateRotation(Mathf.Clamp((slot0._tmpCollection:getRotation() + 1) % 4, 0, 4))
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.RotateSlotCollection, slot0._tmpCollection)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Start2CheckAndPlace, slot0._tmpCollection)
end

function slot0._onDrag(slot0, slot1, slot2)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnDragCollection, slot2)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnEndDragCollection, slot2)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.OnBeginDragCollection, slot0._beginDragCollectionCallBack, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.OnDragCollection, slot0._dragCollectionCallBack, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.OnEndDragCollection, slot0._endDragCollectionCallBack, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.DeleteSlotCollection, slot0._deleteSlotCollection, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.NullSpace2PlaceCollection, slot0.onNullSpace2PlaceCollection, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.ClearTmpCollection, slot0._clearTmpCollection, slot0)
	slot0:addEventCb(RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, slot0._failed2PlaceSlotCollection, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenViewCallBack, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewCallBack, slot0)

	slot0._leftTopPos = Vector2.zero
	slot0._isDraging = false
	slot0._goleftCanvasGroup = gohelper.onceAddComponent(slot0._goleft, gohelper.Type_CanvasGroup)
end

function slot0.onOpen(slot0)
	slot0._poolView = slot0.viewContainer:getRougePoolComp()
	slot0._tmpCollection = RougeCollectionSlotMO.New()
end

function slot0._beginDragCollectionCallBack(slot0, slot1, slot2)
	if not slot1 or slot1.id <= 0 then
		return
	end

	if not RougeCollectionHelper.isCanDragCollection() then
		return
	end

	slot0._isDraging = true
	slot0._pointerId = slot2.pointerId
	slot0._suspendCollection = nil

	gohelper.setActive(slot0._godragContainer, true)

	if slot0._tmpCollection.id ~= slot1.id then
		slot0._tmpCollection:copyOtherMO(slot1)
	end

	if RougeCollectionModel.instance:isCollectionPlaceInBag(slot1.id) then
		RougeCollectionChessController.instance:closeCollectionTipView()
	else
		if ViewMgr.instance:isOpen(ViewName.RougeCollectionTipView) then
			slot0:try2OpenCollectionTipView(slot1)
		end

		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.SetCollectionTipViewInteractable, false)
	end

	RougeCollectionChessController.instance:selectCollection(slot1.id)
	slot0:updateDragCollection(slot2)
	AudioMgr.instance:trigger(AudioEnum.UI.DragCollection)
end

function slot0._dragCollectionCallBack(slot0, slot1)
	if not slot0:checkIsResponeDragEvent(slot1) then
		return
	end

	slot0:updateDragCollection(slot1)
end

function slot0._endDragCollectionCallBack(slot0, slot1)
	if not slot0:checkIsResponeDragEvent(slot1) then
		return
	end

	slot0:updateDragCollection(slot1)
	slot0:onAfterEndDragCollection()
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.SetCollectionTipViewInteractable, true)
end

function slot0.updateDragCollection(slot0, slot1)
	if not slot0._isDraging or not slot0._tmpCollection then
		return
	end

	slot2 = slot0._tmpCollection
	slot3 = recthelper.screenPosToAnchorPos(slot1.position, slot0._godragContainer.transform)
	slot6, slot7 = RougeCollectionHelper.getCollectionDragPos(slot2.cfgId, slot2:getRotation())

	if slot6 and slot7 then
		slot8 = RougeCollectionHelper.getSlotCellSize()
		slot11, slot12 = RougeCollectionHelper.anchorPos2SlotPos(slot3)
		slot0._leftTopPos.x = slot11 - slot6 + 1
		slot0._leftTopPos.y = slot12 - slot7 + 1

		slot2:updateLeftTopPos(slot0._leftTopPos)

		slot0._curDragItem = slot0:_getOrCreateTmpCollection()

		slot0._curDragItem:onUpdateMO(slot2)
		slot0._curDragItem:setCollectionPosition(slot3.x - slot8.x * (slot6 - 0.5), slot3.y + slot8.y * (slot7 - 0.5))
		slot0._curDragItem:setShapeCellsVisible(true)
		slot0._curDragItem:setSelectFrameVisible(true)
		slot0._curDragItem:setHoleToolVisible(false)
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateSlotCellState, slot2)
	end
end

function slot0.checkIsResponeDragEvent(slot0, slot1)
	return slot1 and slot1.pointerId == slot0._pointerId and slot0._isDraging
end

function slot0.onAfterEndDragCollection(slot0)
	if not slot0._curDragItem or not slot0._tmpCollection then
		return
	end

	slot0._isDraging = false

	gohelper.setActive(slot0._godragContainer, slot0._isDraging)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Start2CheckAndPlace, slot0._tmpCollection, recthelper.rectToRelativeAnchorPos(slot0._curDragItem:getCollectionTransform().position, slot0._godragContainer.transform))
	slot0:_recycleDragCollection()
end

function slot0.onNullSpace2PlaceCollection(slot0, slot1)
	slot0._suspendCollection = slot1
end

function slot0._getOrCreateTmpCollection(slot0)
	if not slot0._curDragItem then
		slot0._curDragItem = slot0._poolView:getCollectionItem(RougeCollectionDragItem.__cname)

		slot0._curDragItem:setParent(slot0._godragContainer.transform, false)
	end

	return slot0._curDragItem
end

function slot0._recycleDragCollection(slot0)
	if slot0._curDragItem then
		slot0._poolView:recycleCollectionItem(RougeCollectionDragItem.__cname, slot0._curDragItem)

		slot0._curDragItem = nil
	end
end

function slot0._recycleSuspendCollection(slot0)
	if slot0._suspendCollection then
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Failed2PlaceSlotCollection, slot0._suspendCollection.id)

		slot0._suspendCollection = nil
	end
end

function slot0._clearTmpCollection(slot0)
	slot0._isDraging = false

	slot0:_recycleDragCollection()
	slot0:_recycleSuspendCollection()
	RougeCollectionChessController.instance:deselectCollection()
end

function slot0._deleteSlotCollection(slot0, slot1)
	if slot0._tmpCollection and slot0._tmpCollection.id == slot1 then
		slot0._tmpCollection:reset()
	end
end

function slot0._failed2PlaceSlotCollection(slot0, slot1, slot2)
	slot0:_deleteSlotCollection(slot1)
end

function slot0._onOpenViewCallBack(slot0, slot1, slot2)
	if slot1 == ViewName.RougeCollectionTipView then
		slot0:_setLeftInteractable(false)
		gohelper.setActive(slot0._btnslotclosetips.gameObject, slot2 and slot2.source == RougeEnum.OpenCollectionTipSource.SlotArea)
		gohelper.setActive(slot0._btnbagclosetips.gameObject, slot2 and slot2.source == RougeEnum.OpenCollectionTipSource.BagArea)
	end
end

function slot0._onCloseViewCallBack(slot0, slot1)
	if slot1 == ViewName.RougeCollectionTipView then
		slot0:_setLeftInteractable(true)
		gohelper.setActive(slot0._btnslotclosetips.gameObject, false)
		gohelper.setActive(slot0._btnbagclosetips.gameObject, false)
	end
end

function slot0._setLeftInteractable(slot0, slot1)
	slot0._goleftCanvasGroup.blocksRaycasts = slot1
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._poolView = nil

	if slot0._curDragItem then
		slot0._curDragItem:destroy()

		slot0._curDragItem = nil
	end

	if slot0._attrCallBackId then
		RougeRpc.instance:removeCallbackById(slot0._attrCallBackId)

		slot0._attrCallBackId = nil
	end
end

return slot0
