module("modules.logic.scene.room.fsm.RoomTransitionConfirmPlaceBlock", package.seeall)

local var_0_0 = class("RoomTransitionConfirmPlaceBlock", JompFSMBaseTransition)

function var_0_0.start(arg_1_0)
	arg_1_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.check(arg_2_0)
	return true
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	arg_3_0._param = arg_3_1
	arg_3_0._animDone = false

	local var_3_0 = arg_3_0._param.tempBlockMO
	local var_3_1 = var_3_0.hexPoint
	local var_3_2 = var_3_1:getInRanges(RoomBlockEnum.EmptyBlockDistanceStyleCount, true)

	for iter_3_0, iter_3_1 in ipairs(var_3_2) do
		local var_3_3 = RoomMapBlockModel.instance:getBlockMO(iter_3_1.x, iter_3_1.y)

		if var_3_3 and var_3_3.blockState == RoomBlockEnum.BlockState.Water and not arg_3_0._scene.mapmgr:getBlockEntity(var_3_3.id, SceneTag.RoomEmptyBlock) then
			local var_3_4 = arg_3_0._scene.mapmgr:spawnMapBlock(var_3_3)
		end
	end

	local var_3_5 = arg_3_0._scene.mapmgr:getBlockEntity(var_3_0.id, SceneTag.RoomMapBlock)

	if var_3_5 then
		var_3_5:refreshBlock()
		var_3_5:refreshRotation()
		var_3_5:playSmokeEffect()
		var_3_5:playAmbientAudio()
	end

	local var_3_6 = var_3_1:getNeighbors()

	for iter_3_2, iter_3_3 in ipairs(var_3_6) do
		local var_3_7 = RoomMapBlockModel.instance:getBlockMO(iter_3_3.x, iter_3_3.y)

		if var_3_7 and var_3_7.blockState == RoomBlockEnum.BlockState.Map and arg_3_0:_isNeighborsCanAnim(iter_3_3.x, iter_3_3.y) then
			local var_3_8 = arg_3_0._scene.mapmgr:getBlockEntity(var_3_7.id, SceneTag.RoomMapBlock)

			if var_3_8 then
				var_3_8:playAnim(RoomScenePreloader.ResAnim.ContainerUp, "container_up")
			end
		end
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.UpdateWater)
	RoomMapController.instance:dispatchEvent(RoomEvent.UpdateInventoryCount)
	arg_3_0._scene.inventorymgr:playForwardAnim(arg_3_0._animCallback, arg_3_0)
	RoomBlockController.instance:refreshResourceLight()
	RoomMapController.instance:dispatchEvent(RoomEvent.ConfirmBlock)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_board_fix)
end

function var_0_0._isNeighborsCanAnim(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = RoomMapBuildingModel.instance:getBuildingParam(arg_4_1, arg_4_2)

	if var_4_0 and RoomBuildingEnum.NotPlaceBlockAnimDict[var_4_0.buildingId] then
		return false
	end

	return true
end

function var_0_0._animCallback(arg_5_0)
	local var_5_0 = arg_5_0._param.tempBlockMO.hexPoint
	local var_5_1 = RoomBlockHelper.getNearBlockEntity(false, var_5_0, 1, true)

	RoomBlockHelper.refreshBlockEntity(var_5_1, "refreshSideShow")
	arg_5_0._scene.inventorymgr:moveForward()

	arg_5_0._animDone = true

	arg_5_0:_checkDone()
end

function var_0_0._checkDone(arg_6_0)
	if arg_6_0._animDone then
		local var_6_0 = arg_6_0._param.tempBlockMO

		RoomMapController.instance:dispatchEvent(RoomEvent.OnUseBlock, var_6_0.id)
		arg_6_0:onDone()
	end
end

function var_0_0.stop(arg_7_0)
	return
end

function var_0_0.clear(arg_8_0)
	return
end

return var_0_0
