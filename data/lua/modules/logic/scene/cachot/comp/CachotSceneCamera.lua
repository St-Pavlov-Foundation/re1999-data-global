module("modules.logic.scene.cachot.comp.CachotSceneCamera", package.seeall)

local var_0_0 = class("CachotSceneCamera", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._scene = arg_1_0:getCurScene()
	arg_1_0._levelComp = arg_1_0._scene.level

	local var_1_0 = CameraMgr.instance:getCameraTrace()

	arg_1_0._traceEnabled = var_1_0.enabled
	var_1_0.enabled = false

	local var_1_1 = CameraMgr.instance:getMainCamera()
	local var_1_2 = CameraMgr.instance:getMainCameraTrs()

	arg_1_0._rawCameraIsOrthographic = var_1_1.orthographic
	arg_1_0._rawCameraIsOrthographicSize = var_1_1.orthographicSize

	gohelper.setActive(CameraMgr.instance:getVirtualCameraGO(), false)
	transformhelper.setLocalPos(var_1_2, 0, 0, 0)
	transformhelper.setLocalRotation(var_1_2, 0, 0, 0)

	var_1_1.orthographic = true
	var_1_1.orthographicSize = 5 * GameUtil.getAdapterScale(true)

	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_1_0.onScreenResize, arg_1_0)
end

function var_0_0.onScreenResize(arg_2_0)
	local var_2_0 = CameraMgr.instance:getMainCamera()

	var_2_0.orthographic = true
	var_2_0.orthographicSize = 5 * GameUtil.getAdapterScale(true)
end

function var_0_0.onSceneClose(arg_3_0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_3_0.onScreenResize, arg_3_0)

	local var_3_0 = CameraMgr.instance:getMainCamera()

	var_3_0.orthographicSize = arg_3_0._rawCameraIsOrthographicSize
	var_3_0.orthographic = arg_3_0._rawCameraIsOrthographic
	CameraMgr.instance:getCameraTrace().enabled = arg_3_0._traceEnabled
end

return var_0_0
