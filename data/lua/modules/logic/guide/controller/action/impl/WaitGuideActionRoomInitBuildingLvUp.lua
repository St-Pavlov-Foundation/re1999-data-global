module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomInitBuildingLvUp", package.seeall)

local var_0_0 = class("WaitGuideActionRoomInitBuildingLvUp", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._targetLevel = tonumber(arg_1_0.actionParam) or 3

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0._onOpenViewFinish, arg_1_0)
	RoomMapController.instance:registerCallback(RoomEvent.UpdateRoomLevel, arg_1_0._onUpdateRoomLevel, arg_1_0, LuaEventSystem.Low)
end

function var_0_0._onOpenViewFinish(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.RoomInitBuildingView and arg_2_0:_isSatisfy() then
		arg_2_0:onDone(true)
	end
end

function var_0_0._isSatisfy(arg_3_0)
	return ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView) and RoomMapModel.instance:getRoomLevel() >= arg_3_0._targetLevel
end

function var_0_0._onUpdateRoomLevel(arg_4_0)
	if arg_4_0:_isSatisfy() then
		arg_4_0:_checkTaskFinish()
	end
end

function var_0_0._checkTaskFinish(arg_5_0)
	local var_5_0, var_5_1 = RoomSceneTaskController.instance:isFirstTaskFinished()

	if var_5_0 then
		TaskController.instance:registerCallback(TaskEvent.SuccessGetBonus, arg_5_0._checkTaskFinish, arg_5_0, LuaEventSystem.Low)
	else
		arg_5_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_6_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_6_0._onOpenViewFinish, arg_6_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.UpdateRoomLevel, arg_6_0._onUpdateRoomLevel, arg_6_0)
	TaskController.instance:unregisterCallback(TaskEvent.SuccessGetBonus, arg_6_0._checkTaskFinish, arg_6_0)
end

return var_0_0
