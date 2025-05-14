module("modules.logic.room.controller.RoomBuildingController", package.seeall)

local var_0_0 = class("RoomBuildingController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	arg_3_0._isBuildingListShow = false
	arg_3_0._pressBuildingUid = nil
	arg_3_0._pressBuildingHexPoint = nil
end

function var_0_0.addConstEvents(arg_4_0)
	var_0_0.instance:registerCallback(RoomEvent.GuideFocusBuilding, arg_4_0._onGuideFocusBuilding, arg_4_0)
end

function var_0_0._onGuideFocusBuilding(arg_5_0, arg_5_1)
	arg_5_0:focusBuilding(tonumber(arg_5_1))
end

function var_0_0.pressBuildingUp(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 then
		arg_6_0._pressBuildingUid = arg_6_2
	end

	if not arg_6_0._pressBuildingUid then
		return
	end

	local var_6_0 = GameSceneMgr.instance:getCurScene()
	local var_6_1 = var_6_0.buildingmgr:getBuildingEntity(arg_6_0._pressBuildingUid, SceneTag.RoomBuilding)

	if not var_6_1 then
		return
	end

	if arg_6_2 then
		local var_6_2 = RoomMapBuildingModel.instance:getTempBuildingMO()

		if not var_6_2 or var_6_2.id ~= arg_6_2 then
			local var_6_3 = RoomMapBuildingModel.instance:getBuildingMOById(arg_6_2)

			var_6_0.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, {
				press = true,
				buildingUid = arg_6_2,
				hexPoint = var_6_3.hexPoint,
				rotate = var_6_3.rotate
			})
		elseif var_6_2 then
			arg_6_0:addWaitRefreshBuildingNearBlock(var_6_2.buildingId, var_6_2.hexPoint, var_6_2.rotate)
		end

		var_6_1:tweenUp()
		var_6_1:refreshBuilding()
		RoomShowBuildingListModel.instance:setSelect(arg_6_2)
	end

	local var_6_4 = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not arg_6_0._pressBuildingHexPoint then
		arg_6_0._pressBuildingHexPoint = var_6_4.hexPoint
	end

	local var_6_5 = arg_6_0._pressBuildingHexPoint
	local var_6_6 = RoomBendingHelper.screenPosToHex(arg_6_1)

	if not var_6_6 then
		return
	end

	arg_6_0._pressBuildingHexPoint = var_6_6

	if var_6_5 ~= var_6_6 or arg_6_2 then
		RoomMapBuildingModel.instance:clearLightResourcePoint()
		RoomMapBuildingModel.instance:clearTempOccupyDict()
		RoomMapBuildingModel.instance:changeTempBuildingMO(var_6_6, var_6_4.rotate)
		RoomResourceModel.instance:clearLightResourcePoint()
		arg_6_0:refreshBuildingOccupy()
	end

	local var_6_7 = RoomBendingHelper.screenToWorld(arg_6_1)

	if var_6_7 then
		var_6_1:setLocalPos(var_6_7.x, 0, var_6_7.y)
	end

	arg_6_0:dispatchEvent(RoomEvent.PressBuildingUp)
	arg_6_0:_cancelDelayBuildingDown()
end

function var_0_0.refreshBuildingOccupy(arg_7_0)
	local var_7_0 = GameSceneMgr.instance:getCurScene()
	local var_7_1 = RoomBuildingEnum.MaxBuildingOccupyNum

	for iter_7_0 = 1, var_7_1 do
		local var_7_2 = var_7_0.buildingmgr:spawnMapBuildingOccupy(iter_7_0)

		if var_7_2 then
			var_7_2:refreshTempOccupy()
		end
	end
end

function var_0_0.addWaitRefreshBuildingNearBlock(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_2 then
		return
	end

	local var_8_0 = arg_8_0._waitMapBlockMOList and #arg_8_0._waitMapBlockMOList or 0

	arg_8_0._waitMapBlockMOList, arg_8_0._waitMapBlockMODict = RoomBlockHelper.getBlockMOListByPlaceBuilding(arg_8_1, arg_8_2, arg_8_3, arg_8_0._waitMapBlockMOList, arg_8_0._waitMapBlockMODict)

	if var_8_0 <= 0 and arg_8_0._waitMapBlockMOList and #arg_8_0._waitMapBlockMOList > 0 then
		TaskDispatcher.runDelay(arg_8_0._runWaitRefreshBuildingNearBlock, arg_8_0, 0.017)
	end
end

function var_0_0._runWaitRefreshBuildingNearBlock(arg_9_0)
	local var_9_0 = arg_9_0._waitMapBlockMOList

	if var_9_0 and #var_9_0 > 0 then
		arg_9_0._waitMapBlockMOList = nil
		arg_9_0._waitMapBlockMODict = nil

		RoomMapController.instance:updateBlockReplaceDefineId(var_9_0)

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			iter_9_1:refreshRiver()
		end

		local var_9_1 = GameSceneMgr.instance:getCurScene().mapmgr

		if var_9_1 then
			for iter_9_2, iter_9_3 in ipairs(var_9_0) do
				local var_9_2 = var_9_1:getBlockEntity(iter_9_3.id, SceneTag.RoomMapBlock)

				if var_9_2 then
					var_9_2:refreshLand()
					var_9_2:refreshRotation()
				end
			end
		end
	end
end

function var_0_0.getPressBuildingHexPoint(arg_10_0)
	return arg_10_0._pressBuildingHexPoint
end

function var_0_0.dropBuildingDown(arg_11_0, arg_11_1)
	if not arg_11_0._pressBuildingUid then
		return
	end

	local var_11_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_11_0._pressBuildingUid)

	if not var_11_0 then
		return
	end

	local var_11_1
	local var_11_2
	local var_11_3 = arg_11_1 and RoomBendingHelper.screenPosToHex(arg_11_1)

	if var_11_3 then
		var_11_1, var_11_2 = RoomBuildingHelper.getNearCanPlaceHexPoint(arg_11_0._pressBuildingUid, var_11_3)
	end

	var_11_1 = var_11_1 or var_11_0.hexPoint
	var_11_2 = var_11_2 or var_11_0.rotate

	local var_11_4 = GameSceneMgr.instance:getCurScene()
	local var_11_5 = {
		press = false,
		hexPoint = var_11_1,
		rotate = var_11_2
	}

	arg_11_0:cancelPressBuilding(var_11_1, var_11_2)
	var_11_4.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, var_11_5)
