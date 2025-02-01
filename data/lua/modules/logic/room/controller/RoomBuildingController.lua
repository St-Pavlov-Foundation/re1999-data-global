module("modules.logic.room.controller.RoomBuildingController", package.seeall)

slot0 = class("RoomBuildingController", BaseController)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	slot0._isBuildingListShow = false
	slot0._pressBuildingUid = nil
	slot0._pressBuildingHexPoint = nil
end

function slot0.addConstEvents(slot0)
	uv0.instance:registerCallback(RoomEvent.GuideFocusBuilding, slot0._onGuideFocusBuilding, slot0)
end

function slot0._onGuideFocusBuilding(slot0, slot1)
	slot0:focusBuilding(tonumber(slot1))
end

function slot0.pressBuildingUp(slot0, slot1, slot2)
	if slot2 then
		slot0._pressBuildingUid = slot2
	end

	if not slot0._pressBuildingUid then
		return
	end

	if not GameSceneMgr.instance:getCurScene().buildingmgr:getBuildingEntity(slot0._pressBuildingUid, SceneTag.RoomBuilding) then
		return
	end

	if slot2 then
		if not RoomMapBuildingModel.instance:getTempBuildingMO() or slot5.id ~= slot2 then
			slot6 = RoomMapBuildingModel.instance:getBuildingMOById(slot2)

			slot3.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, {
				press = true,
				buildingUid = slot2,
				hexPoint = slot6.hexPoint,
				rotate = slot6.rotate
			})
		elseif slot5 then
			slot0:addWaitRefreshBuildingNearBlock(slot5.buildingId, slot5.hexPoint, slot5.rotate)
		end

		slot4:tweenUp()
		slot4:refreshBuilding()
		RoomShowBuildingListModel.instance:setSelect(slot2)
	end

	if not slot0._pressBuildingHexPoint then
		slot0._pressBuildingHexPoint = RoomMapBuildingModel.instance:getTempBuildingMO().hexPoint
	end

	slot6 = slot0._pressBuildingHexPoint

	if not RoomBendingHelper.screenPosToHex(slot1) then
		return
	end

	slot0._pressBuildingHexPoint = slot7

	if slot6 ~= slot7 or slot2 then
		RoomMapBuildingModel.instance:clearLightResourcePoint()
		RoomMapBuildingModel.instance:clearTempOccupyDict()
		RoomMapBuildingModel.instance:changeTempBuildingMO(slot7, slot5.rotate)
		RoomResourceModel.instance:clearLightResourcePoint()
		slot0:refreshBuildingOccupy()
	end

	if RoomBendingHelper.screenToWorld(slot1) then
		slot4:setLocalPos(slot8.x, 0, slot8.y)
	end

	slot0:dispatchEvent(RoomEvent.PressBuildingUp)
	slot0:_cancelDelayBuildingDown()
end

function slot0.refreshBuildingOccupy(slot0)
	for slot6 = 1, RoomBuildingEnum.MaxBuildingOccupyNum do
		if GameSceneMgr.instance:getCurScene().buildingmgr:spawnMapBuildingOccupy(slot6) then
			slot7:refreshTempOccupy()
		end
	end
end

