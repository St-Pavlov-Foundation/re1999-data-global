module("modules.logic.scene.cachot.comp.CachotSceneCamera", package.seeall)

slot0 = class("CachotSceneCamera", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot0._levelComp = slot0._scene.level
	slot3 = CameraMgr.instance:getCameraTrace()
	slot0._traceEnabled = slot3.enabled
	slot3.enabled = false
	slot4 = CameraMgr.instance:getMainCamera()
	slot5 = CameraMgr.instance:getMainCameraTrs()
	slot0._rawCameraIsOrthographic = slot4.orthographic
	slot0._rawCameraIsOrthographicSize = slot4.orthographicSize

	gohelper.setActive(CameraMgr.instance:getVirtualCameraGO(), false)
	transformhelper.setLocalPos(slot5, 0, 0, 0)
	transformhelper.setLocalRotation(slot5, 0, 0, 0)

	slot4.orthographic = true
	slot4.orthographicSize = 5 * GameUtil.getAdapterScale(true)

	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0.onScreenResize, slot0)
end

function slot0.onScreenResize(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true
	slot1.orthographicSize = 5 * GameUtil.getAdapterScale(true)
end

function slot0.onSceneClose(slot0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, slot0.onScreenResize, slot0)

	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographicSize = slot0._rawCameraIsOrthographicSize
	slot1.orthographic = slot0._rawCameraIsOrthographic
	CameraMgr.instance:getCameraTrace().enabled = slot0._traceEnabled
end

return slot0
