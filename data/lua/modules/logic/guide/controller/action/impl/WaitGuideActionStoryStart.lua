module("modules.logic.guide.controller.action.impl.WaitGuideActionStoryStart", package.seeall)

local var_0_0 = class("WaitGuideActionStoryStart", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	StoryController.instance:registerCallback(StoryEvent.Start, arg_1_0._onStoryStart, arg_1_0)

	arg_1_0._storyId = tostring(arg_1_0.actionParam)
end

function var_0_0._onStoryStart(arg_2_0, arg_2_1)
	if not arg_2_0._storyId or arg_2_0._storyId == arg_2_1 then
		StoryController.instance:unregisterCallback(StoryEvent.Start, arg_2_0._onStoryStart, arg_2_0)
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	StoryController.instance:unregisterCallback(StoryEvent.Start, arg_3_0._onStoryStart, arg_3_0)
end

return var_0_0
