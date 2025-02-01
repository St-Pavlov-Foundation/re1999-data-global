module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114GuideWork", package.seeall)

slot0 = class("Activity114GuideWork", Activity114BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._guideId = slot1

	uv0.super.ctor(slot0)
end

function slot0.onStart(slot0)
	if GuideModel.instance:getById(slot0._guideId) and slot1.isFinish or not slot1 then
		if not slot1 then
			logError("指引没有自动接？？？")
		end

		slot0:onDone(false)

		return
	end

	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, slot0._onGuideFinish, slot0)
	Activity114Controller.instance:dispatchEvent(Activity114Event.GuideBegin, tostring(slot0._guideId))
end

function slot0._onGuideFinish(slot0, slot1)
	if slot0._guideId ~= slot1 then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, slot0._onGuideFinish, slot0)

	if Activity114Model.instance:isEnd() then
		slot0:onDone(false)

		return
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, slot0._onGuideFinish, slot0)
	uv0.super.clearWork(slot0)
end

return slot0
