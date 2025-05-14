module("modules.logic.story.model.StoryStepAudioMo", package.seeall)

local var_0_0 = pureTable("StoryStepAudioMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.audio = 0
	arg_1_0.audioState = 0
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
	arg_1_0.volume = 1
	arg_1_0.transTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	arg_1_0.count = 1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.audio = arg_2_1[1]
	arg_2_0.audioState = arg_2_1[2]
	arg_2_0.delayTimes = arg_2_1[3]
	arg_2_0.orderType = arg_2_1[4]
	arg_2_0.volume = arg_2_1[5]
	arg_2_0.transTimes = arg_2_1[6]
	arg_2_0.count = arg_2_1[7]
end

return var_0_0
