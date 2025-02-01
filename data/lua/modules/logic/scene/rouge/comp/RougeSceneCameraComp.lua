module("modules.logic.scene.rouge.comp.RougeSceneCameraComp", package.seeall)

slot0 = class("RougeSceneCameraComp", BaseSceneComp)

function slot0.onInit(slot0)
end

function slot0.onSceneStart(slot0, slot1, slot2)
	RougeMapController.instance:registerCallback(RougeMapEvent.onLoadMapDone, slot0.onLoadMapDone, slot0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onExitPieceChoiceEvent, slot0.onExitPieceChoiceEvent, slot0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onMiddleActorBeforeMove, slot0.onMiddleActorBeforeMove, slot0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onPathSelectMapFocus, slot0.onPathSelectMapFocus, slot0)
	RougeMapController.instance:registerCallback(RougeMapEvent.focusChangeCameraSize, slot0.focusChangeCameraSize, slot0)
end

function slot0.focusChangeCameraSize(slot0)
	if slot0.camera then
		slot0.camera.orthographicSize = RougeMapModel.instance:getCameraSize()
	end
end

function slot0.onLoadMapDone(slot0)
	slot0:initCameraSize()
end

function slot0.initCameraSize(slot0)
	gohelper.setActive(CameraMgr.instance:getVirtualCameraGO(), false)
	transformhelper.setLocalPos(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)
	transformhelper.setLocalRotation(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)

	if CameraMgr.instance:getCameraTrace() then
		slot1.EnableTrace = false
	end

	slot0.camera = CameraMgr.instance:getMainCamera()
	slot0.camera.orthographic = true
	slot0.camera.orthographicSize = RougeMapModel.instance:getCameraSize()
end

function slot0.clearCamera(slot0)
	if slot0.camera then
		slot0.camera.orthographicSize = 5
		slot0.camera.orthographic = false
	end
end

function slot0.onSceneClose(slot0)
	slot0:clearCamera()

	slot0.camera = nil

	RougeMapController.instance:unregisterCallback(RougeMapEvent.onLoadMapDone, slot0.onLoadMapDone, slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onExitPieceChoiceEvent, slot0.onExitPieceChoiceEvent, slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onMiddleActorBeforeMove, slot0.onMiddleActorBeforeMove, slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onPathSelectMapFocus, slot0.onPathSelectMapFocus, slot0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.focusChangeCameraSize, slot0.focusChangeCameraSize, slot0)
	slot0:clearTween()
end

function slot0.clearTween(slot0)
	if slot0.movingTweenId then
		ZProj.TweenHelper.KillById(slot0.movingTweenId)
	end

	slot0.movingTweenId = nil
end

function slot0.onMiddleActorBeforeMove(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.MiddleLayerFocus)
	slot0:clearTween()

	slot0.movingTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, RougeMapEnum.RevertDuration, slot0.frameCallback, slot0.onTweenDone, slot0, nil, RougeMapEnum.CameraTweenLine)
end

function slot0.onExitPieceChoiceEvent(slot0)
	if not RougeMapModel.instance:isMiddle() then
		return
	end

	slot0:clearTween()

	slot0.movingTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, RougeMapEnum.RevertDuration, slot0.frameCallback, slot0.onTweenDone, slot0, nil, RougeMapEnum.CameraTweenLine)
end

function slot0.frameCallback(slot0, slot1)
	slot2 = RougeMapModel.instance:getCameraSize()
	slot3 = RougeMapEnum.MiddleLayerCameraSizeRate * slot2
	slot5 = slot3 + slot1 * (slot2 - slot3)
	slot0.camera.orthographicSize = slot5

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onCameraSizeChange, slot5)
end

function slot0.onPathSelectMapFocus(slot0, slot1)
	slot0:clearTween()

	slot0.targetCameraSize = slot1
	slot0.movingTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, RougeMapEnum.RevertDuration, slot0.pathSelectMapFrameCallback, slot0.onTweenDone, slot0, nil, RougeMapEnum.CameraTweenLine)
end

function slot0.pathSelectMapFrameCallback(slot0, slot1)
	slot2 = RougeMapModel.instance:getCameraSize()
	slot4 = slot2 + slot1 * (slot0.targetCameraSize - slot2)
	slot0.camera.orthographicSize = slot4

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onCameraSizeChange, slot4)
end

function slot0.onTweenDone(slot0)
	slot0.movingTweenId = nil
end

return slot0
