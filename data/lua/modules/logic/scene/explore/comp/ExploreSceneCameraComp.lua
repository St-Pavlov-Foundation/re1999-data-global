module("modules.logic.scene.explore.comp.ExploreSceneCameraComp", package.seeall)

slot0 = class("ExploreSceneCameraComp", CommonSceneCameraComp)

function slot0.onInit(slot0)
	slot0._scene = slot0:getCurScene()
	slot0._rawcameraTrace = CameraMgr.instance:getCameraTrace()
	slot0._cameraTrace = slot0._rawcameraTrace
	slot0._cameraCO = nil
end

function slot0._onScreenResize(slot0)
	slot2, slot3, slot4 = transformhelper.getPos(CameraMgr.instance:getFocusTrs())

	slot0._cameraTrace:SetTargetFocusPos(slot2, slot3, slot4)

	if slot0._nowFov then
		slot0:setFov(slot0._nowFov)
		slot0._cameraTrace:ApplyDirectly()
	end
end

function slot0.onSceneStart(slot0, ...)
	slot0._rawcameraTrace.enabled = false
	slot0._cameraTrace = gohelper.onceAddComponent(slot0._rawcameraTrace, typeof(ZProj.ExploreCameraTrace))

	slot0._cameraTrace:SetEaseTime(ExploreConstValue.CameraTraceTime)
	uv0.super.onSceneStart(slot0, ...)
end

function slot0.setFocus(slot0, slot1, slot2, slot3)
	transformhelper.setPos(CameraMgr.instance:getFocusTrs(), slot1, slot2, slot3)
	slot0._cameraTrace:SetTargetFocusPos(slot1, slot2, slot3)
end

function slot0.setFov(slot0, slot1)
	slot0._nowFov = slot1

	slot0._cameraTrace:SetTargetFov(slot1 * math.max(1.7777777777777777 * UnityEngine.Screen.height / UnityEngine.Screen.width, 1))
end

function slot0.onSceneClose(slot0, ...)
	slot0._rawcameraTrace.enabled = true

	gohelper.destroy(slot0._cameraTrace)

	slot0._cameraTrace = slot0._rawcameraTrace

	uv0.super.onSceneClose(slot0, ...)
end

return slot0
