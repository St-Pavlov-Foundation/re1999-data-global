module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairPieceView", package.seeall)

slot0 = class("VersionActivity1_8FactoryRepairPieceView", BaseView)
slot1 = 3

function slot0.onInitView(slot0)
	slot0._viewGoTrans = slot0.viewGO.transform
	slot0._gomap = gohelper.findChild(slot0.viewGO, "#go_map")
	slot0._btnMapDrag = SLFramework.UGUI.UIDragListener.Get(slot0._gomap)
	slot0._gorightPiece = gohelper.findChild(slot0.viewGO, "#go_rightPiece")
	slot0._goPiecePanel = gohelper.findChild(slot0.viewGO, "#go_PiecePanel")
	slot0._gopieceItem = gohelper.findChild(slot0.viewGO, "#go_rightPiece/#go_pieceItem")
	slot0._godragItem = gohelper.findChild(slot0.viewGO, "#go_dragItem")
	slot0._godragItemTrs = slot0._godragItem.transform
	slot0._dragItemAnimator = slot0._godragItem:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
	slot0._imagedrag = gohelper.findChildImage(slot0.viewGO, "#go_dragItem/#image_drag")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, slot0._onGameClear, slot0)
	slot0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragBegin, slot0._onDragBeginEvent, slot0)
	slot0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragIng, slot0._onDragIngEvent, slot0)
	slot0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragEnd, slot0._onDragEndEvent, slot0)
	slot0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PlaceItemRefresh, slot0._refreshUI, slot0)
	slot0:addEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.ResetGameRefresh, slot0._refreshUI, slot0)

	if slot0._btnMapDrag then
		slot0._btnMapDrag:AddDragBeginListener(slot0._onDragBegin, slot0)
		slot0._btnMapDrag:AddDragListener(slot0._onDragIng, slot0)
		slot0._btnMapDrag:AddDragEndListener(slot0._onDragEnd, slot0)
	end
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, slot0._onGameClear, slot0)
	slot0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragBegin, slot0._onDragBeginEvent, slot0)
	slot0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragIng, slot0._onDragIngEvent, slot0)
	slot0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragEnd, slot0._onDragEndEvent, slot0)
	slot0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.PlaceItemRefresh, slot0._refreshUI, slot0)
	slot0:removeEventCb(Activity157Controller.instance, ArmPuzzlePipeEvent.ResetGameRefresh, slot0._refreshUI, slot0)

	if slot0._btnMapDrag then
		slot0._btnMapDrag:RemoveDragBeginListener()
		slot0._btnMapDrag:RemoveDragListener()
		slot0._btnMapDrag:RemoveDragEndListener()
	end
end

function slot0._onGameClear(slot0)
	slot0._isDrag = false

	slot0:_refreshDragUI()
end

function slot0._onDragBeginEvent(slot0, slot1, slot2, slot3)
	slot0._isDrag = false

	if ArmPuzzlePipeEnum.UIDragRes[slot2] then
		slot0._isDrag = true
		slot0._curDragPipeTypeId = slot2
		slot0._curDragPipeValue = slot3

		UISpriteSetMgr.instance:setArmPipeSprite(slot0._imagedrag, slot4, true)
		transformhelper.setLocalRotation(slot0._godragItemTrs, 0, 0, ArmPuzzleHelper.getRotation(slot2, slot3))
		slot0:_refreshDragUI()
		slot0:_onDragIngEvent(slot1)
		AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_activity_lyrics_wrongs)
	end
end

function slot0._onDragIngEvent(slot0, slot1)
	if not slot0._isDrag then
		return
	end

	slot2 = recthelper.screenPosToAnchorPos(slot1, slot0._viewGoTrans)

	transformhelper.setLocalPosXY(slot0._godragItemTrs, slot2.x, slot2.y)

	slot3, slot4 = slot0:_getPipesXY(slot1)
	slot6, slot7 = Activity157RepairGameModel.instance:getPlaceSelectXY()

	if slot3 and slot4 and slot5:isPlaceByXY(slot3, slot4) then
		if not slot5:isPlaceSelectXY(slot3, slot4) then
			slot5:setPlaceSelectXY(slot3, slot4)
			slot0:_refreshPlacePipeItem(slot6, slot7)
			slot0:_refreshPlacePipeItem(slot3, slot4)
		end
	else
		slot5:setPlaceSelectXY(nil, )
		slot0:_refreshPlacePipeItem(slot6, slot7)
	end
end

