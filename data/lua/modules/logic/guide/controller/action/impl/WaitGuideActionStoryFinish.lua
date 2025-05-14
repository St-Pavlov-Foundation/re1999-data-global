module("modules.logic.guide.controller.action.impl.WaitGuideActionStoryFinish", package.seeall)

local var_0_0 = class("WaitGuideActionStoryFinish", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.splitToNumber(arg_1_0.actionParam, "#")

	arg_1_0._storyId = var_1_0[1]
	arg_1_0._noCheckFinish = var_1_0[2] == 1

	if arg_1_0._storyId and not arg_1_0._noCheckFinish and StoryModel.instance:isStoryFinished(arg_1_0._storyId) then
		arg_1_0:onDone(true)
	else
		StoryController.instance:registerCallback(StoryEvent.Finish, arg_1_0._onStoryFinish, arg_1_0)
	end
end

function var_0_0._onStoryFinish(arg_2_0, arg_2_1)
	if not arg_2_0._storyId or arg_2_0._storyId == arg_2_1 then
		StoryController.instance:unregisterCallback(StoryEvent.Finish, arg_2_0._onStoryFinish, arg_2_0)
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, arg_3_0._onStoryFinish, arg_3_0)
end

return var_0_0
