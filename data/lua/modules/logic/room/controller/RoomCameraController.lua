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

		if slot0:getRoomScene() then
			slot3.cameraFollow:setFollowTarget(nil)
			slot3.camera:switchCameraState(slot2.cameraState, {
				zoom = slot2.zoom
			})
			slot3.fovblock:clearLookParam()
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
	slot0:tweenCameraByBuildingUid(slot1, RoomEnum.CameraState.Manufacture, slot2, slot3, slot4)
	slot0:getRoomScene().fovblock:setLookBuildingUid(RoomEnum.CameraState.Manufacture, slot1)
end

function slot0.tweenCameraByBuildingUid(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = slot0:getRoomScene()
	slot8 = RoomConfig.instance:getCharacterBuildingInteractCameraConfig(slot3) and string.splitToNumber(slot7.focusXYZ, "#")
	slot13 = slot6.buildingmgr:getBuildingEntity(slot1, SceneTag.RoomBuilding)
	slot14 = slot13:transformPoint(slot8 and slot8[1] or 0, slot8 and slot8[2] or 0, slot8 and slot8[3] or 0)
	slot16 = slot2

	slot6.cameraFollow:setFollowTarget(nil)
	slot6.camera:setChangeCameraParamsById(slot16, slot3)
	slot6.camera:switchCameraState(slot16, {
		focusX = slot14.x,
		focusY = slot14.z,
		zoom = slot6.camera:getZoomInitValue(slot16),
		rotate = RoomRotateHelper.getMod(tonumber(slot7 and slot7.rotate or 0) + slot13:getMO().rotate * 60, 360) * Mathf.Deg2Rad
	}, nil, slot4, slot5)
end

slot0.instance = slot0.New()

return slot0
