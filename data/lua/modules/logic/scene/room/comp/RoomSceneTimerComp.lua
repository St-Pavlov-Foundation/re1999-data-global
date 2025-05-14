module("modules.logic.scene.room.comp.RoomSceneTimerComp", package.seeall)

local var_0_0 = class("RoomSceneTimerComp", BaseSceneComp)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	TaskDispatcher.runRepeat(arg_1_0.everySecondCall, arg_1_0, TimeUtil.OneSecond)
	RoomMapController.instance:dispatchEvent(RoomEvent.RoomTimerInitComplete)
end

function var_0_0.everySecondCall(arg_2_0)
	if RoomController.instance:isDebugMode() then
		return
	end

	ManufactureController.instance:checkManufactureInfoUpdate()
end

function var_0_0.onSceneClose(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.everySecondCall, arg_3_0)
end

return var_0_0
