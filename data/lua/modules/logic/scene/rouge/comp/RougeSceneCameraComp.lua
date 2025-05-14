module("modules.logic.scene.rouge.comp.RougeSceneCameraComp", package.seeall)

local var_0_0 = class("RougeSceneCameraComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	RougeMapController.instance:registerCallback(RougeMapEvent.onLoadMapDone, arg_2_0.onLoadMapDone, arg_2_0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onExitPieceChoiceEvent, arg_2_0.onExitPieceChoiceEvent, arg_2_0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onMiddleActorBeforeMove, arg_2_0.onMiddleActorBeforeMove, arg_2_0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onPathSelectMapFocus, arg_2_0.onPathSelectMapFocus, arg_2_0)
	RougeMapController.instance:registerCallback(RougeMapEvent.focusChangeCameraSize, arg_2_0.focusChangeCameraSize, arg_2_0)
end

function var_0_0.focusChangeCameraSize(arg_3_0)
	if arg_3_0.camera then
		arg_3_0.camera.orthographicSize = RougeMapModel.instance:getCameraSize()
	end
end

function var_0_0.onLoadMapDone(arg_4_0)
	arg_4_0:initCameraSize()
end

function var_0_0.initCameraSize(arg_5_0)
	gohelper.setActive(CameraMgr.instance:getVirtualCameraGO(), false)
	transformhelper.setLocalPos(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)
	transformhelper.setLocalRotation(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)

	local var_5_0 = CameraMgr.instance:getCameraTrace()

	if var_5_0 then
		var_5_0.EnableTrace = false
	end

	arg_5_0.camera = CameraMgr.instance:getMainCamera()
	arg_5_0.camera.orthographic = true
	arg_5_0.camera.orthographicSize = RougeMapModel.instance:getCameraSize()
end

function var_0_0.clearCamera(arg_6_0)
	if arg_6_0.camera then
		arg_6_0.camera.orthographicSize = 5
		arg_6_0.camera.orthographic = false
	end
end

function var_0_0.onSceneClose(arg_7_0)
	arg_7_0:clearCamera()

	arg_7_0.camera = nil

	RougeMapController.instance:unregisterCallback(RougeMapEvent.onLoadMapDone, arg_7_0.onLoadMapDone, arg_7_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onExitPieceChoiceEvent, arg_7_0.onExitPieceChoiceEvent, arg_7_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onMiddleActorBeforeMove, arg_7_0.onMiddleActorBeforeMove, arg_7_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onPathSelectMapFocus, arg_7_0.onPathSelectMapFocus, arg_7_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.focusChangeCameraSize, arg_7_0.focusChangeCameraSize, arg_7_0)
	arg_7_0:clearTween()
end

function var_0_0.clearTween(arg_8_0)
	if arg_8_0.movingTweenId then
		ZProj.TweenHelper.KillById(arg_8_0.movingTweenId)
	end

	arg_8_0.movingTweenId = nil
end

function var_0_0.onMiddleActorBeforeMove(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.MiddleLayerFocus)
	arg_9_0:clearTween()

	arg_9_0.movingTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, RougeMapEnum.RevertDuration, arg_9_0.frameCallback, arg_9_0.onTweenDone, arg_9_0, nil, RougeMapEnum.CameraTweenLine)
end

function var_0_0.onExitPieceChoiceEvent(arg_10_0)
	if not RougeMapModel.instance:isMiddle() then
		return
	end

	arg_10_0:clearTween()

	arg_10_0.movingTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, RougeMapEnum.RevertDuration, arg_10_0.frameCallback, arg_10_0.onTweenDone, arg_10_0, nil, RougeMapEnum.CameraTweenLine)
end

function var_0_0.frameCallback(arg_11_0, arg_11_1)
	local var_11_0 = RougeMapModel.instance:getCameraSize()
	local var_11_1 = RougeMapEnum.MiddleLayerCameraSizeRate * var_11_0
	local var_11_2 = var_11_1 + arg_11_1 * (var_11_0 - var_11_1)

	arg_11_0.camera.orthographicSize = var_11_2

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onCameraSizeChange, var_11_2)
end

function var_0_0.onPathSelectMapFocus(arg_12_0, arg_12_1)
	arg_12_0:clearTween()

	arg_12_0.targetCameraSize = arg_12_1
	arg_12_0.movingTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, RougeMapEnum.RevertDuration, arg_12_0.pathSelectMapFrameCallback, arg_12_0.onTweenDone, arg_12_0, nil, RougeMapEnum.CameraTweenLine)
end

function var_0_0.pathSelectMapFrameCallback(arg_13_0, arg_13_1)
	local var_13_0 = RougeMapModel.instance:getCameraSize()
	local var_13_1 = var_13_0 + arg_13_1 * (arg_13_0.targetCameraSize - var_13_0)

	arg_13_0.camera.orthographicSize = var_13_1

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onCameraSizeChange, var_13_1)
end

function var_0_0.onTweenDone(arg_14_0)
	arg_14_0.movingTweenId = nil
end

return var_0_0
