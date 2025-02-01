module("modules.logic.login.controller.work.LoginFirstGuideWork", package.seeall)

slot0 = class("LoginFirstGuideWork", BaseWork)

function slot0.onStart(slot0, slot1)
	if GuideController.instance:isForbidGuides() then
		slot0:onDone(true)
	elseif GuideModel.instance:isGuideFinish(GuideController.FirstGuideId) then
		slot0:onDone(true)
	else
		GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._enterSceneFinish, slot0)
		GameSceneMgr.instance:startScene(SceneType.Newbie, 101, 10101)
	end
end

function slot0._enterSceneFinish(slot0, slot1, slot2)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, slot0._onFinishGuide, slot0)

	if GuideModel.instance:isDoingFirstGuide() and not GuideController.instance:isForbidGuides() then
		GameSceneMgr.instance:registerCallback(SceneEventName.WaitCloseHeadsetView, slot0._startFirstGuide, slot0)
	else
		slot0:_startFirstGuide()
	end
end

function slot0._startFirstGuide(slot0)
	slot1 = GuideConfig.instance:getGuideCO(GuideController.FirstGuideId)

	GuideController.instance:checkStartFirstGuide()
end

function slot0._onFinishGuide(slot0, slot1)
	if slot1 == GuideController.FirstGuideId then
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, slot0._onFinishGuide, slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.WaitCloseHeadsetView, slot0._startFirstGuide, slot0)
end

function slot0._removeEvents(slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, slot0._enterSceneFinish, slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.WaitCloseHeadsetView, slot0._startFirstGuide, slot0)
end

return slot0
