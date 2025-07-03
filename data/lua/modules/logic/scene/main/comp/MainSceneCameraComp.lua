module("modules.logic.scene.main.comp.MainSceneCameraComp", package.seeall)

local var_0_0 = class("MainSceneCameraComp", CommonSceneCameraComp)

function var_0_0._calcFovInternal(arg_1_0, arg_1_1)
	local var_1_0 = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		local var_1_1, var_1_2 = SettingsModel.instance:getCurrentScreenSize()

		var_1_0 = 16 * var_1_2 / 9 / var_1_1
	end

	local var_1_3 = arg_1_1.fov * var_1_0

	if var_1_0 > 1 then
		var_1_3 = var_1_3 * 0.85
	end

	local var_1_4, var_1_5 = arg_1_0:_getMinMaxFov()

	return (Mathf.Clamp(var_1_3, var_1_4, var_1_5))
end

function var_0_0._getMinMaxFov(arg_2_0)
	return 35, 100
end

function var_0_0.onSceneClose(arg_3_0)
	var_0_0.super.onSceneClose(arg_3_0)

	CameraMgr.instance:getCameraRootAnimator().runtimeAnimatorController = nil

	local var_3_0 = CameraMgr.instance:getCameraRootGO()

	transformhelper.setPos(var_3_0.transform, 0, 0, 0)

	local var_3_1 = CameraMgr.instance:getCameraTraceGO()

	transformhelper.setPos(var_3_1.transform, 0, 0, 0)

	CameraMgr.instance:getCameraTrace().enabled = true
end

return var_0_0
