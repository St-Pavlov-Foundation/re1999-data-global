module("modules.logic.scene.room.fsm.RoomTransitionCancelPlaceBlock", package.seeall)

local var_0_0 = class("RoomTransitionCancelPlaceBlock", JompFSMBaseTransition)

function var_0_0.start(arg_1_0)
	arg_1_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.check(arg_2_0)
	return true
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	arg_3_0._param = arg_3_1

	local var_3_0 = RoomMapBlockModel.instance:getTempBlockMO()

	if not var_3_0 then
		arg_3_0:onDone()

		return
	end

	local var_3_1 = var_3_0.hexPoint

	RoomMapBlockModel.instance:removeTempBlockMO()
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomMapBlockModel.instance:refreshNearRiver(var_3_1, 1)

	if var_3_0 then
		local var_3_2 = arg_3_0._scene.mapmgr
		local var_3_3 = var_3_2:getBlockEntity(var_3_0.id, SceneTag.RoomMapBlock)

		if var_3_3 then
			var_3_3:playAnim(RoomScenePreloader.ResAnim.ContainerPlay, "container_donw")
			var_3_2:removeUnitData(SceneTag.RoomMapBlock, var_3_0.id)
			var_3_3:removeEvent()
			TaskDispatcher.runDelay(function()
				var_3_2:destroyUnit(var_3_3)
			end, arg_3_0, 0.3333333333333333)
		end
	end

	local var_3_4 = RoomMapBlockModel.instance:getBlockMO(var_3_1.x, var_3_1.y)

	arg_3_0._scene.mapmgr:spawnMapBlock(var_3_4)
	RoomBlockController.instance:refreshNearLand(var_3_1, true)
	RoomBlockController.instance:refreshResourceLight()
	RoomMapController.instance:dispatchEvent(RoomEvent.ClientCancelBlock)

	local var_3_5 = RoomMapModel.instance:getCameraParam()
	local var_3_6 = arg_3_0._scene.camera:getCameraParam()
	local var_3_7 = {}

	if var_3_7 then
		arg_3_0._scene.camera:tweenCamera(var_3_7, nil, arg_3_0.onDone, arg_3_0)
		RoomMapModel.instance:clearCameraParam()
	else
		arg_3_0:onDone()
	end
end

function var_0_0.stop(arg_5_0)
	return
end

function var_0_0.clear(arg_6_0)
	return
end

return var_0_0
