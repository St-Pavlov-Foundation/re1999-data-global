module("modules.logic.scene.room.fsm.RoomTransitionUnUseBuilding", package.seeall)

slot0 = class("RoomTransitionUnUseBuilding", SimpleFSMBaseTransition)

function slot0.start(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.check(slot0)
	return true
end

function slot0.onStart(slot0, slot1)
	slot0._param = slot1
	slot3 = RoomMapBuildingModel.instance:getTempBuildingMO()
	slot4 = {}
	slot5 = {}
	slot6 = nil

	for slot10 = 1, #slot0._param.buildingInfos do
		if slot0._scene.buildingmgr:getBuildingEntity(slot2[slot10].uid, SceneTag.RoomBuilding) then
			slot11:refreshRotation()
			slot11:refreshBuilding()
			slot0._scene.buildingmgr:destroyBuilding(slot11)

			if slot11:getMO() then
				RoomBuildingController.instance:addWaitRefreshBuildingNearBlock(slot12.buildingId, slot12.hexPoint, slot12.rotate)
				RoomCharacterController.instance:interruptInteraction(slot12:getCurrentInteractionId())
			end

			RoomMapBuildingModel.instance:removeBuildingMO(slot12)

			if slot3 and slot3.id == slot11.id then
				RoomMapBuildingModel.instance:removeTempBuildingMO()
			end
		end
	end

	slot0:onDone()
	RoomMapBuildingModel.instance:refreshAllOccupyDict()
	RoomBuildingController.instance:cancelPressBuilding()
	RoomResourceModel.instance:clearLightResourcePoint()
	RoomShowBuildingListModel.instance:clearSelect()
	RoomBuildingController.instance:dispatchEvent(RoomEvent.UnUseBuilding)
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshResourceUIShow)
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingCanConfirm)
	RoomBuildingController.instance:refreshBuildingOccupy()
end

function slot0._addBlockEntityList(slot0, slot1, slot2)
	slot1 = slot1 or {}
	slot3 = nil

	for slot7 = 1, #slot2 do
		if not tabletool.indexOf(slot1, slot2[slot7]) then
			table.insert(slot1, slot3)
		end
	end

	return slot1
end

function slot0.stop(slot0)
end

function slot0.clear(slot0)
end

return slot0
