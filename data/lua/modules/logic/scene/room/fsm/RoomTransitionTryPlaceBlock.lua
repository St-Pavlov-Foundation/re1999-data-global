module("modules.logic.scene.room.fsm.RoomTransitionTryPlaceBlock", package.seeall)

local var_0_0 = class("RoomTransitionTryPlaceBlock", SimpleFSMBaseTransition)

function var_0_0.start(arg_1_0)
	arg_1_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.check(arg_2_0)
	return true
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	arg_3_0._param = arg_3_1

	local var_3_0 = arg_3_0._param.hexPoint
	local var_3_1 = arg_3_0._param.rotate
	local var_3_2 = RoomMapBlockModel.instance:getTempBlockMO()

	if var_3_2 then
		local var_3_3 = RoomInventoryBlockModel.instance:getSelectInventoryBlockMO()

		if var_3_3 and var_3_3.id ~= var_3_2.id then
			arg_3_0:_replaceBlock()
		else
			arg_3_0:_changeBlock()
		end
	else
		arg_3_0:_placeBlock()
	end

	RoomBlockController.instance:refreshResourceLight()
	RoomMapController.instance:dispatchEvent(RoomEvent.ClientPlaceBlock)

	if var_3_0 then
		local var_3_4 = HexMath.hexToPosition(var_3_0, RoomBlockEnum.BlockSize)
		local var_3_5 = {}

		if arg_3_0:_isOutScreen(var_3_4) then
			var_3_5.focusX = var_3_4.x
			var_3_5.focusY = var_3_4.y
		end

		if not var_3_2 then
			local var_3_6 = arg_3_0._scene.camera:getCameraParam()

			RoomMapModel.instance:saveCameraParam(var_3_6)
		end

		arg_3_0._scene.camera:tweenCamera(var_3_5, nil, arg_3_0.onDone, arg_3_0)
	else
		arg_3_0:onDone()
	end
end

function var_0_0._isOutScreen(arg_4_0, arg_4_1)
	return RoomHelper.isOutCameraFocus(arg_4_1)
end

function var_0_0._replaceBlock(arg_5_0)
	local var_5_0 = RoomMapBlockModel.instance:getTempBlockMO()
	local var_5_1 = var_5_0:getRiverCount()
	local var_5_2 = RoomInventoryBlockModel.instance:getSelectInventoryBlockMO()
	local var_5_3 = arg_5_0._scene.mapmgr:getBlockEntity(var_5_0.id, SceneTag.RoomMapBlock)

	if var_5_3 then
		arg_5_0._scene.mapmgr:destroyBlock(var_5_3)
	end

	arg_5_0._param.hexPoint = arg_5_0._param.hexPoint or var_5_0.hexPoint

	RoomMapBlockModel.instance:removeTempBlockMO()
	arg_5_0:_placeBlock()
end

function var_0_0._placeBlock(arg_6_0)
	local var_6_0 = arg_6_0._param.hexPoint
	local var_6_1 = RoomMapBlockModel.instance:getBlockMO(var_6_0.x, var_6_0.y)
	local var_6_2 = RoomInventoryBlockModel.instance:getSelectInventoryBlockMO()
	local var_6_3 = RoomMapBlockModel.instance:addTempBlockMO(var_6_2, var_6_0)

	RoomResourceModel.instance:clearLightResourcePoint()
	RoomMapBlockModel.instance:refreshNearRiver(var_6_0, 1)

	local var_6_4 = var_6_1 and arg_6_0._scene.mapmgr:getBlockEntity(var_6_1.id, SceneTag.RoomEmptyBlock)

	if var_6_4 then
		arg_6_0._scene.mapmgr:destroyBlock(var_6_4)
	end

	local var_6_5 = arg_6_0._scene.mapmgr:spawnMapBlock(var_6_3)

	var_6_5:playAnim(RoomScenePreloader.ResAnim.ContainerPlay, "container_play")
	var_6_5:playVxWaterEffect()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_board_put)
	arg_6_0:_refreshNearBlockEntity(false, var_6_0, true)
end

function var_0_0._changeBlock(arg_7_0)
	local var_7_0 = arg_7_0._param.hexPoint
	local var_7_1 = arg_7_0._param.rotate
	local var_7_2 = RoomMapBlockModel.instance:getTempBlockMO()

	var_7_0 = var_7_0 or var_7_2.hexPoint
	var_7_1 = var_7_1 or var_7_2.rotate

	local var_7_3 = HexPoint(var_7_2.hexPoint.x, var_7_2.hexPoint.y)
	local var_7_4 = var_7_2.rotate
	local var_7_5 = RoomMapBlockModel.instance:getBlockMO(var_7_0.x, var_7_0.y)
	local var_7_6 = RoomInventoryBlockModel.instance:getSelectInventoryBlockMO()

	RoomMapBlockModel.instance:changeTempBlockMO(var_7_0, var_7_1)
	RoomInventoryBlockModel.instance:rotateFirst(var_7_1)
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomMapBlockModel.instance:refreshNearRiver(var_7_0, 1)

	if var_7_3 ~= var_7_0 then
		RoomMapBlockModel.instance:refreshNearRiver(var_7_3, 1)
	end

	if var_7_3 ~= var_7_0 then
		local var_7_7 = var_7_5 and arg_7_0._scene.mapmgr:getBlockEntity(var_7_5.id, SceneTag.RoomEmptyBlock)

		if var_7_7 then
			arg_7_0._scene.mapmgr:destroyBlock(var_7_7)
		end

		local var_7_8 = arg_7_0._scene.mapmgr:getBlockEntity(var_7_2.id, SceneTag.RoomMapBlock)

		if var_7_8 then
			arg_7_0._scene.mapmgr:moveTo(var_7_8, var_7_0)
			var_7_8:playAnim(RoomScenePreloader.ResAnim.ContainerPlay, "container_play")
			var_7_8:playVxWaterEffect()
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_board_put)
		end

		local var_7_9 = RoomMapBlockModel.instance:getBlockMO(var_7_3.x, var_7_3.y)

		arg_7_0._scene.mapmgr:spawnMapBlock(var_7_9)
	end

	if var_7_4 ~= var_7_1 then
		local var_7_10 = arg_7_0._scene.mapmgr:getBlockEntity(var_7_2.id, SceneTag.RoomMapBlock)

		if var_7_10 then
			var_7_10:refreshRotation(true)
		end

		local var_7_11 = arg_7_0._scene.inventorymgr:getBlockEntity(var_7_6.id, SceneTag.RoomInventoryBlock)

		if var_7_11 then
			var_7_11:refreshRotation(true)
		end
	end

	local var_7_12 = arg_7_0._scene.mapmgr:getBlockEntity(var_7_2.id, SceneTag.RoomMapBlock)

	if var_7_12 then
		var_7_12:refreshBlock()
	end

	if var_7_3 ~= var_7_0 then
		arg_7_0:_refreshNearBlockEntity(false, var_7_3, false)
	end

	arg_7_0:_refreshNearBlockEntity(false, var_7_0, true)
end

function var_0_0._refreshNearBlockEntity(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	RoomBlockController.instance:refreshNearLand(arg_8_2, arg_8_3)
end

function var_0_0.stop(arg_9_0)
	return
end

function var_0_0.clear(arg_10_0)
	return
end

return var_0_0
