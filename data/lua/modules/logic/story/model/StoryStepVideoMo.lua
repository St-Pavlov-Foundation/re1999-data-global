module("modules.logic.story.model.StoryStepVideoMo", package.seeall)

local var_0_0 = pureTable("StoryStepVideoMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.video = ""
	arg_1_0.delayTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	arg_1_0.orderType = 0
	arg_1_0.loop = false
	arg_1_0.layer = 6
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.video = arg_2_1[1]
	arg_2_0.delayTimes = arg_2_1[2]
	arg_2_0.orderType = arg_2_1[3]
	arg_2_0.loop = arg_2_1[4]
	arg_2_0.layer = arg_2_1[5]
end

return var_0_0
