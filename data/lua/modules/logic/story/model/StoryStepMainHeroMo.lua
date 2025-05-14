module("modules.logic.story.model.StoryStepMainHeroMo", package.seeall)

local var_0_0 = pureTable("StoryStepMainHeroMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.mouses = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	arg_1_0.anims = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	arg_1_0.expressions = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.mouses = arg_2_1[1]
	arg_2_0.anims = arg_2_1[2]
	arg_2_0.expressions = arg_2_1[3]
end

return var_0_0
