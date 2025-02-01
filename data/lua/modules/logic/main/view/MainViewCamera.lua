module("modules.logic.main.view.MainViewCamera", package.seeall)

slot0 = class("MainViewCamera", BaseView)
slot1 = "bgm_open"
slot2 = "bgm_close"

function slot0.addEvents(slot0)
	slot0:addEventCb(MainController.instance, MainEvent.FocusBGMDevice, slot0._cameraFocusBGMDevice, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.FocusBGMDeviceReset, slot0._resetcameraFocusBGMDevice, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(MainController.instance, MainEvent.FocusBGMDevice, slot0._cameraFocusBGMDevice, slot0)
	slot0:removeEventCb(MainController.instance, MainEvent.FocusBGMDeviceReset, slot0._resetcameraFocusBGMDevice, slot0)
end

function slot0.onOpen(slot0)
	slot0:_initCamera()
end

function slot0.onClose(slot0)
end

function slot0._initCamera(slot0)
	if slot0._cameraPlayer then
		return
	end

	slot0._cameraRootTrans = CameraMgr.instance:getCameraRootGO().transform
	slot0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	slot0._cameraPlayer = CameraMgr.instance:getCameraRootAnimatorPlayer()
end

function slot0._setCameraBGMDeviceAnimator(slot0, slot1)
	slot0._cameraAnimator.runtimeAnimatorController = slot0.viewContainer._abLoader:getAssetItem(slot0.viewContainer:getSetting().otherRes[slot1 or 2]):GetResource()
end

function slot0._playCameraAnimation(slot0, slot1)
	slot0:_startForceUpdateCameraPos()
	slot0._cameraPlayer:Play(slot1, slot0._onCameraAnimDone, slot0)
end

function slot0._cameraFocusBGMDevice(slot0)
	slot0:_setCameraBGMDeviceAnimator(2)
	slot0:_playCameraAnimation(uv0)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "#go_spine_scale/lightspine/#go_lightspine"), false)
end

function slot0._resetcameraFocusBGMDevice(slot0)
	slot0:_setCameraBGMDeviceAnimator(2)
	slot0:_playCameraAnimation(uv0)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "#go_spine_scale/lightspine/#go_lightspine"), true)
end

function slot0._onCameraAnimDone(slot0)
	slot0:_removeForceUpdateCameraPos()

	CameraMgr.instance:getCameraTrace().EnableTrace = true
	CameraMgr.instance:getCameraTrace().EnableTrace = false
end

function slot0._startForceUpdateCameraPos(slot0)
	slot0:_removeForceUpdateCameraPos()
	LateUpdateBeat:Add(slot0._forceUpdateCameraPos, slot0)
end

function slot0._removeForceUpdateCameraPos(slot0)
	LateUpdateBeat:Remove(slot0._forceUpdateCameraPos, slot0)
end

function slot0._forceUpdateCameraPos(slot0)
	slot1 = CameraMgr.instance:getCameraTrace()
	slot1.EnableTrace = true
	slot1.EnableTrace = false
	slot1.enabled = false
end

return slot0