function slot0.addWaitRefreshBuildingNearBlock(slot0, slot1, slot2, slot3)
	if not slot2 then
		return
	end

	slot0._waitMapBlockMOList, slot0._waitMapBlockMODict = RoomBlockHelper.getBlockMOListByPlaceBuilding(slot1, slot2, slot3, slot0._waitMapBlockMOList, slot0._waitMapBlockMODict)

	if (slot0._waitMapBlockMOList and #slot0._waitMapBlockMOList or 0) <= 0 and slot0._waitMapBlockMOList and #slot0._waitMapBlockMOList > 0 then
		TaskDispatcher.runDelay(slot0._runWaitRefreshBuildingNearBlock, slot0, 0.017)
	end
end

function slot0._runWaitRefreshBuildingNearBlock(slot0)
	if slot0._waitMapBlockMOList and #slot1 > 0 then
		slot0._waitMapBlockMOList = nil
		slot0._waitMapBlockMODict = nil

		RoomMapController.instance:updateBlockReplaceDefineId(slot1)

		for slot5, slot6 in ipairs(slot1) do
			slot6:refreshRiver()
		end

		if GameSceneMgr.instance:getCurScene().mapmgr then
			for slot7, slot8 in ipairs(slot1) do
				if slot3:getBlockEntity(slot8.id, SceneTag.RoomMapBlock) then
					slot9:refreshLand()
					slot9:refreshRotation()
				end
			end
		end
	end
end

function slot0.getPressBuildingHexPoint(slot0)
	return slot0._pressBuildingHexPoint
end

function slot0.dropBuildingDown(slot0, slot1)
	if not slot0._pressBuildingUid then
		return
	end

	if not RoomMapBuildingModel.instance:getBuildingMOById(slot0._pressBuildingUid) then
		return
	end

	slot3, slot4 = nil

	if slot1 and RoomBendingHelper.screenPosToHex(slot1) then
		slot3, slot4 = RoomBuildingHelper.getNearCanPlaceHexPoint(slot0._pressBuildingUid, slot5)
	end

	slot3 = slot3 or slot2.hexPoint
	slot4 = slot4 or slot2.rotate

	slot0:cancelPressBuilding(slot3, slot4)
	GameSceneMgr.instance:getCurScene().fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, {
		press = false,
		hexPoint = slot3,
		rotate = slot4
	})
end

function slot0.cancelPressBuilding(slot0, slot1, slot2)
	if not slot0._pressBuildingUid then
		return
	end

	slot4 = RoomMapBuildingModel.instance:getTempBuildingMO() and slot3.buildingId

	if not GameSceneMgr.instance:getCurScene().buildingmgr:getBuildingEntity(slot0._pressBuildingUid, SceneTag.RoomBuilding) then
		return
	end

	slot0._pressBuildingUid = nil
	slot0._pressBuildingHexPoint = nil

	if slot4 and slot1 and slot2 then
		RoomMapBuildingModel.instance:clearTempOccupyDict()
		slot0:addWaitRefreshBuildingNearBlock(slot4, slot1, slot2)
	end

	if slot1 then
		slot7 = HexMath.hexToPosition(slot1, RoomBlockEnum.BlockSize)

		slot6:setLocalPos(slot7.x, 0, slot7.y)
	end

	slot6:tweenDown()
	slot6:refreshBuilding()
	slot0:_addDelayBuildingDown()
end

function slot0._addDelayBuildingDown(slot0)
	slot0:_cancelDelayBuildingDown()

	slot0._hasWaitingRunBuildingDown = false

	TaskDispatcher.runDelay(slot0._runDelayBuildingDown, slot0, 0.21)
end

function slot0._cancelDelayBuildingDown(slot0)
	if slot0._hasWaitingRunBuildingDown then
		slot0._hasWaitingRunBuildingDown = false

		TaskDispatcher.cancelTask(slot0._runDelayBuildingDown, slot0)
	end
end

function slot0._runDelayBuildingDown(slot0)
	slot0._hasWaitingRunBuildingDown = false

	slot0:dispatchEvent(RoomEvent.DropBuildingDown)
end

function slot0.isPressBuilding(slot0)
	return slot0._pressBuildingUid
end

function slot0.setBuildingListShow(slot0, slot1, slot2)
	slot0._isBuildingListShow = slot1
	slot3 = GameSceneMgr.instance:getCurScene()

	if slot1 and slot3.camera:getCameraState() == RoomEnum.CameraState.Normal then
		slot3.camera:switchCameraState(RoomEnum.CameraState.Overlook, {})
	end

	slot0:dispatchEvent(RoomEvent.BuildingListShowChanged, slot1)

	if RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm) then
		slot3.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBuilding)
	end

	if RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceConfirm) or RoomHelper.isFSMState(RoomEnum.FSMEditState.BackConfirm) then
		slot3.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
		slot3.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
	end

	if slot2 ~= true then
		RoomMapController.instance:dispatchEvent(RoomEvent.SelectBlock)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingCanConfirm)
end

function slot0.isBuildingListShow(slot0)
	return slot0._isBuildingListShow
end

slot0.SEND_BUY_BUILDING_RPC = "RoomBuildingController.SEND_BUY_BUILDING_RPC"

