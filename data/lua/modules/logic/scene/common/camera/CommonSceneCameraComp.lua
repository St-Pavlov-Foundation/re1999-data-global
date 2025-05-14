module("modules.logic.scene.common.camera.CommonSceneCameraComp", package.seeall)

local var_0_0 = class("CommonSceneCameraComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._scene = arg_1_0:getCurScene()
	arg_1_0._cameraTrace = CameraMgr.instance:getCameraTrace()
	arg_1_0._cameraCO = nil
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._cameraTrace.EnableTrace = true

	arg_2_0:_initCurSceneCameraTrace(arg_2_2)

	arg_2_0._cameraTrace.EnableTrace = false

	arg_2_0:_hideVirtualCamera()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_2_0._onScreenResize, arg_2_0)
	arg_2_0:_onScreenResize(UnityEngine.Screen.width, UnityEngine.Screen.height)
end

function var_0_0.onScenePrepared(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._scene.level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, arg_3_0._onLevelLoaded, arg_3_0)
end

function var_0_0.onSceneClose(arg_4_0)
	arg_4_0._cameraTrace.EnableTrace = false

	arg_4_0._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, arg_4_0._onLevelLoaded, arg_4_0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_4_0._onScreenResize, arg_4_0)
end

function var_0_0._onLevelLoaded(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._cameraTrace.EnableTrace

	arg_5_0._cameraTrace.EnableTrace = true

	arg_5_0:_initCurSceneCameraTrace(arg_5_1)

	if not var_5_0 then
		arg_5_0._cameraTrace.EnableTrace = false
	end
end

function var_0_0.setCameraTraceEnable(arg_6_0, arg_6_1)
	arg_6_0._cameraTrace.EnableTrace = arg_6_1
end

function var_0_0._initCurSceneCameraTrace(arg_7_0, arg_7_1)
	local var_7_0 = lua_scene_level.configDict[arg_7_1]

	arg_7_0._cameraCO = lua_camera.configDict[var_7_0.cameraId]

	arg_7_0:resetParam()
	arg_7_0:applyDirectly()
end

function var_0_0._hideVirtualCamera(arg_8_0)
	gohelper.setActive(CameraMgr.instance:getVirtualCameraGO(), false)
	transformhelper.setLocalPos(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)
	transformhelper.setLocalRotation(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)
end

function var_0_0.resetParam(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 or arg_9_0._cameraCO

	local var_9_0 = arg_9_1.yaw
	local var_9_1 = arg_9_1.pitch
	local var_9_2 = arg_9_1.distance
	local var_9_3 = arg_9_0:_calcFovInternal(arg_9_1)

	arg_9_0.yaw = var_9_0

	arg_9_0._cameraTrace:SetTargetParam(var_9_0, var_9_1, var_9_2, var_9_3, 0, 0, 0)

	local var_9_4 = 0
	local var_9_5 = arg_9_1.yOffset
	local var_9_6 = arg_9_1.focusZ

	arg_9_0:setFocus(var_9_4, var_9_5, var_9_6)
end

function var_0_0._calcFovInternal(arg_10_0, arg_10_1)
	local var_10_0 = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)
	local var_10_1 = arg_10_1.fov * var_10_0
	local var_10_2, var_10_3 = arg_10_0:_getMinMaxFov()

	return (Mathf.Clamp(var_10_1, var_10_2, var_10_3))
end

function var_0_0._getMinMaxFov(arg_11_0)
	return 35, 120
end

function var_0_0._onScreenResize(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:resetParam()
	arg_12_0:applyDirectly()
end

function var_0_0.getCurCO(arg_13_0)
	return arg_13_0._cameraCO
end

function var_0_0.applyDirectly(arg_14_0)
	local var_14_0 = CameraMgr.instance:getFocusTrs()

	arg_14_0._cameraTrace:SetTargetFocusPos(transformhelper.getPos(var_14_0))
	arg_14_0._cameraTrace:ApplyDirectly()
end

function var_0_0.setFocus(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = CameraMgr.instance:getFocusTrs()

	transformhelper.setPos(var_15_0, arg_15_1, arg_15_2, arg_15_3)
end

function var_0_0.setFocusX(arg_16_0, arg_16_1)
	local var_16_0 = CameraMgr.instance:getFocusTrs()
	local var_16_1, var_16_2, var_16_3 = transformhelper.getPos(var_16_0)

	transformhelper.setPos(var_16_0, arg_16_1, var_16_2, var_16_3)
end

function var_0_0.resetFocus(arg_17_0)
	arg_17_0:setFocus(0, arg_17_0._cameraCO.yOffset, arg_17_0._cameraCO.focusZ)
end

function var_0_0.setEaseTime(arg_18_0, arg_18_1)
	arg_18_0._cameraTrace:SetEaseTime(arg_18_1)
end

function var_0_0.setEaseType(arg_19_0, arg_19_1)
	arg_19_0._cameraTrace:SetEaseType(arg_19_1)
end

function var_0_0.setFocusTransform(arg_20_0, arg_20_1)
	arg_20_0._cameraTrace:SetFocusTransform(arg_20_1)
end

function var_0_0.clearFocusTransform(arg_21_0)
	arg_21_0._cameraTrace:ClearFocusTransform()
end

function var_0_0.setDistance(arg_22_0, arg_22_1)
	arg_22_0._cameraTrace:SetTargetDistance(arg_22_1)
end

function var_0_0.resetDistance(arg_23_0)
	arg_23_0._cameraTrace:SetTargetDistance(arg_23_0._cameraCO.distance)
end

function var_0_0.shake(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	arg_24_0._cameraTrace:Shake(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
end

function var_0_0.setRotate(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0._cameraTrace:SetTargetRotate(arg_25_1, arg_25_2)
end

function var_0_0.setFov(arg_26_0, arg_26_1)
	arg_26_0._cameraTrace:SetTargetFov(arg_26_1)
end

return var_0_0
