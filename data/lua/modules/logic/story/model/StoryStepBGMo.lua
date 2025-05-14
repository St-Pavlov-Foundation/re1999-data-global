module("modules.logic.story.model.StoryStepBGMo", package.seeall)

local var_0_0 = pureTable("StoryStepBGMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.bgType = 0
	arg_1_0.bgImg = ""
	arg_1_0.transType = 0
	arg_1_0.darkTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	arg_1_0.waitTimes = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	arg_1_0.fadeTimes = {
		0.5,
		0.5,
		0.5,
		0.5,
		0.5,
		0.5,
		0.5,
		0.5
	}
	arg_1_0.offset = {}
	arg_1_0.angle = 0
	arg_1_0.scale = 1
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
	arg_1_0.effType = 0
	arg_1_0.effDegree = 0
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
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.bgType = arg_2_1[1]

	if arg_2_1[2] ~= "" then
		local var_2_0 = string.find(arg_2_1[2], "/") and arg_2_1[2] or "bg/" .. arg_2_1[2]

		arg_2_0.bgImg = StoryBgZoneModel.instance:getRightBgZonePath(var_2_0)
	end

	arg_2_0.transType = arg_2_1[3]
	arg_2_0.darkTimes = arg_2_1[4]
	arg_2_0.waitTimes = arg_2_1[5]
	arg_2_0.fadeTimes = arg_2_1[6]
	arg_2_0.offset = {
		arg_2_1[7],
		arg_2_1[8]
	}
	arg_2_0.angle = arg_2_1[9]
	arg_2_0.scale = arg_2_1[10]
	arg_2_0.transTimes = arg_2_1[11]
	arg_2_0.effType = arg_2_1[12]
	arg_2_0.effDegree = arg_2_1[13]
	arg_2_0.effDelayTimes = arg_2_1[14]
	arg_2_0.effTimes = arg_2_1[15]
	arg_2_0.effRate = arg_2_1[16]
end

return var_0_0