end

function var_0_0.cancelPressBuilding(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0._pressBuildingUid then
		return
	end

	local var_12_0 = RoomMapBuildingModel.instance:getTempBuildingMO()
	local var_12_1 = var_12_0 and var_12_0.buildingId
	local var_12_2 = GameSceneMgr.instance:getCurScene().buildingmgr:getBuildingEntity(arg_12_0._pressBuildingUid, SceneTag.RoomBuilding)

	if not var_12_2 then
		return
	end

	arg_12_0._pressBuildingUid = nil
	arg_12_0._pressBuildingHexPoint = nil

	if var_12_1 and arg_12_1 and arg_12_2 then
		RoomMapBuildingModel.instance:clearTempOccupyDict()
		arg_12_0:addWaitRefreshBuildingNearBlock(var_12_1, arg_12_1, arg_12_2)
	end

	if arg_12_1 then
		local var_12_3 = HexMath.hexToPosition(arg_12_1, RoomBlockEnum.BlockSize)

		var_12_2:setLocalPos(var_12_3.x, 0, var_12_3.y)
	end

	var_12_2:tweenDown()
	var_12_2:refreshBuilding()
	arg_12_0:_addDelayBuildingDown()
end

function var_0_0._addDelayBuildingDown(arg_13_0)
	arg_13_0:_cancelDelayBuildingDown()

	arg_13_0._hasWaitingRunBuildingDown = false

	TaskDispatcher.runDelay(arg_13_0._runDelayBuildingDown, arg_13_0, 0.21)
end

function var_0_0._cancelDelayBuildingDown(arg_14_0)
	if arg_14_0._hasWaitingRunBuildingDown then
		arg_14_0._hasWaitingRunBuildingDown = false

		TaskDispatcher.cancelTask(arg_14_0._runDelayBuildingDown, arg_14_0)
	end
end

function var_0_0._runDelayBuildingDown(arg_15_0)
	arg_15_0._hasWaitingRunBuildingDown = false

	arg_15_0:dispatchEvent(RoomEvent.DropBuildingDown)
end

function var_0_0.isPressBuilding(arg_16_0)
	return arg_16_0._pressBuildingUid
end

function var_0_0.setBuildingListShow(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._isBuildingListShow = arg_17_1

	local var_17_0 = GameSceneMgr.instance:getCurScene()

	if arg_17_1 and var_17_0.camera:getCameraState() == RoomEnum.CameraState.Normal then
		var_17_0.camera:switchCameraState(RoomEnum.CameraState.Overlook, {})
	end

	arg_17_0:dispatchEvent(RoomEvent.BuildingListShowChanged, arg_17_1)

	if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm) then
		var_17_0.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBuilding)
	end

	if RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceConfirm) or RoomHelper.isFSMState(RoomEnum.FSMEditState.BackConfirm) then
		var_17_0.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
		var_17_0.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
	end

	if arg_17_2 ~= true then
		RoomMapController.instance:dispatchEvent(RoomEvent.SelectBlock)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingCanConfirm)
end

function var_0_0.isBuildingListShow(arg_18_0)
	return arg_18_0._isBuildingListShow
end

var_0_0.SEND_BUY_BUILDING_RPC = "RoomBuildingController.SEND_BUY_BUILDING_RPC"

function var_0_0.sendBuyManufactureBuildingRpc(arg_19_0, arg_19_1)
	UIBlockMgr.instance:startBlock(var_0_0.SEND_BUY_BUILDING_RPC)
	RoomRpc.instance:sendBuyManufactureBuildingRequest(arg_19_1, arg_19_0._onBuyManufactureBuildingRpcReply, arg_19_0)
