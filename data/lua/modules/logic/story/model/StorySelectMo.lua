module("modules.logic.story.model.StorySelectMo", package.seeall)

local var_0_0 = pureTable("StorySelectMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.name = ""
	arg_1_0.index = 0
	arg_1_0.stepId = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.name = arg_2_1.name
	arg_2_0.index = arg_2_1.index
	arg_2_0.stepId = arg_2_1.stepId
end

return var_0_0