function slot0._onDragEndEvent(slot0, slot1, slot2, slot3)
	if not slot0._isDrag then
		return
	end

	slot0._isDrag = false
	slot4 = Activity157RepairGameModel.instance
	slot5, slot6 = slot4:getPlaceSelectXY()

	slot4:setPlaceSelectXY(nil, )

	slot7, slot8 = slot0:_getPipesXY(slot1)
	slot9 = nil

	if slot7 and slot8 and slot4:isPlaceByXY(slot7, slot8) and slot4:getData(slot7, slot8) then
		if ArmPuzzlePipeEnum.UIDragRes[slot10.typeId] and slot2 and slot3 and slot4:isPlaceByXY(slot2, slot3) then
			slot9 = slot4:getData(slot2, slot3)
			slot9.typeId = slot10.typeId
			slot9.value = slot10.value
		end

		slot10:setParamStr(slot4:getPlaceStrByXY(slot7, slot8))

		slot10.typeId = slot0._curDragPipeTypeId
		slot10.value = slot0._curDragPipeValue

		Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, slot7, slot8)

		if slot9 and slot2 and slot3 then
			Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, slot2, slot3)
		end
	end

	slot0:_refreshUI()

	if slot5 ~= slot7 or slot6 ~= slot8 then
		slot0:_refreshPlacePipeItem(slot5, slot6)
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	if not slot0._isCanDragUIOP then
		slot0:_checkDragBegin(slot2.position)
	end
end

function slot0._checkDragBegin(slot0, slot1)
	slot0._isCanDragUIOP = false
	slot0._fromX = nil
	slot0._fromY = nil
	slot3, slot4 = slot0:_getPipesXY(slot1 or GamepadController.instance:getMousePosition())
	slot5 = Activity157RepairGameModel.instance

	if slot3 and slot4 and slot5:isPlaceByXY(slot3, slot4) and slot5:getData(slot3, slot4) and ArmPuzzlePipeEnum.UIDragRes[slot6.typeId] then
		slot0._isCanDragUIOP = true
		slot0._fromX = slot3
		slot0._fromY = slot4

		slot6:setParamStr(slot5:getPlaceStrByXY(slot3, slot4))
		slot0:_onDragBeginEvent(slot2, slot6.typeId, slot6.value)
		Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, slot3, slot4)
		Activity157RepairGameModel.instance:setPlaceSelectXY(slot3, slot4)
		slot0:_refreshPlacePipeItem(slot3, slot4)
		AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_activity_mark_finish)
	end
end

function slot0._onDragIng(slot0, slot1, slot2)
	if not slot0._isCanDragUIOP then
		return
	end

	slot0:_onDragIngEvent(slot2.position)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if slot0._isCanDragUIOP then
		slot0._isCanDragUIOP = false

		slot0:_onDragEndEvent(slot2.position, slot0._fromX, slot0._fromY)
	end
end

function slot0._editableInitView(slot0)
	slot0._isDrag = false
	slot0._typeIdList = {}
	slot0._pieceItemList = slot0:getUserDataTb_()

	for slot5, slot6 in ipairs({
		ArmPuzzlePipeEnum.type.straight,
		ArmPuzzlePipeEnum.type.corner,
		ArmPuzzlePipeEnum.type.t_shape
	}) do
		if Activity157RepairGameModel.instance:isHasPlaceByTypeId(slot6) then
			table.insert(slot0._typeIdList, slot6)

			slot9 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._gopieceItem, slot0._gorightPiece, "pieceitem_" .. slot6), VersionActivity1_8FactoryRepairPieceItem, slot0)

			slot9:setTypeId(slot6)
			table.insert(slot0._pieceItemList, slot9)
		end
	end

	gohelper.setActive(slot0._gopieceItem, false)

	for slot6 = 1, uv0 do
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "#go_PiecePanel/#image_PanelBG" .. slot6), slot6 == #slot0._pieceItemList)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot1 = Activity157RepairGameModel.instance:isHasPlace()

	gohelper.setActive(slot0._gorightPiece, slot1)
	gohelper.setActive(slot0._goPiecePanel, slot1)

	if slot1 then
		for slot5, slot6 in ipairs(slot0._pieceItemList) do
			slot6:refreshUI()
		end
	end

	slot0:_refreshDragUI()
end

function slot0._refreshDragUI(slot0)
	gohelper.setActive(slot0._godragItem, slot0._isDrag)
end

function slot0._refreshPlacePipeItem(slot0, slot1, slot2)
	if slot1 and slot2 and Activity157RepairGameModel.instance:isPlaceByXY(slot1, slot2) then
		slot0.viewContainer:getPipes():initItem(slot1, slot2)
	end
end

function slot0._getPipesXY(slot0, slot1)
	if slot0.viewContainer then
		return slot0.viewContainer:getPipesXYByPosition(slot1)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
