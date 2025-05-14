module("modules.logic.login.controller.work.LoginFirstGuideWork", package.seeall)

local var_0_0 = class("LoginFirstGuideWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if GuideController.instance:isForbidGuides() then
		arg_1_0:onDone(true)
	elseif GuideModel.instance:isGuideFinish(GuideController.FirstGuideId) then
		arg_1_0:onDone(true)
	else
		GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0._enterSceneFinish, arg_1_0)
		GameSceneMgr.instance:startScene(SceneType.Newbie, 101, 10101)
	end
end

function var_0_0._enterSceneFinish(arg_2_0, arg_2_1, arg_2_2)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, arg_2_0._onFinishGuide, arg_2_0)

	if GuideModel.instance:isDoingFirstGuide() and not GuideController.instance:isForbidGuides() then
		GameSceneMgr.instance:registerCallback(SceneEventName.WaitCloseHeadsetView, arg_2_0._startFirstGuide, arg_2_0)
	else
		arg_2_0:_startFirstGuide()
	end
end

function var_0_0._startFirstGuide(arg_3_0)
	local var_3_0 = GuideConfig.instance:getGuideCO(GuideController.FirstGuideId)

	GuideController.instance:checkStartFirstGuide()
end

function var_0_0._onFinishGuide(arg_4_0, arg_4_1)
	if arg_4_1 == GuideController.FirstGuideId then
		arg_4_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_5_0)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, arg_5_0._onFinishGuide, arg_5_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.WaitCloseHeadsetView, arg_5_0._startFirstGuide, arg_5_0)
end

function var_0_0._removeEvents(arg_6_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, arg_6_0._enterSceneFinish, arg_6_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.WaitCloseHeadsetView, arg_6_0._startFirstGuide, arg_6_0)
end

return var_0_0
