module("modules.logic.scene.room.fsm.RoomTransitionEnterWaterReform", package.seeall)

local var_0_0 = class("RoomTransitionEnterWaterReform", SimpleFSMBaseTransition)

function var_0_0.start(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	RoomMapController.instance:clearRoomShowBlockList()
	RoomWaterReformModel.instance:initWaterArea()
	RoomWaterReformModel.instance:setWaterReform(true)
	RoomWaterReformController.instance:changeReformMode(RoomEnum.ReformMode.Block)
	RoomWaterReformController.instance:refreshHighlightWaterBlock()
	RoomMapController.instance:dispatchEvent(RoomEvent.SelectRoomViewBlockOpTab, RoomEnum.RoomViewBlockOpMode.WaterReform)
	arg_2_0:onDone()
end

function var_0_0.stop(arg_3_0)
	return
end

function var_0_0.clear(arg_4_0)
	return
end

return var_0_0
