module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomPlaceBlock", package.seeall)

local var_0_0 = class("WaitGuideActionRoomPlaceBlock", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0._placeCount = tonumber(arg_1_0.actionParam)

	var_0_0.super.onStart(arg_1_0, arg_1_1)
	RoomMapController.instance:registerCallback(RoomEvent.OnUseBlock, arg_1_0._checkPlaceCount, arg_1_0)
	arg_1_0:_checkPlaceCount()
end

function var_0_0._checkPlaceCount(arg_2_0)
	if RoomMapBlockModel.instance:getFullBlockCount() >= arg_2_0._placeCount then
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.OnUseBlock, arg_3_0._checkPlaceCount, arg_3_0)
end

return var_0_0
