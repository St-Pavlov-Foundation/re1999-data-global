module("modules.logic.scene.room.comp.RoomSceneConfirmViewComp", package.seeall)

slot0 = class("RoomSceneConfirmViewComp", BaseSceneComp)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	if not slot0._confirmView then
		slot3 = RoomUIPool.getInstance(RoomViewConfirm.prefabPath, "roomViewConfirm")
		slot4 = RoomViewConfirm.New()
		slot0._confirmView = slot4

		function slot4._setUIPos(slot0, slot1, slot2, slot3)
			slot4 = RoomBendingHelper.worldToBendingSimple(slot1)
			slot5 = slot3 or 1

			transformhelper.setLocalScale(slot0._gocontainer.transform, slot5, slot5, slot5)
			transformhelper.setPos(slot0._gocontainer.transform, slot4.x, slot4.y + (slot2 or 0), slot4.z)
		end

		slot4:__onInit()

		slot4.viewGO = slot3
		slot4.viewName = "RoomViewConfirm"

		slot4:onInitViewInternal()
		slot4:addEventsInternal()
		slot4:onOpenInternal()
		slot4:onOpenFinishInternal()

		slot5 = 0.017499999999999998

		transformhelper.setLocalScale(slot3.transform, slot5, slot5, slot5)
		transformhelper.setLocalRotation(slot4._gocontainer.transform, 90, 0, 0)
		RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)
	end
end

function slot0._cameraTransformUpdate(slot0)
	if slot0._confirmView and CameraMgr.instance:getMainCameraTrs() then
		slot2, slot3, slot4 = transformhelper.getLocalRotation(slot1)

		transformhelper.setLocalRotation(slot0._confirmView._gocontainer.transform, 90, slot3, 0)
	end
end

function slot0.getViewGO(slot0)
	return slot0._confirmView and slot0._confirmView.viewGO
end

function slot0.onSceneClose(slot0)
	if slot0._confirmView then
		slot1 = slot0._confirmView
		slot0._confirmView = nil

		slot1:onCloseInternal()
		slot1:onCloseFinishInternal()
		slot1:removeEventsInternal()
		slot1:onDestroyViewInternal()
		slot1:__onDispose()

		if slot1.viewGO then
			gohelper.destroy(slot1.viewGO)

			slot1.viewGO = nil
		end

		RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)
	end

	slot0._touchComp = nil
end

return slot0
