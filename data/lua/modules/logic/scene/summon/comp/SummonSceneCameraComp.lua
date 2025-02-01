module("modules.logic.scene.summon.comp.SummonSceneCameraComp", package.seeall)

slot0 = class("SummonSceneCameraComp", CommonSceneCameraComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	uv0.super.onSceneStart(slot0, slot1, slot2)
	slot0:recordCameraArguments()
end

function slot0.onScenePrepared(slot0, slot1, slot2)
end

function slot0.switchToChar(slot0)
	slot0._cameraTrace.enabled = true

	slot0:resetParam()
	slot0:applyDirectly()
	transformhelper.setLocalPos(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)
end

function slot0.switchToEquip(slot0)
	slot0._cameraTrace.enabled = false

	slot0:setEquipSceneArguments()
end

function slot0.recordCameraArguments(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot0._originPosX, slot0._originPosY, slot0._originPosZ = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs())
	slot0._originFOV = slot0._cameraCO.fov
	slot4 = CameraMgr.instance:getCameraTraceGO().transform
	slot0._originTracePosX, slot0._originTracePosY, slot0._originTracePosZ = transformhelper.getLocalPos(slot4)
	slot0._originTraceRotation = slot4.localEulerAngles
	slot0._isRecord = true
end

function slot0.resetCameraArguments(slot0)
	if not slot0._isRecord then
		return
	end

	slot4 = CameraMgr.instance:getCameraTraceGO().transform
	CameraMgr.instance:getMainCamera().fieldOfView = slot0:calcFOV(slot0._originFOV)

	transformhelper.setLocalPos(CameraMgr.instance:getMainCameraTrs(), slot0._originPosX, slot0._originPosY, slot0._originPosZ)
	transformhelper.setLocalPos(slot4, slot0._originTracePosX, slot0._originTracePosY, slot0._originTracePosZ)

	slot4.localEulerAngles = slot0._originTraceRotation

	transformhelper.setLocalPos(CameraMgr.instance:getCameraRootGO().transform, 0, 0, 0)
end

function slot0.setEquipSceneArguments(slot0)
	if not slot0._isRecord then
		return
	end

	slot4 = CameraMgr.instance:getCameraTraceGO().transform
	CameraMgr.instance:getMainCamera().fieldOfView = slot0:calcFOV(60)

	transformhelper.setLocalPos(CameraMgr.instance:getMainCameraTrs(), 0, 2.13, -12.06)
	transformhelper.setLocalPos(slot4, 0, 0, 0)

	slot4.localEulerAngles = Vector3.zero
end

function slot0.calcFOV(slot0, slot1)
	slot4, slot5 = slot0:_getMinMaxFov()

	return Mathf.Clamp(slot1 * 1.7777777777777777 * UnityEngine.Screen.height / UnityEngine.Screen.width, slot4, slot5)
end

function slot0._onScreenResize(slot0, slot1, slot2)
end

function slot0.onSceneClose(slot0, slot1, slot2)
	slot0._cameraTrace.EnableTrace = false

	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:resetCameraArguments()

	slot0._isRecord = false
	slot0._cameraTrace.enabled = true
end

function slot0.onSceneHide(slot0)
	slot0:onSceneClose()
end

return slot0
