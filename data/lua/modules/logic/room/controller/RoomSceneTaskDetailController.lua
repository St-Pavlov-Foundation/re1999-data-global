module("modules.logic.room.controller.RoomSceneTaskDetailController", package.seeall)

slot0 = class("RoomSceneTaskDetailController", BaseController)

function slot0.goToTask(slot0, slot1)
	if slot1.listenerType == RoomSceneTaskEnum.ListenerType.EditResArea or slot1.listenerType == RoomSceneTaskEnum.ListenerType.EditHasResBlockCount then
		return slot0:goToEditMode()
	elseif slot1.listenerType == RoomSceneTaskEnum.ListenerType.RoomLevel then
		return slot0:goToHallLevelUp()
	end
end

function slot0.goToHallLevelUp(slot0)
	if RoomController.instance:isEditMode() then
		GameFacade.showToast(RoomEnum.Toast.TaskGoOBModeInEditMode)
	elseif RoomController.instance:isObMode() then
		RoomMapController.instance:openRoomLevelUpView()
	end
end

function slot0.goToEditMode(slot0)
	if RoomController.instance:isEditMode() then
		GameFacade.showToast(RoomEnum.Toast.TaskAlreadyInEditMode)
	else
		RoomController.instance:enterRoom(RoomEnum.GameMode.Edit)

		return true
	end
end

slot0.instance = slot0.New()

return slot0
