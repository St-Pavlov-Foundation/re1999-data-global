module("modules.logic.main.view.MainViewCamera", package.seeall)

local var_0_0 = class("MainViewCamera", BaseView)
local var_0_1 = "bgm_open"
local var_0_2 = "bgm_close"

function var_0_0.addEvents(arg_1_0)
	arg_1_0:addEventCb(MainController.instance, MainEvent.FocusBGMDevice, arg_1_0._cameraFocusBGMDevice, arg_1_0)
	arg_1_0:addEventCb(MainController.instance, MainEvent.FocusBGMDeviceReset, arg_1_0._resetcameraFocusBGMDevice, arg_1_0)
end

function var_0_0.removeEvents(arg_2_0)
	arg_2_0:removeEventCb(MainController.instance, MainEvent.FocusBGMDevice, arg_2_0._cameraFocusBGMDevice, arg_2_0)
	arg_2_0:removeEventCb(MainController.instance, MainEvent.FocusBGMDeviceReset, arg_2_0._resetcameraFocusBGMDevice, arg_2_0)
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0:_initCamera()
end

function var_0_0.onClose(arg_4_0)
	return
end

function var_0_0._initCamera(arg_5_0)
	if arg_5_0._cameraPlayer then
		return
	end

	arg_5_0._cameraRootTrans = CameraMgr.instance:getCameraRootGO().transform
	arg_5_0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	arg_5_0._cameraPlayer = CameraMgr.instance:getCameraRootAnimatorPlayer()
end

function var_0_0._setCameraBGMDeviceAnimator(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.viewContainer:getSetting().otherRes[arg_6_1 or 2]
	local var_6_1 = arg_6_0.viewContainer._abLoader:getAssetItem(var_6_0):GetResource()

	arg_6_0._cameraAnimator.runtimeAnimatorController = var_6_1
end

function var_0_0._playCameraAnimation(arg_7_0, arg_7_1)
	arg_7_0:_startForceUpdateCameraPos()
	arg_7_0._cameraPlayer:Play(arg_7_1, arg_7_0._onCameraAnimDone, arg_7_0)
end

function var_0_0._cameraFocusBGMDevice(arg_8_0)
	arg_8_0:_setCameraBGMDeviceAnimator(2)
	arg_8_0:_playCameraAnimation(var_0_1)

	local var_8_0 = gohelper.findChild(arg_8_0.viewGO, "#go_spine_scale/lightspine/#go_lightspine")

	gohelper.setActive(var_8_0, false)
end

function var_0_0._resetcameraFocusBGMDevice(arg_9_0)
	arg_9_0:_setCameraBGMDeviceAnimator(2)
	arg_9_0:_playCameraAnimation(var_0_2)

	local var_9_0 = gohelper.findChild(arg_9_0.viewGO, "#go_spine_scale/lightspine/#go_lightspine")

	gohelper.setActive(var_9_0, true)
end

function var_0_0._onCameraAnimDone(arg_10_0)
	arg_10_0:_removeForceUpdateCameraPos()

	CameraMgr.instance:getCameraTrace().EnableTrace = true
	CameraMgr.instance:getCameraTrace().EnableTrace = false
end

function var_0_0._startForceUpdateCameraPos(arg_11_0)
	arg_11_0:_removeForceUpdateCameraPos()
	LateUpdateBeat:Add(arg_11_0._forceUpdateCameraPos, arg_11_0)
end

function var_0_0._removeForceUpdateCameraPos(arg_12_0)
	LateUpdateBeat:Remove(arg_12_0._forceUpdateCameraPos, arg_12_0)
end

function var_0_0._forceUpdateCameraPos(arg_13_0)
	local var_13_0 = CameraMgr.instance:getCameraTrace()

	var_13_0.EnableTrace = true
	var_13_0.EnableTrace = false
	var_13_0.enabled = false
end

return var_0_0
