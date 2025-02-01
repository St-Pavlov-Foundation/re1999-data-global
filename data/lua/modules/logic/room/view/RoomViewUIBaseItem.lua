module("modules.logic.room.view.RoomViewUIBaseItem", package.seeall)

slot0 = class("RoomViewUIBaseItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.goTrs = slot1.transform
	slot0._gocontainer = gohelper.findChild(slot0.go, "go_container")
	slot0._gocontainerTrs = slot0._gocontainer.transform
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._canvasGroup = slot0.go:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._baseAnimator = slot0.go:GetComponent(typeof(UnityEngine.Animator))
	slot0._containerCanvasGroup = slot0._gocontainer:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._isShow = true

	if slot0._customOnInit then
		slot0:_customOnInit()
	end
end

function slot0.addEventListeners(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.RefreshUIShow, slot0._refreshShow, slot0)
	RoomBuildingController.instance:registerCallback(RoomEvent.BuildingListShowChanged, slot0._refreshShow, slot0)
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterListShowChanged, slot0._refreshShow, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.BendingAmountUpdate, slot0._refreshPosition, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, slot0._refreshPosition, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.TouchClickUI3D, slot0._onTouchClick, slot0)

	if slot0._customAddEventListeners then
		slot0:_customAddEventListeners()
	end
end

function slot0.removeEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.RefreshUIShow, slot0._refreshShow, slot0)
	RoomBuildingController.instance:unregisterCallback(RoomEvent.BuildingListShowChanged, slot0._refreshShow, slot0)
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterListShowChanged, slot0._refreshShow, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.BendingAmountUpdate, slot0._refreshPosition, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, slot0._refreshPosition, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TouchClickUI3D, slot0._onTouchClick, slot0)

	if slot0._customRemoveEventListeners then
		slot0:_customRemoveEventListeners()
	end
end

function slot0._refreshPosition(slot0)
	slot4 = 0

	if RoomBendingHelper.worldPosToAnchorPos(RoomBendingHelper.worldToBendingSimple(slot0:getUI3DPos()), slot0.goTrs.parent) then
		recthelper.setAnchor(slot0.goTrs, slot3.x, slot3.y)

		slot4 = Vector3.Distance(slot2, slot0._scene.camera:getCameraPosition()) <= 3.5 and 1 or slot6 >= 7 and 0.5 or 1 - (slot6 - 3.5) / 3.5 / 2
	end

	transformhelper.setLocalScale(slot0._gocontainerTrs, slot4, slot4, slot4)
	slot0:_refreshCanvasGroup()
end

function slot0._refreshCanvasGroup(slot0)
	slot1 = slot0:getUI3DPos()
	slot2 = slot0._scene.camera:getCameraPosition()
	slot6 = 1

	if RoomBaseUIComp.fadeMax <= Vector2.Distance(Vector2(slot1.x, slot1.z), Vector2(slot2.x, slot2.z)) then
		slot6 = 0
	elseif slot5 <= RoomBaseUIComp.fadeMin then
		slot6 = 1
	elseif slot0._lastAlpha and math.abs(slot0._lastAlpha - (1 - (slot5 - RoomBaseUIComp.fadeMin) / (RoomBaseUIComp.fadeMax - RoomBaseUIComp.fadeMin))) < RoomBaseUIComp.alphaChangeMinimum then
		slot6 = slot0._lastAlpha
	end

	slot7 = slot6 > 0.25

	if slot0._lastAlpha ~= slot6 then
		slot0._lastAlpha = slot6
		slot0._canvasGroup.alpha = slot6
	end

	if slot0._lastBlocksRaycasts ~= slot7 then
		slot0._lastBlocksRaycasts = slot7
		slot0._canvasGroup.blocksRaycasts = slot7
	end
end

function slot0.getUI3DPos(slot0)
end

function slot0._setShow(slot0, slot1, slot2)
	if slot1 then
		if not slot0._isShow then
			slot0._baseAnimator:Play("room_task_in", 0, slot2 and 1 or 0)
		end

		slot0._containerCanvasGroup.blocksRaycasts = true
	else
		if slot0._isShow then
			slot0._baseAnimator:Play("room_task_out", 0, slot2 and 1 or 0)
		end

		slot0._containerCanvasGroup.blocksRaycasts = false
	end

	slot0._isShow = slot1
end

function slot0._onTouchClick(slot0, slot1, slot2)
	if slot0._isShow and not slot0._isReturning and slot0.goTrs and slot1 and slot1.transform:IsChildOf(slot0.goTrs) then
		slot0:_onClick(slot1, slot2)
	end
end

function slot0._onClick(slot0, slot1, slot2)
end

function slot0.onDestroy(slot0)
	if slot0._customOnDestory then
		slot0:_customOnDestory()
	end
end

return slot0
