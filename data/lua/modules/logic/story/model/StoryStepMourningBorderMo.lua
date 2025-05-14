module("modules.logic.story.model.StoryStepMourningBorderMo", package.seeall)

local var_0_0 = pureTable("StoryStepMourningBorderMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.borderType = 0
	arg_1_0.borderTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.borderType = arg_2_1[1]
	arg_2_0.borderTimes = arg_2_1[2]
end

return var_0_0
