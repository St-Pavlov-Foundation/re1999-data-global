module("modules.logic.guide.controller.action.impl.WaitGuideActionWaitSeconds", package.seeall)

slot0 = class("WaitGuideActionWaitSeconds", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	logNormal(string.format("<color=#EA00B3>start guide_%d_%d WaitGuideActionWaitSeconds second:%s</color>", slot0.guideId, slot0.stepId, slot0.actionParam))
	GuideBlockMgr.instance:startBlock((tonumber(slot0.actionParam) or 0) + GuideBlockMgr.BlockTime)

	slot0.context = slot1
	slot0.status = WorkStatus.Running

	TaskDispatcher.runDelay(slot0._onTimeEnd, slot0, slot2 or 0.01)
end

function slot0._onTimeEnd(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._onTimeEnd, slot0)
end

return slot0
