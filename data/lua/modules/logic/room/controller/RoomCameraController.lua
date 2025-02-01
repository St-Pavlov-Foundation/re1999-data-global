module("modules.logic.room.controller.RoomCameraController", package.seeall)

slot0 = class("RoomCameraController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.resetCameraStateByKey(slot0, slot1)
	if slot0:isHasCameraStateByKey(slot1) then
		slot2 = slot0._viewNameCameraStateDict[slot1]
		slot0._viewNameCameraStateDict[slot1] = nil

		if slot0:getRoomCamera() then
			slot3:switchCameraState(slot2.cameraState, {
				zoom = slot2.zoom
			})
		end
	end
end

function slot0.saveCameraStateByKey(slot0, slot1, slot2)
	slot0._viewNameCameraStateDict = slot0._viewNameCameraStateDict or {}

	if slot0:getRoomCamera() then
		slot0._viewNameCameraStateDict[slot1] = {
			cameraState = slot2 or slot3:getCameraState(),
			zoom = slot3:getCameraZoom()
		}
	end
end

function slot0.isHasCameraStateByKey(slot0, slot1)
	if slot0._viewNameCameraStateDict and slot0._viewNameCameraStateDict[slot1] then
		return true
	end

	return false
end

function slot0.getRoomScene(slot0)
	if GameSceneMgr.instance:getCurScene() and GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		return slot1
	end

	return nil
end

function slot0.getRoomCamera(slot0)
	if slot0:getRoomScene() then
		return slot1.camera
	end

	return nil
end

function slot0.tweenCameraFocusBuildingUseCameraId(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0:getRoomScene()
	slot7 = RoomConfig.instance:getCharacterBuildingInteractCameraConfig(slot2) and string.splitToNumber(slot6.focusXYZ, "#")
	slot12 = slot5.buildingmgr:getBuildingEntity(slot1, SceneTag.RoomBuilding)
	slot13 = slot12:transformPoint(slot7 and slot7[1] or 0, slot7 and slot7[2] or 0, slot7 and slot7[3] or 0)
	slot15 = RoomEnum.CameraState.Manufacture

	slot5.cameraFollow:setFollowTarget(nil)
	slot5.camera:setChangeCameraParamsById(slot15, slot2)
	slot5.camera:switchCameraState(slot15, {
		focusX = slot13.x,
		focusY = slot13.z,
		zoom = slot5.camera:getZoomInitValue(slot15),
		rotate = RoomRotateHelper.getMod(tonumber(slot6 and slot6.rotate or 0) + slot12:getMO().rotate * 60, 360) * Mathf.Deg2Rad
	}, nil, slot3, slot4)
end

slot0.instance = slot0.New()

return slot0
