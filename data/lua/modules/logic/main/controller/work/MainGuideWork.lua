module("modules.logic.main.controller.work.MainGuideWork", package.seeall)

slot0 = class("MainGuideWork", BaseWork)

function slot0.onStart(slot0, slot1)
	GuideModel.instance:onOpenMainView()

	if GuideController.instance:isForbidGuides() then
		if isDebugBuild and slot0:_getDoingGuideId() then
			logError("登录主界面，屏蔽了强指引：" .. slot3)
		end

		slot0:onDone(true)

		return
	end

	if slot0:_getDoingGuideId() then
		slot0:_checkInvalid()
	elseif GuideTriggerController.instance:hasSatisfyGuide() then
		GuideController.instance:registerCallback(GuideEvent.StartGuide, slot0._checkInvalid, slot0)
	else
		slot0:_checkInvalid()
	end

	GuideTriggerController.instance:startTrigger()
end

function slot0._checkInvalid(slot0)
	if GuideInvalidController.instance:hasInvalidGuide() then
		GuideController.instance:registerCallback(GuideEvent.FinishGuide, slot0._checkDoGuide, slot0)
		GuideController.instance:registerCallback(GuideEvent.FinishGuideFail, slot0._exceptionDone, slot0)
		GuideInvalidController.instance:checkInvalid()
	else
		slot0:_checkDoGuide()
	end
end

function slot0._exceptionDone(slot0)
	logNormal("完成指引出异常，跳过")
	slot0:onDone(true)
end

function slot0._checkDoGuide(slot0)
	if GuideModel.instance:getDoingGuideIdList() then
		for slot5 = #slot1, 1, -1 do
			if GuideConfig.instance:getGuideCO(slot1[slot5]).parallel == 1 then
				GuideController.instance:execNextStep(slot1[slot5])
				table.remove(slot1, slot5)
			end
		end

		if GuideConfig.instance:getHighestPriorityGuideId(slot1) then
			GuideController.instance:execNextStep(slot2)
			GameSceneMgr.instance:dispatchEvent(SceneEventName.ManualClose)
			BGMSwitchController.instance:startAllOnLogin()
			slot0:onDone(false)

			return
		end
	end

	slot0:onDone(true)
end

function slot0._getDoingGuideId(slot0)
	if GuideModel.instance:getDoingGuideIdList() then
		for slot5 = #slot1, 1, -1 do
			if GuideConfig.instance:getGuideCO(slot1[slot5]).parallel == 1 then
				table.remove(slot1, slot5)
			end
		end

		return GuideConfig.instance:getHighestPriorityGuideId(slot1)
	end
end

function slot0.clearWork(slot0)
	GuideController.instance:unregisterCallback(GuideEvent.StartGuide, slot0._checkInvalid, slot0)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, slot0._checkDoGuide, slot0)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideFail, slot0._exceptionDone, slot0)
end

return slot0
