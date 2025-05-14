module("modules.logic.scene.room.fsm.RoomTransitionTryPlaceBuilding", package.seeall)

local var_0_0 = class("RoomTransitionTryPlaceBuilding", SimpleFSMBaseTransition)

function var_0_0.start(arg_1_0)
	arg_1_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0.check(arg_2_0)
	return true
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	arg_3_0._param = arg_3_1

	local var_3_0 = arg_3_0._param.buildingUid
	local var_3_1 = RoomMapBuildingModel.instance:getTempBuildingMO()
	local var_3_2 = arg_3_0._param.hexPoint or var_3_1 and var_3_1.hexPoint
	local var_3_3 = arg_3_0._param.press
	local var_3_4 = arg_3_0._param.focus
	local var_3_5 = true

	if var_3_1 and var_3_0 and var_3_1.uid ~= var_3_0 then
		arg_3_0:_replaceBuilding()
	elseif var_3_1 then
		arg_3_0:_changeBuilding()

		var_3_5 = false
	else
		arg_3_0:_placeBuilding()
	end

	if var_3_5 then
		RoomBuildingController.instance:dispatchEvent(RoomEvent.ClientPlaceBuilding, var_3_0)
		arg_3_0:_startDelayRefresh()
	end

	arg_3_0:onDone()
	RoomBuildingController.instance:refreshBuildingOccupy()

	if var_3_2 and (not var_3_3 or var_3_4) then
		local var_3_6 = HexMath.hexToPosition(var_3_2, RoomBlockEnum.BlockSize)

		if var_3_4 or arg_3_0:_isOutScreen(var_3_6) then
			local var_3_7 = {
				focusX = var_3_6.x,
				focusY = var_3_6.y
			}

			arg_3_0._scene.camera:tweenCamera(var_3_7, nil, arg_3_0.onDone, arg_3_0)
		end
	end
end

function var_0_0._startDelayRefresh(arg_4_0)
	if not arg_4_0._isStartDelayResfresh then
		arg_4_0._isStartDelayResfresh = true

		TaskDispatcher.runDelay(arg_4_0._onDelayRefresh, arg_4_0, 0.05)
	end
end

function var_0_0._onDelayRefresh(arg_5_0)
	arg_5_0._isStartDelayResfresh = false

	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingCanConfirm)
end

function var_0_0._isOutScreen(arg_6_0, arg_6_1)
	return RoomHelper.isOutCameraFocus(arg_6_1)
end

function var_0_0._replaceBuilding(arg_7_0)
	local var_7_0 = RoomMapBuildingModel.instance:getTempBuildingMO()

	arg_7_0:_addBuildingNearBlock(var_7_0.buildingId, var_7_0.hexPoint, var_7_0.rotate)

	local var_7_1 = arg_7_0._scene.buildingmgr:getBuildingEntity(var_7_0.id, SceneTag.RoomBuilding)

	if var_7_0.buildingState == RoomBuildingEnum.BuildingState.Temp then
		RoomMapBuildingModel.instance:removeTempBuildingMO()

		if var_7_1 then
			arg_7_0._scene.buildingmgr:destroyBuilding(var_7_1)
		end
	elseif var_7_0.buildingState == RoomBuildingEnum.BuildingState.Revert then
		local var_7_2, var_7_3, var_7_4 = RoomMapBuildingModel.instance:removeRevertBuildingMO()

		arg_7_0:_addBuildingNearBlock(var_7_2, var_7_3, var_7_4)

		if var_7_1 then
			arg_7_0._scene.buildingmgr:moveTo(var_7_1, var_7_3)
			var_7_1:refreshRotation()
			var_7_1:refreshBuilding()
		end

		RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingUIRefreshUI, var_7_0.id)
	end

	arg_7_0:_placeBuilding()
end

