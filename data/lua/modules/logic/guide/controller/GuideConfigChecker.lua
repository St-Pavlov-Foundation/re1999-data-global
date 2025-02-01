module("modules.logic.guide.controller.GuideConfigChecker", package.seeall)

slot0 = class("GuideConfigChecker")

function slot0.addConstEvents(slot0)
	if isDebugBuild then
		GuideController.instance:registerCallback(GuideEvent.StartGuideStep, slot0._onCheckForceGuideStep, slot0)
	end
end

function slot0.onInit(slot0)
	slot0._checkForceGuideId = nil
end

function slot0.reInit(slot0)
	if isDebugBuild then
		GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, slot0._onFinishGuide, slot0)
		GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, slot0._onTouch, slot0)
		GuideController.instance:registerCallback(GuideEvent.StartGuideStep, slot0._onCheckForceGuideStep, slot0)
	end

	slot0._checkForceGuideId = nil
end

function slot0._onCheckForceGuideStep(slot0, slot1, slot2)
	if slot1 >= 600 and GuideConfig.instance:getGuideCO(slot1).parallel == 0 then
		slot0._checkForceGuideId = slot1

		GuideController.instance:unregisterCallback(GuideEvent.StartGuideStep, slot0._onCheckForceGuideStep, slot0)
		GuideController.instance:registerCallback(GuideEvent.FinishGuide, slot0._onFinishGuide, slot0)
		GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, slot0._onTouch, slot0)
	end
end

function slot0._onTouch(slot0)
	if not slot0._filterViews then
		slot0._filterViews = {
			ViewName.GuideView,
			ViewName.FightGuideView,
			ViewName.StoryView
		}
	end

	for slot4, slot5 in ipairs(slot0._filterViews) do
		if ViewMgr.instance:isOpen(slot5) then
			slot0._touchCount = 0

			break
		end
	end

	slot0._touchCount = slot0._touchCount and slot0._touchCount + 1 or 1

	if slot0._touchCount > 10 then
		if slot0._checkForceGuideId then
			logError("是否可以改成弱指引：" .. slot0._checkForceGuideId .. " " .. GuideConfig.instance:getGuideCO(slot0._checkForceGuideId).desc)
		end

		slot0._checkForceGuideId = nil

		GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, slot0._onFinishGuide, slot0)
		GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, slot0._onTouch, slot0)
	end
end

function slot0._onFinishGuide(slot0, slot1)
	if slot0._checkForceGuideId == slot1 then
		GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, slot0._onFinishGuide, slot0)
	end
end

slot0.instance = slot0.New()

return slot0
