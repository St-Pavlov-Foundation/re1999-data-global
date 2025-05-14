module("modules.logic.room.controller.RoomSceneTaskDetailController", package.seeall)

local var_0_0 = class("RoomSceneTaskDetailController", BaseController)

function var_0_0.goToTask(arg_1_0, arg_1_1)
	if arg_1_1.listenerType == RoomSceneTaskEnum.ListenerType.EditResArea or arg_1_1.listenerType == RoomSceneTaskEnum.ListenerType.EditHasResBlockCount then
		return arg_1_0:goToEditMode()
	elseif arg_1_1.listenerType == RoomSceneTaskEnum.ListenerType.RoomLevel then
		return arg_1_0:goToHallLevelUp()
	end
end

function var_0_0.goToHallLevelUp(arg_2_0)
	if RoomController.instance:isEditMode() then
		GameFacade.showToast(RoomEnum.Toast.TaskGoOBModeInEditMode)
	elseif RoomController.instance:isObMode() then
		RoomMapController.instance:openRoomLevelUpView()
	end
end

function var_0_0.goToEditMode(arg_3_0)
	if RoomController.instance:isEditMode() then
		GameFacade.showToast(RoomEnum.Toast.TaskAlreadyInEditMode)
	else
		RoomController.instance:enterRoom(RoomEnum.GameMode.Edit)

		return true
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
