module("modules.logic.guide.controller.action.impl.WaitGuideActionPlayStoryStep", package.seeall)

local var_0_0 = class("WaitGuideActionPlayStoryStep", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	StoryController.instance:registerCallback(StoryEvent.RefreshStep, arg_1_0._onStep, arg_1_0)

	local var_1_0 = string.splitToNumber(arg_1_0.actionParam, "#")

	if #var_1_0 == 2 then
		arg_1_0.storyId = var_1_0[1]
		arg_1_0.stepId = var_1_0[2]
	end
end

function var_0_0._onStep(arg_2_0, arg_2_1)
	if arg_2_0.storyId and arg_2_0.stepId and arg_2_0.storyId == arg_2_1.storyId and arg_2_0.stepId == arg_2_1.stepId then
		StoryController.instance:unregisterCallback(StoryEvent.RefreshStep, arg_2_0._onStep, arg_2_0)

		if StoryModel.instance:isStoryAuto() then
			StoryModel.instance:setStoryAuto(false)
			StoryController.instance:dispatchEvent(StoryEvent.Auto)
		end

		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	StoryController.instance:unregisterCallback(StoryEvent.RefreshStep, arg_3_0._onStep, arg_3_0)
end

return var_0_0
