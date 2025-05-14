module("modules.logic.story.model.StoryStepOptionMo", package.seeall)

local var_0_0 = pureTable("StoryStepOptionMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.condition = false
	arg_1_0.conditionType = 0
	arg_1_0.conditionValue = ""
	arg_1_0.conditionValue2 = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	arg_1_0.branchTxts = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	arg_1_0.type = 0
	arg_1_0.feedbackType = 0
	arg_1_0.feedbackValue = 0
	arg_1_0.back = false
	arg_1_0.id = 0
	arg_1_0.followId = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.condition = arg_2_1[1]
	arg_2_0.conditionType = arg_2_1[2]
	arg_2_0.conditionValue = arg_2_1[3]
	arg_2_0.conditionValue2 = arg_2_1[4]
	arg_2_0.branchTxts = arg_2_1[5]
	arg_2_0.type = arg_2_1[6]
	arg_2_0.feedbackType = arg_2_1[7]
	arg_2_0.feedbackValue = arg_2_1[8]
	arg_2_0.back = arg_2_1[9]
	arg_2_0.id = arg_2_1[10]
	arg_2_0.followId = arg_2_1[11]
end

return var_0_0
