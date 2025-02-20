module("modules.logic.versionactivity2_3.zhixinquaner.maze.controller.ZhiXinQuanErGuideStep", package.seeall)

slot0 = class("ZhiXinQuanErGuideStep", BaseWork)

function slot0.initData(slot0, slot1)
	slot0.effectData = slot1
	slot0._guideId = tonumber(slot0.effectData.param)
end

function slot0.onStart(slot0)
	if GuideController.instance:isForbidGuides() then
		slot0:onDone(true)

		return
	end

	if GuideModel.instance:isGuideFinish(slot0._guideId) then
		slot0:onDone(true)

		return
	end

	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, slot0._onGuideFinish, slot0)
	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.GuideStart, tostring(slot0._guideId))
end

function slot0._onGuideFinish(slot0, slot1)
	if slot0._guideId ~= slot1 then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, slot0._onGuideFinish, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, slot0._onGuideFinish, slot0)
end

return slot0