end

function var_0_0._onBuyManufactureBuildingRpcReply(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	UIBlockMgr.instance:endBlock(var_0_0.SEND_BUY_BUILDING_RPC)

	if arg_20_2 == 0 then
		local var_20_0 = RoomMapBuildingModel.instance:getTempBuildingMO()

		if var_20_0 and var_20_0.buildingId == arg_20_3.buildingId then
			local var_20_1 = var_20_0.hexPoint
			local var_20_2, var_20_3 = RoomBuildingHelper.canConfirmPlace(var_20_0.buildingId, var_20_1, var_20_0.rotate, nil, nil, false, var_20_0.levels, true)

			if var_20_2 then
				RoomMapController.instance:useBuildingRequest(arg_20_3.buildingUid, var_20_0.rotate, var_20_1.x, var_20_1.y)
			end
		end

		ViewMgr.instance:closeView(ViewName.RoomManufacturePlaceCostView)
	end
end

function var_0_0.buyManufactureBuildingInfoReply(arg_21_0, arg_21_1)
	local var_21_0 = {
		{
			use = false,
			rotate = 0,
			level = 0,
			uid = arg_21_1.buildingUid,
			defineId = arg_21_1.buildingId
		}
	}

	RoomModel.instance:updateBuildingInfos(var_21_0)
	RoomModel.instance:updateBuildingInfos(var_21_0)
	RoomInventoryBuildingModel.instance:addBuilding(var_21_0)

	local var_21_1, var_21_2 = RoomMapBuildingModel.instance:changeTempBuildingMOUid(arg_21_1.buildingUid, arg_21_1.buildingId)

	if var_21_1 then
		local var_21_3 = GameSceneMgr.instance:getCurScene()

		if var_21_3 and var_21_3.buildingmgr then
			var_21_3.buildingmgr:changeBuildingEntityId(var_21_2, arg_21_1.buildingUid)
		end
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.NewBuildingPush)
end

function var_0_0.focusBuilding(arg_22_0, arg_22_1)
	local var_22_0 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if iter_22_1.buildingId == arg_22_1 then
			arg_22_0:tweenCameraFocusBuilding(iter_22_1.buildingUid)

			return
		end
	end
end

function var_0_0.tweenCameraFocusBuilding(arg_23_0, arg_23_1)
	local var_23_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_23_1)

	if not var_23_0 then
		return
	end

	local var_23_1 = GameSceneMgr.instance:getCurScene()
	local var_23_2 = RoomMapModel.instance:getBuildingConfigParam(var_23_0.buildingId).offset
	local var_23_3 = var_23_0.rotate
	local var_23_4 = var_23_2.x * math.cos(var_23_3) + var_23_2.y * math.sin(var_23_3)
	local var_23_5 = var_23_2.y * math.cos(var_23_3) - var_23_2.x * math.sin(var_23_3)
	local var_23_6 = HexMath.hexToPosition(var_23_0.hexPoint, RoomBlockEnum.BlockSize)

	var_23_1.camera:switchCameraState(RoomEnum.CameraState.Overlook, {
		focusX = var_23_6.x + var_23_4,
		focusY = var_23_6.y + var_23_5
	})
end

function var_0_0.tweenCameraFocusPart(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	arg_24_1 = arg_24_1 or 0
	arg_24_2 = arg_24_2 or RoomEnum.CameraState.Overlook

	local var_24_0 = GameSceneMgr.instance:getCurScene()
	local var_24_1

	if arg_24_1 == 0 then
		var_24_1 = var_24_0.buildingmgr:getInitBuildingGO()
	else
		var_24_1 = var_24_0.buildingmgr:getPartBuildingGO(arg_24_1)
	end

	if not var_24_1 then
		return
	end

	local var_24_2 = RoomBuildingHelper.getCenterPosition(var_24_1)
	local var_24_3 = LuaUtil.deepCopy(var_24_0.camera:getCameraParam())

	var_24_3.focusX = var_24_2.x
	var_24_3.focusY = var_24_2.z
	var_24_3.zoom = arg_24_3

	if arg_24_2 == RoomEnum.CameraState.Normal then
		var_24_3.isPart = true

		local var_24_4 = var_24_0.camera:cameraParamToRealCameraParam(var_24_3, RoomEnum.CameraState.Normal)
		local var_24_5 = RoomInitBuildingHelper.getPartRealCameraParam(arg_24_1)

		if var_24_5 then
			for iter_24_0, iter_24_1 in pairs(var_24_4) do
				if var_24_5[iter_24_0] then
					var_24_4[iter_24_0] = var_24_5[iter_24_0]
				end
			end
		end

		var_24_0.camera:switchCameraStateWithRealCameraParam(arg_24_2, var_24_4)
	else
		var_24_0.camera:switchCameraState(arg_24_2, var_24_3)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
