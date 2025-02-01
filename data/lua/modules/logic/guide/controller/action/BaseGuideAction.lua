module("modules.logic.guide.controller.action.BaseGuideAction", package.seeall)

slot0 = class("BaseGuideAction", BaseWork)

function slot0.ctor(slot0, slot1, slot2, slot3)
	slot0.guideId = slot1
	slot0.stepId = slot2
	slot0.actionParam = slot3
end

function slot0.checkGuideLock(slot0)
	if not GuideModel.instance:getLockGuideId() then
		return false
	end

	return slot1 ~= slot0.guideId
end

function slot0.onStart(slot0, slot1)
	logNormal(string.format("<color=#EA00B3>start guide_%d_%d %s</color>", slot0.guideId, slot0.stepId, slot0.__cname))
	GuideBlockMgr.instance:startBlock()

	slot0.context = slot1
	slot0.status = WorkStatus.Running
end

function slot0.onDestroy(slot0)
	logNormal(string.format("<color=#EA00B3>destroy guide_%d_%d %s</color>", slot0.guideId, slot0.stepId, slot0.__cname))
	GuideBlockMgr.instance:startBlock()
	uv0.super.onDestroy(slot0)
end

return slot0
