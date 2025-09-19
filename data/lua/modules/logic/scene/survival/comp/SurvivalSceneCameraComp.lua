module("modules.logic.scene.survival.comp.SurvivalSceneCameraComp", package.seeall)

local var_0_0 = class("SurvivalSceneCameraComp", CommonSceneCameraComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._scene = arg_1_0:getCurScene()
	arg_1_0._rawcameraTrace = CameraMgr.instance:getCameraTrace()
	arg_1_0._cameraTrace = arg_1_0._rawcameraTrace
	arg_1_0._cameraCO = nil
end

function var_0_0._onScreenResize(arg_2_0)
	local var_2_0 = CameraMgr.instance:getFocusTrs()
	local var_2_1, var_2_2, var_2_3 = transformhelper.getPos(var_2_0)

	arg_2_0._cameraTrace:SetTargetFocusPos(var_2_1, var_2_2, var_2_3)

	if arg_2_0._nowFov then
		arg_2_0:setFov(arg_2_0._nowFov)
		arg_2_0._cameraTrace:ApplyDirectly()
	end
end

function var_0_0.onSceneStart(arg_3_0, ...)
	arg_3_0._rawcameraTrace.enabled = false
	arg_3_0._cameraTrace = gohelper.onceAddComponent(arg_3_0._rawcameraTrace, typeof(ZProj.ExploreCameraTrace))

	arg_3_0._cameraTrace:SetEaseTime(ExploreConstValue.CameraTraceTime)
	var_0_0.super.onSceneStart(arg_3_0, ...)
end

function var_0_0.onScenePrepared(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._cameraTrace.EnableTrace = true
end

function var_0_0.setFocus(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = CameraMgr.instance:getFocusTrs()

	transformhelper.setPos(var_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._cameraTrace:SetTargetFocusPos(arg_5_1, arg_5_2, arg_5_3)
end

function var_0_0.setFov(arg_6_0, arg_6_1)
	local var_6_0 = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)
	local var_6_1 = math.max(var_6_0, 1)

	arg_6_0._nowFov = arg_6_1

	arg_6_0._cameraTrace:SetTargetFov(arg_6_1 * var_6_1)
end

function var_0_0.onSceneClose(arg_7_0, ...)
	arg_7_0._rawcameraTrace.enabled = true

	gohelper.destroy(arg_7_0._cameraTrace)

	arg_7_0._cameraTrace = arg_7_0._rawcameraTrace

	var_0_0.super.onSceneClose(arg_7_0, ...)
end

return var_0_0
