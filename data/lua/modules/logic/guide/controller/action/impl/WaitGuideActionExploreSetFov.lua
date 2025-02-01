module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreSetFov", package.seeall)

slot0 = class("WaitGuideActionExploreSetFov", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	slot3 = string.splitToNumber(slot0.actionParam, "#")[1] or 35
	slot4 = slot2[2] or 0
	slot5 = slot2[3] or EaseType.Linear

	if not GameSceneMgr.instance:getCurScene().camera or not isTypeOf(slot6, ExploreSceneCameraComp) then
		slot0:onDone(true)

		return
	end

	if slot4 > 0 then
		slot6:setEaseTime(slot4)
		slot6:setEaseType(slot5)
		slot6:setFov(slot3)
		TaskDispatcher.runDelay(slot0.onCameraChangeDone, slot0, slot4)
	else
		slot6:setFov(slot3)
		slot6:applyDirectly()
		slot0:onDone(true)
	end
end

function slot0.onCameraChangeDone(slot0)
	slot0:resetCameraParam()
	slot0:onDone(true)
end

function slot0.resetCameraParam(slot0)
	if not GameSceneMgr.instance:getCurScene().camera or not isTypeOf(slot1, ExploreSceneCameraComp) then
		return
	end

	slot1:setEaseTime(ExploreConstValue.CameraTraceTime)
	slot1:setEaseType(EaseType.Linear)
end

function slot0.clearWork(slot0)
	slot0:resetCameraParam()
	TaskDispatcher.cancelTask(slot0.onCameraChangeDone, slot0)
end

return slot0
