module("modules.logic.guide.controller.action.impl.WaitGuideActionWaitForGuideFinish", package.seeall)

slot0 = class("WaitGuideActionWaitForGuideFinish", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot0._waitForGuides = string.splitToNumber(slot0.actionParam, "#")

	if not slot0:_hasDoingGuide() then
		slot0:onDone(true)
	else
		GuideController.instance:registerCallback(GuideEvent.FinishGuide, slot0._onFinishGuide, slot0)
	end
end

function slot0._hasDoingGuide(slot0)
	for slot4, slot5 in ipairs(slot0._waitForGuides) do
		if GuideModel.instance:isGuideRunning(slot5) then
			return true
		end
	end

	return false
end

function slot0._onFinishGuide(slot0)
	if not slot0:_hasDoingGuide() then
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, slot0._onFinishGuide, slot0)
end

return slot0
