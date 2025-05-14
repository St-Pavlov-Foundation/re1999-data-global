module("modules.logic.room.controller.RoomCameraController", package.seeall)

local var_0_0 = class("RoomCameraController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.resetCameraStateByKey(arg_4_0, arg_4_1)
	if arg_4_0:isHasCameraStateByKey(arg_4_1) then
		local var_4_0 = arg_4_0._viewNameCameraStateDict[arg_4_1]

		arg_4_0._viewNameCameraStateDict[arg_4_1] = nil

		local var_4_1 = arg_4_0:getRoomScene()

		if var_4_1 then
			var_4_1.cameraFollow:setFollowTarget(nil)
			var_4_1.camera:switchCameraState(var_4_0.cameraState, {
				zoom = var_4_0.zoom
			})
			var_4_1.fovblock:clearLookParam()
		end
	end
end

function var_0_0.saveCameraStateByKey(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._viewNameCameraStateDict = arg_5_0._viewNameCameraStateDict or {}

	local var_5_0 = arg_5_0:getRoomCamera()

	if var_5_0 then
		local var_5_1 = arg_5_2 or var_5_0:getCameraState()

		arg_5_0._viewNameCameraStateDict[arg_5_1] = {
			cameraState = var_5_1,
			zoom = var_5_0:getCameraZoom()
		}
	end
end

function var_0_0.isHasCameraStateByKey(arg_6_0, arg_6_1)
	if arg_6_0._viewNameCameraStateDict and arg_6_0._viewNameCameraStateDict[arg_6_1] then
		return true
	end

	return false
end

function var_0_0.getRoomScene(arg_7_0)
	local var_7_0 = GameSceneMgr.instance:getCurScene()

	if var_7_0 and GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		return var_7_0
	end

	return nil
end

function var_0_0.getRoomCamera(arg_8_0)
	local var_8_0 = arg_8_0:getRoomScene()

	if var_8_0 then
		return var_8_0.camera
	end

	return nil
end

function var_0_0.tweenCameraFocusBuildingUseCameraId(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0:tweenCameraByBuildingUid(arg_9_1, RoomEnum.CameraState.Manufacture, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0:getRoomScene().fovblock:setLookBuildingUid(RoomEnum.CameraState.Manufacture, arg_9_1)
end

function var_0_0.tweenCameraByBuildingUid(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	local var_10_0 = arg_10_0:getRoomScene()
	local var_10_1 = RoomConfig.instance:getCharacterBuildingInteractCameraConfig(arg_10_3)
	local var_10_2 = var_10_1 and string.splitToNumber(var_10_1.focusXYZ, "#")
	local var_10_3 = var_10_2 and var_10_2[1] or 0
	local var_10_4 = var_10_2 and var_10_2[2] or 0
	local var_10_5 = var_10_2 and var_10_2[3] or 0
	local var_10_6 = var_10_1 and var_10_1.rotate or 0
	local var_10_7 = var_10_0.buildingmgr:getBuildingEntity(arg_10_1, SceneTag.RoomBuilding)
	local var_10_8 = var_10_7:transformPoint(var_10_3, var_10_4, var_10_5)
	local var_10_9 = tonumber(var_10_6) + var_10_7:getMO().rotate * 60
	local var_10_10 = RoomRotateHelper.getMod(var_10_9, 360) * Mathf.Deg2Rad
	local var_10_11 = arg_10_2
	local var_10_12 = {
		focusX = var_10_8.x,
		focusY = var_10_8.z,
		zoom = var_10_0.camera:getZoomInitValue(var_10_11),
		rotate = var_10_10
	}

	var_10_0.cameraFollow:setFollowTarget(nil)
	var_10_0.camera:setChangeCameraParamsById(var_10_11, arg_10_3)
	var_10_0.camera:switchCameraState(var_10_11, var_10_12, nil, arg_10_4, arg_10_5)
end

var_0_0.instance = var_0_0.New()

return var_0_0