function slot0.sendBuyManufactureBuildingRpc(slot0, slot1)
	UIBlockMgr.instance:startBlock(uv0.SEND_BUY_BUILDING_RPC)
	RoomRpc.instance:sendBuyManufactureBuildingRequest(slot1, slot0._onBuyManufactureBuildingRpcReply, slot0)
end

function slot0._onBuyManufactureBuildingRpcReply(slot0, slot1, slot2, slot3)
	UIBlockMgr.instance:endBlock(uv0.SEND_BUY_BUILDING_RPC)

	if slot2 == 0 then
		if RoomMapBuildingModel.instance:getTempBuildingMO() and slot4.buildingId == slot3.buildingId then
			slot6, slot7 = RoomBuildingHelper.canConfirmPlace(slot4.buildingId, slot4.hexPoint, slot4.rotate, nil, , false, slot4.levels, true)

			if slot6 then
				RoomMapController.instance:useBuildingRequest(slot3.buildingUid, slot4.rotate, slot5.x, slot5.y)
			end
		end

		ViewMgr.instance:closeView(ViewName.RoomManufacturePlaceCostView)
	end
end

function slot0.buyManufactureBuildingInfoReply(slot0, slot1)
	slot2 = {
		{
			use = false,
			rotate = 0,
			level = 0,
			uid = slot1.buildingUid,
			defineId = slot1.buildingId
		}
	}

	RoomModel.instance:updateBuildingInfos(slot2)
	RoomModel.instance:updateBuildingInfos(slot2)
	RoomInventoryBuildingModel.instance:addBuilding(slot2)

	slot3, slot4 = RoomMapBuildingModel.instance:changeTempBuildingMOUid(slot1.buildingUid, slot1.buildingId)

	if slot3 and GameSceneMgr.instance:getCurScene() and slot5.buildingmgr then
		slot5.buildingmgr:changeBuildingEntityId(slot4, slot1.buildingUid)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.NewBuildingPush)
end

function slot0.focusBuilding(slot0, slot1)
	for slot6, slot7 in ipairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
		if slot7.buildingId == slot1 then
			slot0:tweenCameraFocusBuilding(slot7.buildingUid)

			return
		end
	end
end

function slot0.tweenCameraFocusBuilding(slot0, slot1)
	if not RoomMapBuildingModel.instance:getBuildingMOById(slot1) then
		return
	end

	slot5 = RoomMapModel.instance:getBuildingConfigParam(slot2.buildingId).offset
	slot6 = slot2.rotate
	slot9 = HexMath.hexToPosition(slot2.hexPoint, RoomBlockEnum.BlockSize)

	GameSceneMgr.instance:getCurScene().camera:switchCameraState(RoomEnum.CameraState.Overlook, {
		focusX = slot9.x + slot5.x * math.cos(slot6) + slot5.y * math.sin(slot6),
		focusY = slot9.y + slot5.y * math.cos(slot6) - slot5.x * math.sin(slot6)
	})
end

function slot0.tweenCameraFocusPart(slot0, slot1, slot2, slot3)
	slot1 = slot1 or 0
	slot2 = slot2 or RoomEnum.CameraState.Overlook
	slot4 = GameSceneMgr.instance:getCurScene()
	slot5 = nil

	if not ((slot1 ~= 0 or slot4.buildingmgr:getInitBuildingGO()) and slot4.buildingmgr:getPartBuildingGO(slot1)) then
		return
	end

	slot6 = RoomBuildingHelper.getCenterPosition(slot5)
	slot7 = LuaUtil.deepCopy(slot4.camera:getCameraParam())
	slot7.focusX = slot6.x
	slot7.focusY = slot6.z
	slot7.zoom = slot3

	if slot2 == RoomEnum.CameraState.Normal then
		slot7.isPart = true
		slot8 = slot4.camera:cameraParamToRealCameraParam(slot7, RoomEnum.CameraState.Normal)

		if RoomInitBuildingHelper.getPartRealCameraParam(slot1) then
			for slot13, slot14 in pairs(slot8) do
				if slot9[slot13] then
					slot8[slot13] = slot9[slot13]
				end
			end
		end

		slot4.camera:switchCameraStateWithRealCameraParam(slot2, slot8)
	else
		slot4.camera:switchCameraState(slot2, slot7)
	end
end

slot0.instance = slot0.New()

return slot0
