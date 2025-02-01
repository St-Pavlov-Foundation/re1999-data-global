module("modules.logic.scene.room.fsm.RoomTransitionCancelPlaceBuilding", package.seeall)

slot0 = class("RoomTransitionCancelPlaceBuilding", SimpleFSMBaseTransition)

function slot0.start(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.check(slot0)
	return true
end

function slot0.onStart(slot0, slot1)
	slot0._param = slot1

	if RoomMapBuildingModel.instance:getTempBuildingMO() then
		RoomBuildingController.instance:addWaitRefreshBuildingNearBlock(slot2.buildingId, slot2.hexPoint, slot2.rotate)

		slot3 = slot0._scene.buildingmgr:getBuildingEntity(slot2.id, SceneTag.RoomBuilding)

		RoomResourceModel.instance:clearLightResourcePoint()

		if slot2.buildingState == RoomBuildingEnum.BuildingState.Temp then
			RoomMapBuildingModel.instance:removeTempBuildingMO()

			if slot3 then
				slot7 = 0.16666666666666666

				slot4:playAnimator("close")
				slot4:tweenAlphaThreshold(slot3:getAlphaThresholdValue() or 0, 1, slot7)
				slot0._scene.buildingmgr:removeUnitData(SceneTag.RoomBuilding, slot2.id)
				slot4:removeEvent()
				TaskDispatcher.runDelay(function ()
					uv0:destroyUnit(uv1)
				end, slot0, slot7 + 0.01)
			end
		elseif slot2.buildingState == RoomBuildingEnum.BuildingState.Revert then
			slot4, slot5, slot6 = RoomMapBuildingModel.instance:removeRevertBuildingMO()

			if slot3 then
				slot0._scene.buildingmgr:moveTo(slot3, slot5)
				slot3:refreshRotation()
				slot3:refreshBuilding()
			end

			RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingUIRefreshUI, slot2.id)
			RoomBuildingController.instance:addWaitRefreshBuildingNearBlock(slot4, slot5, slot6)
		end

		RoomBuildingController.instance:cancelPressBuilding()
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshResourceUIShow)
	RoomShowBuildingListModel.instance:clearSelect()
	slot0:onDone()
	RoomBuildingController.instance:dispatchEvent(RoomEvent.ClientCancelBuilding)
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingCanConfirm)
	RoomBuildingController.instance:refreshBuildingOccupy()
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

return slot0
