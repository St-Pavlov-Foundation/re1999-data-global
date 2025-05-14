module("modules.logic.story.model.StoryStepNavigateMo", package.seeall)

local var_0_0 = pureTable("StoryStepNavigateMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.navigateType = 1
	arg_1_0.navigateTxts = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	arg_1_0.navigateChapterEn = ""
	arg_1_0.navigateLogo = ""
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.navigateType = arg_2_1[1]
	arg_2_0.navigateTxts = arg_2_1[2]
	arg_2_0.navigateChapterEn = arg_2_1[3]
	arg_2_0.navigateLogo = arg_2_1[4]
end

return var_0_0
