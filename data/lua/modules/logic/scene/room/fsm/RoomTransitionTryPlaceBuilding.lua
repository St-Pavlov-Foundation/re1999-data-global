module("modules.logic.scene.room.fsm.RoomTransitionTryPlaceBuilding", package.seeall)

slot0 = class("RoomTransitionTryPlaceBuilding", SimpleFSMBaseTransition)

function slot0.start(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.check(slot0)
	return true
end

function slot0.onStart(slot0, slot1)
	slot0._param = slot1
	slot2 = slot0._param.buildingUid
	slot3 = RoomMapBuildingModel.instance:getTempBuildingMO()
	slot4 = slot0._param.hexPoint or slot3 and slot3.hexPoint
	slot5 = slot0._param.press
	slot6 = slot0._param.focus
	slot7 = true

	if slot3 and slot2 and slot3.uid ~= slot2 then
		slot0:_replaceBuilding()
	elseif slot3 then
		slot0:_changeBuilding()

		slot7 = false
	else
		slot0:_placeBuilding()
	end

	if slot7 then
		RoomBuildingController.instance:dispatchEvent(RoomEvent.ClientPlaceBuilding, slot2)
		slot0:_startDelayRefresh()
	end

	slot0:onDone()
	RoomBuildingController.instance:refreshBuildingOccupy()

	if slot4 and (not slot5 or slot6) then
		slot8 = HexMath.hexToPosition(slot4, RoomBlockEnum.BlockSize)

		if slot6 or slot0:_isOutScreen(slot8) then
			slot0._scene.camera:tweenCamera({
				focusX = slot8.x,
				focusY = slot8.y
			}, nil, slot0.onDone, slot0)
		end
	end
end

function slot0._startDelayRefresh(slot0)
	if not slot0._isStartDelayResfresh then
		slot0._isStartDelayResfresh = true

		TaskDispatcher.runDelay(slot0._onDelayRefresh, slot0, 0.05)
	end
end

function slot0._onDelayRefresh(slot0)
	slot0._isStartDelayResfresh = false

	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingCanConfirm)
end

function slot0._isOutScreen(slot0, slot1)
	return RoomHelper.isOutCameraFocus(slot1)
end

function slot0._replaceBuilding(slot0)
	slot1 = RoomMapBuildingModel.instance:getTempBuildingMO()

	slot0:_addBuildingNearBlock(slot1.buildingId, slot1.hexPoint, slot1.rotate)

	slot2 = slot0._scene.buildingmgr:getBuildingEntity(slot1.id, SceneTag.RoomBuilding)

	if slot1.buildingState == RoomBuildingEnum.BuildingState.Temp then
		RoomMapBuildingModel.instance:removeTempBuildingMO()

		if slot2 then
			slot0._scene.buildingmgr:destroyBuilding(slot2)
		end
	elseif slot1.buildingState == RoomBuildingEnum.BuildingState.Revert then
		slot3, slot4, slot5 = RoomMapBuildingModel.instance:removeRevertBuildingMO()

		slot0:_addBuildingNearBlock(slot3, slot4, slot5)

		if slot2 then
			slot0._scene.buildingmgr:moveTo(slot2, slot4)
			slot2:refreshRotation()
			slot2:refreshBuilding()
		end

		RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingUIRefreshUI, slot1.id)
	end

	slot0:_placeBuilding()
end

function slot0._changeBuilding(slot0)
	slot3 = slot0._param.focus
	slot4 = slot0._param.press
	slot5 = RoomMapBuildingModel.instance:getTempBuildingMO()
	slot1 = slot0._param.hexPoint or slot5.hexPoint

	slot0:_addBuildingNearBlock(slot5.buildingId, slot5.hexPoint, slot5.rotate)

	slot7 = slot5.rotate

	RoomMapBuildingModel.instance:changeTempBuildingMO(slot1, slot0._param.rotate or slot5.rotate)
	slot0:_addBuildingNearBlock(slot5.buildingId, slot5.hexPoint, slot5.rotate)

	if HexPoint(slot5.hexPoint.x, slot5.hexPoint.y) ~= slot1 or slot4 then
		if slot0._scene.buildingmgr:getBuildingEntity(slot5.id, SceneTag.RoomBuilding) then
			slot0._scene.buildingmgr:moveTo(slot8, slot1)
		end

		if not slot4 then
			slot0:_playAnimatorOpen(slot8)
		end
	end

	if slot7 ~= slot2 and slot0._scene.buildingmgr:getBuildingEntity(slot5.id, SceneTag.RoomBuilding) then
		slot8:refreshRotation(true)
		slot8:refreshBuilding()
	end

	RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingUIRefreshUI, slot5.id)
end

function slot0._placeBuilding(slot0)
	slot3 = slot0._param.rotate
	slot4 = slot0._param.press

	if not RoomMapBuildingModel.instance:revertTempBuildingMO(slot0._param.buildingUid) then
		RoomMapBuildingModel.instance:addTempBuildingMO(RoomInventoryBuildingModel.instance:getBuildingMOById(slot1), slot0._param.hexPoint)
	end

	if RoomMapBuildingModel.instance:getTempBuildingMO() then
		RoomMapBuildingModel.instance:changeTempBuildingMO(slot2, slot3)
		slot0:_addBuildingNearBlock(slot6.buildingId, slot6.hexPoint, slot6.rotate)

		if slot0._scene.buildingmgr:getBuildingEntity(slot6.id, SceneTag.RoomBuilding) then
			slot0._scene.buildingmgr:moveTo(slot7, slot2)
			slot7:refreshRotation()
			slot7:refreshBuilding()

			if slot5 then
				slot0:_playAnimatorOpen(slot7)
			end
		else
			slot0:_playAnimatorOpen(slot0._scene.buildingmgr:spawnMapBuilding(slot6))
		end

		RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingUIRefreshUI, slot6.id)
	end

	slot0:onDone()
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshResourceUIShow)
end

function slot0._addBuildingNearBlock(slot0, slot1, slot2, slot3)
	if not slot2 then
		return
	end

	RoomBuildingController.instance:addWaitRefreshBuildingNearBlock(slot1, slot2, slot3)
end

function slot0._playAnimatorOpen(slot0, slot1)
	if slot1 then
		slot1:playAnimator("open")
		slot1:tweenAlphaThreshold(1, slot1:getAlphaThresholdValue() or 0, 0.5)
	end
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

return slot0
