module("modules.logic.scene.summon.comp.SummonSceneCameraComp", package.seeall)

local var_0_0 = class("SummonSceneCameraComp", CommonSceneCameraComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:recordCameraArguments()
end

function var_0_0.onScenePrepared(arg_2_0, arg_2_1, arg_2_2)
	return
end

function var_0_0.switchToChar(arg_3_0)
	arg_3_0._cameraTrace.enabled = true

	arg_3_0:resetParam()
	arg_3_0:applyDirectly()

	local var_3_0 = CameraMgr.instance:getMainCameraTrs()

	transformhelper.setLocalPos(var_3_0, 0, 0, 0)
end

function var_0_0.switchToEquip(arg_4_0)
	arg_4_0._cameraTrace.enabled = false

	arg_4_0:setEquipSceneArguments()
end

function var_0_0.recordCameraArguments(arg_5_0)
	local var_5_0 = CameraMgr.instance:getMainCamera()
	local var_5_1 = CameraMgr.instance:getMainCameraTrs()

	arg_5_0._originPosX, arg_5_0._originPosY, arg_5_0._originPosZ = transformhelper.getLocalPos(var_5_1)
	arg_5_0._originFOV = arg_5_0._cameraCO.fov

	local var_5_2 = CameraMgr.instance:getCameraTraceGO().transform

	arg_5_0._originTracePosX, arg_5_0._originTracePosY, arg_5_0._originTracePosZ = transformhelper.getLocalPos(var_5_2)
	arg_5_0._originTraceRotation = var_5_2.localEulerAngles
	arg_5_0._isRecord = true
end

function var_0_0.resetCameraArguments(arg_6_0)
	if not arg_6_0._isRecord then
		return
	end

	local var_6_0 = CameraMgr.instance:getMainCamera()
	local var_6_1 = CameraMgr.instance:getMainCameraTrs()
	local var_6_2 = CameraMgr.instance:getCameraTraceGO().transform

	var_6_0.fieldOfView = arg_6_0:calcFOV(arg_6_0._originFOV)

	transformhelper.setLocalPos(var_6_1, arg_6_0._originPosX, arg_6_0._originPosY, arg_6_0._originPosZ)
	transformhelper.setLocalPos(var_6_2, arg_6_0._originTracePosX, arg_6_0._originTracePosY, arg_6_0._originTracePosZ)

	var_6_2.localEulerAngles = arg_6_0._originTraceRotation

	local var_6_3 = CameraMgr.instance:getCameraRootGO()

	transformhelper.setLocalPos(var_6_3.transform, 0, 0, 0)
end

function var_0_0.setEquipSceneArguments(arg_7_0)
	if not arg_7_0._isRecord then
		return
	end

	local var_7_0 = CameraMgr.instance:getMainCamera()
	local var_7_1 = CameraMgr.instance:getMainCameraTrs()
	local var_7_2 = CameraMgr.instance:getCameraTraceGO().transform

	var_7_0.fieldOfView = arg_7_0:calcFOV(60)

	transformhelper.setLocalPos(var_7_1, 0, 2.13, -12.06)
	transformhelper.setLocalPos(var_7_2, 0, 0, 0)

	var_7_2.localEulerAngles = Vector3.zero
end

function var_0_0.calcFOV(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 * (1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width))
	local var_8_1, var_8_2 = arg_8_0:_getMinMaxFov()

	return (Mathf.Clamp(var_8_0, var_8_1, var_8_2))
end

function var_0_0._onScreenResize(arg_9_0, arg_9_1, arg_9_2)
	return
end

function var_0_0.onSceneClose(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._cameraTrace.EnableTrace = false

	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_10_0._onScreenResize, arg_10_0)
	arg_10_0:resetCameraArguments()

	arg_10_0._isRecord = false
	arg_10_0._cameraTrace.enabled = true
end

function var_0_0.onSceneHide(arg_11_0)
	arg_11_0:onSceneClose()
end

return var_0_0
