module("modules.logic.versionactivity1_4.act131.model.Activity131LogMo", package.seeall)

local var_0_0 = pureTable("Activity131LogMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.info = {}
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._speaker = arg_2_1
	arg_2_0._speech = arg_2_2
	arg_2_0._audioId = arg_2_3
end

function var_0_0.getSpeaker(arg_3_0)
	return arg_3_0._speaker
end

function var_0_0.getSpeech(arg_4_0)
	return arg_4_0._speech
end

function var_0_0.getAudioId(arg_5_0)
	return arg_5_0._audioId or 0
end

return var_0_0
