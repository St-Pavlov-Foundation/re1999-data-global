module("modules.logic.scene.main.comp.MainSceneCameraComp", package.seeall)

slot0 = class("MainSceneCameraComp", CommonSceneCameraComp)

function slot0._calcFovInternal(slot0, slot1)
	slot2 = 1.7777777777777777 * UnityEngine.Screen.height / UnityEngine.Screen.width

	if BootNativeUtil.isWindows() then
		slot3, slot4 = SettingsModel.instance:getCurrentScreenSize()
		slot2 = 16 * slot4 / 9 / slot3
	end

	if slot2 > 1 then
		slot3 = slot1.fov * slot2 * 0.85
	end

	slot4, slot5 = slot0:_getMinMaxFov()

	return Mathf.Clamp(slot3, slot4, slot5)
end

function slot0._getMinMaxFov(slot0)
	return 35, 100
end

function slot0.onSceneClose(slot0)
	uv0.super.onSceneClose(slot0)

	CameraMgr.instance:getCameraRootAnimator().runtimeAnimatorController = nil

	transformhelper.setPos(CameraMgr.instance:getCameraRootGO().transform, 0, 0, 0)
	transformhelper.setPos(CameraMgr.instance:getCameraTraceGO().transform, 0, 0, 0)

	CameraMgr.instance:getCameraTrace().enabled = true
end

return slot0
