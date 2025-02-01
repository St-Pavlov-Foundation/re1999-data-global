module("modules.logic.scene.pushbox.comp.PushBoxSceneCameraComp", package.seeall)

slot0 = class("PushBoxSceneCameraComp", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._scene = slot0:getCurScene()
	slot0._cameraTrace = CameraMgr.instance:getCameraTrace()
end

function slot0.onSceneStart(slot0, slot1, slot2)
	transformhelper.setPos(CameraMgr.instance:getFocusTrs(), 0, 0, 0)

	slot0._cameraTrace.EnableTrace = false

	gohelper.setActive(CameraMgr.instance:getVirtualCameraGO(), false)
	transformhelper.setLocalPos(CameraMgr.instance:getMainCameraTrs(), 0, -5.8, -200)
	transformhelper.setLocalRotation(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)

	CameraMgr.instance:getMainCamera().farClipPlane = 1000
end

function slot0.onSceneClose(slot0)
	CameraMgr.instance:getMainCamera().farClipPlane = 500
end

return slot0
