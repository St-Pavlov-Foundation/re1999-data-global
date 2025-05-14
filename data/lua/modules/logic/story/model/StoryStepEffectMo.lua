module("modules.logic.story.model.StoryStepEffectMo", package.seeall)

local var_0_0 = pureTable("StoryStepEffectMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.effect = ""
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
	arg_1_0.inType = 0
	arg_1_0.inTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	arg_1_0.outType = 0
	arg_1_0.outTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	arg_1_0.pos = {}
	arg_1_0.layer = 9
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.effect = arg_2_1[1]
	arg_2_0.delayTimes = arg_2_1[2]
	arg_2_0.orderType = arg_2_1[3]
	arg_2_0.inType = arg_2_1[4]
	arg_2_0.inTimes = arg_2_1[5]
	arg_2_0.outType = arg_2_1[6]
	arg_2_0.outTimes = arg_2_1[7]
	arg_2_0.pos = {
		arg_2_1[8],
		arg_2_1[9]
	}
	arg_2_0.layer = arg_2_1[10]
end

return var_0_0
