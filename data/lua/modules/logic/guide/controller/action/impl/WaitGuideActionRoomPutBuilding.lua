module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomPutBuilding", package.seeall)

slot0 = class("WaitGuideActionRoomPutBuilding", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	slot0._sceneType = SceneType.Room

	uv0.super.onStart(slot0, slot1)
	RoomMapController.instance:registerCallback(RoomEvent.UseBuildingReply, slot0._onUseBuildingReply, slot0)
	GameSceneMgr.instance:registerCallback(slot0._sceneType, slot0._onEnterScene, slot0)

	slot2 = string.splitToNumber(slot0.actionParam, "#")
	slot0._buildingId = slot2[1]
	slot0._notAutoPutBuilding = slot2[2] == 1
	slot0._toastId = slot2[3]

	slot0:_check()
end

function slot0._check(slot0)
	if slot0._waitUseBuildingReply or slot0._waitManufactureBuildingInfoChange then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		return
	end

	slot2 = nil

	if RoomModel.instance:getBuildingInfoList() then
		for slot6, slot7 in pairs(slot1) do
			if slot7.buildingId == slot0._buildingId then
				slot2 = slot7

				break
			end
		end
	end

	if slot2 and slot2.use then
		slot0:onDone(true)
	elseif slot2 then
		if not slot0._notAutoPutBuilding then
			slot0:putBuilding(slot2)
		elseif slot0._toastId then
			GameFacade.showToast(slot0._toastId)
		end
	else
		slot0:onDone(true)
	end
end

function slot0._onUseBuildingReply(slot0)
	slot0._waitUseBuildingReply = false

	slot0:_check()
end

function slot0._onManufactureBuildingInfoChange(slot0)
	slot0._waitManufactureBuildingInfoChange = false

	slot0:_check()
end

function slot0._onEnterScene(slot0, slot1, slot2)
	if slot2 == 1 then
		slot0:_check()
	end
end

function slot0.clearWork(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.UseBuildingReply, slot0._onUseBuildingReply, slot0)
	GameSceneMgr.instance:unregisterCallback(slot0._sceneType, slot0._onEnterScene, slot0)
	ManufactureController.instance:unregisterCallback(ManufactureEvent.ManufactureBuildingInfoChange, slot0._onManufactureBuildingInfoChange, slot0)
end

function slot0.putBuilding(slot0, slot1)
	slot2 = slot1.uid
	slot5 = RoomBuildingHelper.getRecommendHexPoint(slot0._buildingId, nil, , , slot0:getNearRotate(slot0._buildingId)) and slot4.rotate or slot3

	if slot4 and slot4.hexPoint then
		RoomCameraController.instance:getRoomScene().fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, {
			buildingUid = slot2,
			hexPoint = slot6,
			rotate = slot5
		})

		slot0._waitUseBuildingReply = true

		if slot0._buildingId == 22001 then
			slot0._waitManufactureBuildingInfoChange = true

			ManufactureController.instance:registerCallback(ManufactureEvent.ManufactureBuildingInfoChange, slot0._onManufactureBuildingInfoChange, slot0)
		end

		RoomMapController.instance:useBuildingRequest(slot2, slot5, slot6.x, slot6.y)
	else
		slot0:onDone(true)
	end
end

function slot0.getNearRotate(slot0, slot1)
	return RoomRotateHelper.getCameraNearRotate(RoomCameraController.instance:getRoomScene().camera:getCameraRotate() * Mathf.Rad2Deg) + RoomConfig.instance:getBuildingConfig(slot1).rotate
end

return slot0
