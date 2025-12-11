module("modules.logic.scene.room.fsm.RoomTransitionCloseWaterReform", package.seeall)

local var_0_0 = class("RoomTransitionCloseWaterReform", SimpleFSMBaseTransition)

function var_0_0.start(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	local var_2_0 = GameSceneMgr.instance:getCurScene()

	if var_2_0 and var_2_0.inventorymgr then
		var_2_0.inventorymgr:removeAllBlockEntity()
	end

	RoomWaterReformListModel.instance:clear()
	RoomWaterReformController.instance:clearSelectWater()
	RoomWaterReformController.instance:clearSelectBlock()
	RoomWaterReformModel.instance:clear()
	RoomWaterReformController.instance:refreshHighlightWaterBlock()
	RoomMapController.instance:setRoomShowBlockList()
	arg_2_0:onDone()
end

function var_0_0.stop(arg_3_0)
	return
end

function var_0_0.clear(arg_4_0)
	return
end

return var_0_0
