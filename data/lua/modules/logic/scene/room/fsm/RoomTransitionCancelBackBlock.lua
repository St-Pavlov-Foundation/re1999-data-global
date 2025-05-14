module("modules.logic.scene.room.fsm.RoomTransitionCancelBackBlock", package.seeall)

local var_0_0 = class("RoomTransitionCancelBackBlock", JompFSMBaseTransition)

function var_0_0.start(arg_1_0)
	arg_1_0._scene = GameSceneMgr.instance:getCurScene()
	arg_1_0._opToDis = {
		[RoomBlockEnum.OpState.Normal] = RoomBlockEnum.OpState.Back,
		[RoomBlockEnum.OpState.Back] = RoomBlockEnum.OpState.Normal
	}
end

function var_0_0.check(arg_2_0)
	return true
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	arg_3_0._param = arg_3_1

	local var_3_0 = RoomMapBlockModel.instance:getBackBlockModel()
	local var_3_1 = var_3_0:getList()

	for iter_3_0 = 1, #var_3_1 do
		local var_3_2 = var_3_1[iter_3_0]

		var_3_2:setOpState(RoomBlockEnum.OpState.Normal)

		local var_3_3 = arg_3_0._scene.mapmgr:getBlockEntity(var_3_2.id, SceneTag.RoomMapBlock)

		if var_3_3 then
			var_3_3:refreshBlock()
		end
	end

	var_3_0:clear()
	arg_3_0:onDone()
	RoomMapController.instance:dispatchEvent(RoomEvent.ClientCancelBackBlock)
end

function var_0_0.stop(arg_4_0)
	return
end

function var_0_0.clear(arg_5_0)
	return
end

return var_0_0
