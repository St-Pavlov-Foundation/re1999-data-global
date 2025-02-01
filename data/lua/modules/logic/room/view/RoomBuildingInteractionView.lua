module("modules.logic.room.view.RoomBuildingInteractionView", package.seeall)

slot0 = class("RoomBuildingInteractionView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnlockscreen = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_lockscreen")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlockscreen:AddClickListener(slot0._btnlockscreenOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlockscreen:RemoveClickListener()
end

function slot0._btnlockscreenOnClick(slot0)
	slot0:closeThis()
	slot0:_resetCamera()
end

function slot0._resetCamera(slot0)
	if not RoomCharacterController.instance:getPlayingInteractionParam() or slot1.behaviour ~= RoomCharacterEnum.InteractionType.Building then
		return
	end

	if not RoomCharacterModel.instance:getCharacterMOById(slot1.heroId) then
		return
	end

	if not GameSceneMgr.instance:getCurScene() or not slot3.camera then
		return
	end

	if slot3.camera:getCameraState() == RoomEnum.CameraState.InteractionCharacterBuilding then
		slot5 = slot2.currentPosition

		slot4:switchCameraState(RoomEnum.CameraState.Normal, {
			focusX = slot5.x,
			focusY = slot5.z
		})
	end
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
