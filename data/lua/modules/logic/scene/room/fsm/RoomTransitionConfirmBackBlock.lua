module("modules.logic.scene.room.fsm.RoomTransitionConfirmBackBlock", package.seeall)

local var_0_0 = class("RoomTransitionConfirmBackBlock", JompFSMBaseTransition)

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

	local var_3_0 = arg_3_1.blockMOList

	for iter_3_0 = 1, #var_3_0 do
		local var_3_1 = var_3_0[iter_3_0]
		local var_3_2 = arg_3_0._scene.mapmgr:getBlockEntity(var_3_1.id, SceneTag.RoomMapBlock)

		if var_3_2 then
			arg_3_0._scene.mapmgr:destroyBlock(var_3_2)

			local var_3_3 = var_3_1.hexPoint
			local var_3_4 = RoomMapBlockModel.instance:getBlockMO(var_3_3.x, var_3_3.y)

			arg_3_0._scene.mapmgr:spawnMapBlock(var_3_4)
		end
	end

	arg_3_0:onDone()
	arg_3_0._scene.inventorymgr:moveForward()
	RoomMapController.instance:dispatchEvent(RoomEvent.UpdateWater)
	RoomMapController.instance:dispatchEvent(RoomEvent.UpdateInventoryCount)
	RoomMapController.instance:dispatchEvent(RoomEvent.ConfirmBackBlock)

	local var_3_5 = {}
	local var_3_6 = {}

	for iter_3_1 = 1, #var_3_0 do
		local var_3_7 = var_3_0[iter_3_1].hexPoint

		arg_3_0:_addValues(var_3_5, RoomBlockHelper.getNearBlockEntity(false, var_3_7, 1, true))
		arg_3_0:_addValues(var_3_6, RoomBlockHelper.getNearBlockEntity(true, var_3_7, 1, true))
		RoomMapBlockModel.instance:refreshNearRiver(var_3_7, 1)
	end

	RoomBlockHelper.refreshBlockEntity(var_3_5, "refreshBlock")
	RoomBlockHelper.refreshBlockEntity(var_3_6, "refreshWaveEffect")
end

function var_0_0._addValues(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 and arg_4_2 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
			if not tabletool.indexOf(arg_4_1, iter_4_1) then
				table.insert(arg_4_1, iter_4_1)
			end
		end
	end
end

function var_0_0.stop(arg_5_0)
	return
end

function var_0_0.clear(arg_6_0)
	return
end

return var_0_0
