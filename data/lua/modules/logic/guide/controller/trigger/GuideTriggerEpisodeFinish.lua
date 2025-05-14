module("modules.logic.guide.controller.trigger.GuideTriggerEpisodeFinish", package.seeall)

local var_0_0 = class("GuideTriggerEpisodeFinish", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, arg_1_0._checkStartGuide, arg_1_0)
	StoryController.instance:registerCallback(StoryEvent.Finish, arg_1_0._checkStartGuide, arg_1_0)
	GameSceneMgr.instance:registerCallback(SceneType.Main, arg_1_0._onMainScene, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = tonumber(arg_2_2)
	local var_2_1 = DungeonModel.instance:getEpisodeInfo(var_2_0)
	local var_2_2 = DungeonConfig.instance:getEpisodeCO(var_2_0)

	if var_2_2 and var_2_1 and var_2_1.star > DungeonEnum.StarType.None then
		return var_2_2.afterStory <= 0 or var_2_2.afterStory > 0 and StoryModel.instance:isStoryFinished(var_2_2.afterStory)
	else
		return false
	end
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
