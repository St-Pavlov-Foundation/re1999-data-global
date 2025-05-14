module("modules.logic.guide.controller.trigger.GuideTriggerEpisodeAndGuideFinish", package.seeall)

local var_0_0 = class("GuideTriggerEpisodeAndGuideFinish", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, arg_1_0._checkStartGuide, arg_1_0)
	StoryController.instance:registerCallback(StoryEvent.Finish, arg_1_0._checkStartGuide, arg_1_0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, arg_1_0._checkStartGuide, arg_1_0)
	GameSceneMgr.instance:registerCallback(SceneType.Main, arg_1_0._onMainScene, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = string.splitToNumber(arg_2_2, "_")
	local var_2_1 = var_2_0[1]
	local var_2_2 = var_2_0[2]
	local var_2_3 = DungeonModel.instance:getEpisodeInfo(var_2_1)
	local var_2_4 = DungeonConfig.instance:getEpisodeCO(var_2_1)
	local var_2_5 = false

	if var_2_4 and var_2_3 and var_2_3.star > DungeonEnum.StarType.None then
		var_2_5 = var_2_4.afterStory <= 0 or var_2_4.afterStory > 0 and StoryModel.instance:isStoryFinished(var_2_4.afterStory)
	end

	local var_2_6 = GuideModel.instance:isGuideFinish(var_2_2)

	return var_2_5 and var_2_6
end

function var_0_0._onMainScene(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 == 1 then
		arg_3_0:checkStartGuide()
	end
end

function var_0_0._checkStartGuide(arg_4_0)
	arg_4_0:checkStartGuide()
end

return var_0_0
