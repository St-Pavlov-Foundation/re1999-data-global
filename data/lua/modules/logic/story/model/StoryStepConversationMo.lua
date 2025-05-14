module("modules.logic.story.model.StoryStepConversationMo", package.seeall)

local var_0_0 = pureTable("StoryStepConversationMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.type = 0
	arg_1_0.delayTimes = {
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1
	}
	arg_1_0.isAuto = false
	arg_1_0.effType = 0
	arg_1_0.effLv = 0
	arg_1_0.effDelayTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	arg_1_0.effTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	arg_1_0.effRate = 1
	arg_1_0.showList = {}
	arg_1_0.nameShow = false
	arg_1_0.nameEnShow = false
	arg_1_0.heroNames = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	arg_1_0.iconShow = false
	arg_1_0.heroIcon = ""
	arg_1_0.audios = {}
	arg_1_0.audioDelayTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	arg_1_0.diaTexts = {
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	}
	arg_1_0.showTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	arg_1_0.keepTimes = {
		1.5,
		1.5,
		1.5,
		1.5,
		1.5,
		1.5,
		1.5,
		1.5
	}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.type = arg_2_1[1]
	arg_2_0.delayTimes = arg_2_1[2]
	arg_2_0.isAuto = arg_2_1[3]
	arg_2_0.effType = arg_2_1[4]
	arg_2_0.effLv = arg_2_1[5]
	arg_2_0.effDelayTimes = arg_2_1[6]
	arg_2_0.effTimes = arg_2_1[7]
	arg_2_0.effRate = arg_2_1[8]
	arg_2_0.showList = arg_2_1[9]
	arg_2_0.nameShow = arg_2_1[10]
	arg_2_0.nameEnShow = arg_2_1[11]
	arg_2_0.heroNames = arg_2_1[12]
	arg_2_0.iconShow = arg_2_1[13]
	arg_2_0.heroIcon = arg_2_1[14]

	local var_2_0 = string.split(arg_2_1[15], "#")

	arg_2_0.audios = var_2_0[1] == "" and {
		0
	} or string.splitToNumber(var_2_0[1], "&")

	if var_2_0[2] then
		local var_2_1 = string.splitToNumber(var_2_0[2], "|")

		for iter_2_0 = 1, #var_2_1 do
			arg_2_0.audioDelayTimes[iter_2_0] = var_2_1[iter_2_0]
		end
	end

	arg_2_0.diaTexts = arg_2_1[16]
	arg_2_0.showTimes = arg_2_1[17]
	arg_2_0.keepTimes = arg_2_1[18]
end

return var_0_0
