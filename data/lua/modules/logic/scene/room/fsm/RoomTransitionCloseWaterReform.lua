module("modules.logic.scene.room.fsm.RoomTransitionCloseWaterReform", package.seeall)

local var_0_0 = class("RoomTransitionCloseWaterReform", SimpleFSMBaseTransition)

function var_0_0.start(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	RoomWaterReformListModel.instance:clear()
	RoomWaterReformController.instance:clearSelectWater()
	RoomWaterReformModel.instance:clear()
	RoomWaterReformController.instance:refreshHighlightWaterBlock()
	arg_2_0:onDone()
end

function var_0_0.stop(arg_3_0)
	return
end

function var_0_0.clear(arg_4_0)
	return
end

return var_0_0