function var_0_0._changeBuilding(arg_8_0)
	local var_8_0 = arg_8_0._param.hexPoint
	local var_8_1 = arg_8_0._param.rotate
	local var_8_2 = arg_8_0._param.focus
	local var_8_3 = arg_8_0._param.press
	local var_8_4 = RoomMapBuildingModel.instance:getTempBuildingMO()

	var_8_0 = var_8_0 or var_8_4.hexPoint
	var_8_1 = var_8_1 or var_8_4.rotate

	arg_8_0:_addBuildingNearBlock(var_8_4.buildingId, var_8_4.hexPoint, var_8_4.rotate)

	local var_8_5 = HexPoint(var_8_4.hexPoint.x, var_8_4.hexPoint.y)
	local var_8_6 = var_8_4.rotate

	RoomMapBuildingModel.instance:changeTempBuildingMO(var_8_0, var_8_1)
	arg_8_0:_addBuildingNearBlock(var_8_4.buildingId, var_8_4.hexPoint, var_8_4.rotate)

	if var_8_5 ~= var_8_0 or var_8_3 then
		local var_8_7 = arg_8_0._scene.buildingmgr:getBuildingEntity(var_8_4.id, SceneTag.RoomBuilding)

		if var_8_7 then
			arg_8_0._scene.buildingmgr:moveTo(var_8_7, var_8_0)
		end

		if not var_8_3 then
			arg_8_0:_playAnimatorOpen(var_8_7)
		end
	end

	if var_8_6 ~= var_8_1 then
		local var_8_8 = arg_8_0._scene.buildingmgr:getBuildingEntity(var_8_4.id, SceneTag.RoomBuilding)

		if var_8_8 then
			var_8_8:refreshRotation(true)
			var_8_8:refreshBuilding()
		end
	end

	RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingUIRefreshUI, var_8_4.id)
end

function var_0_0._placeBuilding(arg_9_0)
	local var_9_0 = arg_9_0._param.buildingUid
	local var_9_1 = arg_9_0._param.hexPoint
	local var_9_2 = arg_9_0._param.rotate
	local var_9_3 = arg_9_0._param.press
	local var_9_4 = RoomMapBuildingModel.instance:revertTempBuildingMO(var_9_0)

	if not var_9_4 then
		local var_9_5 = RoomInventoryBuildingModel.instance:getBuildingMOById(var_9_0)

		RoomMapBuildingModel.instance:addTempBuildingMO(var_9_5, var_9_1)
	end

	local var_9_6 = RoomMapBuildingModel.instance:getTempBuildingMO()

	if var_9_6 then
		RoomMapBuildingModel.instance:changeTempBuildingMO(var_9_1, var_9_2)
		arg_9_0:_addBuildingNearBlock(var_9_6.buildingId, var_9_6.hexPoint, var_9_6.rotate)

		local var_9_7 = arg_9_0._scene.buildingmgr:getBuildingEntity(var_9_6.id, SceneTag.RoomBuilding)

		if var_9_7 then
			arg_9_0._scene.buildingmgr:moveTo(var_9_7, var_9_1)
			var_9_7:refreshRotation()
			var_9_7:refreshBuilding()

			if var_9_4 then
				arg_9_0:_playAnimatorOpen(var_9_7)
			end
		else
			local var_9_8 = arg_9_0._scene.buildingmgr:spawnMapBuilding(var_9_6)

			arg_9_0:_playAnimatorOpen(var_9_8)
		end

		RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingUIRefreshUI, var_9_6.id)
	end

	arg_9_0:onDone()
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshResourceUIShow)
end

function var_0_0._addBuildingNearBlock(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_2 then
		return
	end

	RoomBuildingController.instance:addWaitRefreshBuildingNearBlock(arg_10_1, arg_10_2, arg_10_3)
end

function var_0_0._playAnimatorOpen(arg_11_0, arg_11_1)
	if arg_11_1 then
		arg_11_1:playAnimator("open")

		local var_11_0 = arg_11_1:getAlphaThresholdValue() or 0

		arg_11_1:tweenAlphaThreshold(1, var_11_0, 0.5)
	end
end

function var_0_0.stop(arg_12_0)
	return
end

function var_0_0.clear(arg_13_0)
	return
end

return var_0_0
