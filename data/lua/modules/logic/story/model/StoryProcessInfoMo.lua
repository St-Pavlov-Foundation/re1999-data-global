module("modules.logic.story.model.StoryProcessInfoMo", package.seeall)

local var_0_0 = pureTable("StoryProcessInfoMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.storyId = nil
	arg_1_0.stepId = nil
	arg_1_0.favor = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.storyId = arg_2_1.storyId
	arg_2_0.stepId = arg_2_1.stepId
	arg_2_0.favor = arg_2_1.favor
end

return var_0_0
