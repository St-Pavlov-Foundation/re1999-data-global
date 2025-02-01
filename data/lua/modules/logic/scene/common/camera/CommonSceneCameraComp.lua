module("modules.logic.scene.common.camera.CommonSceneCameraComp", package.seeall)

slot0 = class("CommonSceneCameraComp", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._scene = slot0:getCurScene()
	slot0._cameraTrace = CameraMgr.instance:getCameraTrace()
	slot0._cameraCO = nil
end

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._cameraTrace.EnableTrace = true

	slot0:_initCurSceneCameraTrace(slot2)

	slot0._cameraTrace.EnableTrace = false

	slot0:_hideVirtualCamera()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
	slot0:_onScreenResize(UnityEngine.Screen.width, UnityEngine.Screen.height)
end

function slot0.onScenePrepared(slot0, slot1, slot2)
	slot0._scene.level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
end

function slot0.onSceneClose(slot0)
	slot0._cameraTrace.EnableTrace = false

	slot0._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
end

function slot0._onLevelLoaded(slot0, slot1)
	slot0._cameraTrace.EnableTrace = true

	slot0:_initCurSceneCameraTrace(slot1)

	if not slot0._cameraTrace.EnableTrace then
		slot0._cameraTrace.EnableTrace = false
	end
end

function slot0.setCameraTraceEnable(slot0, slot1)
	slot0._cameraTrace.EnableTrace = slot1
end

function slot0._initCurSceneCameraTrace(slot0, slot1)
	slot0._cameraCO = lua_camera.configDict[lua_scene_level.configDict[slot1].cameraId]

	slot0:resetParam()
	slot0:applyDirectly()
end

function slot0._hideVirtualCamera(slot0)
	gohelper.setActive(CameraMgr.instance:getVirtualCameraGO(), false)
	transformhelper.setLocalPos(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)
	transformhelper.setLocalRotation(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)
end

function slot0.resetParam(slot0, slot1)
	slot1 = slot1 or slot0._cameraCO
	slot2 = slot1.yaw
	slot0.yaw = slot2

	slot0._cameraTrace:SetTargetParam(slot2, slot1.pitch, slot1.distance, slot0:_calcFovInternal(slot1), 0, 0, 0)
	slot0:setFocus(0, slot1.yOffset, slot1.focusZ)
end

function slot0._calcFovInternal(slot0, slot1)
	slot4, slot5 = slot0:_getMinMaxFov()

	return Mathf.Clamp(slot1.fov * 1.7777777777777777 * UnityEngine.Screen.height / UnityEngine.Screen.width, slot4, slot5)
end

function slot0._getMinMaxFov(slot0)
	return 35, 120
end

function slot0._onScreenResize(slot0, slot1, slot2)
	slot0:resetParam()
	slot0:applyDirectly()
end

function slot0.getCurCO(slot0)
	return slot0._cameraCO
end

function slot0.applyDirectly(slot0)
	slot0._cameraTrace:SetTargetFocusPos(transformhelper.getPos(CameraMgr.instance:getFocusTrs()))
	slot0._cameraTrace:ApplyDirectly()
end

function slot0.setFocus(slot0, slot1, slot2, slot3)
	transformhelper.setPos(CameraMgr.instance:getFocusTrs(), slot1, slot2, slot3)
end

function slot0.setFocusX(slot0, slot1)
	slot2 = CameraMgr.instance:getFocusTrs()
	slot3, slot4, slot5 = transformhelper.getPos(slot2)

	transformhelper.setPos(slot2, slot1, slot4, slot5)
end

function slot0.resetFocus(slot0)
	slot0:setFocus(0, slot0._cameraCO.yOffset, slot0._cameraCO.focusZ)
end

function slot0.setEaseTime(slot0, slot1)
	slot0._cameraTrace:SetEaseTime(slot1)
end

function slot0.setEaseType(slot0, slot1)
	slot0._cameraTrace:SetEaseType(slot1)
end

function slot0.setFocusTransform(slot0, slot1)
	slot0._cameraTrace:SetFocusTransform(slot1)
end

function slot0.clearFocusTransform(slot0)
	slot0._cameraTrace:ClearFocusTransform()
end

function slot0.setDistance(slot0, slot1)
	slot0._cameraTrace:SetTargetDistance(slot1)
end

function slot0.resetDistance(slot0)
	slot0._cameraTrace:SetTargetDistance(slot0._cameraCO.distance)
end

function slot0.shake(slot0, slot1, slot2, slot3, slot4)
	slot0._cameraTrace:Shake(slot1, slot2, slot3, slot4)
end

function slot0.setRotate(slot0, slot1, slot2)
	slot0._cameraTrace:SetTargetRotate(slot1, slot2)
end

function slot0.setFov(slot0, slot1)
	slot0._cameraTrace:SetTargetFov(slot1)
end

return slot0
