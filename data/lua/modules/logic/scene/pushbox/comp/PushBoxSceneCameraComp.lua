module("modules.logic.scene.pushbox.comp.PushBoxSceneCameraComp", package.seeall)

local var_0_0 = class("PushBoxSceneCameraComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._scene = arg_1_0:getCurScene()
	arg_1_0._cameraTrace = CameraMgr.instance:getCameraTrace()
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = CameraMgr.instance:getFocusTrs()

	transformhelper.setPos(var_2_0, 0, 0, 0)

	arg_2_0._cameraTrace.EnableTrace = false

	gohelper.setActive(CameraMgr.instance:getVirtualCameraGO(), false)
	transformhelper.setLocalPos(CameraMgr.instance:getMainCameraTrs(), 0, -5.8, -200)
	transformhelper.setLocalRotation(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)

	CameraMgr.instance:getMainCamera().farClipPlane = 1000
end

function var_0_0.onSceneClose(arg_3_0)
	CameraMgr.instance:getMainCamera().farClipPlane = 500
end

return var_0_0
