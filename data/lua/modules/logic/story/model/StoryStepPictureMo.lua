module("modules.logic.story.model.StoryStepPictureMo", package.seeall)

local var_0_0 = pureTable("StoryStepPictureMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.picType = 0
	arg_1_0.cirRadius = 0
	arg_1_0.picColor = "#ffffffff"
	arg_1_0.picture = ""
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
	arg_2_0.picType = arg_2_1[1]
	arg_2_0.cirRadius = arg_2_1[2]
	arg_2_0.picColor = arg_2_1[3]
	arg_2_0.picture = arg_2_1[4]
	arg_2_0.delayTimes = arg_2_1[5]
	arg_2_0.orderType = arg_2_1[6]
	arg_2_0.inType = arg_2_1[7]
	arg_2_0.inTimes = arg_2_1[8]
	arg_2_0.outType = arg_2_1[9]
	arg_2_0.outTimes = arg_2_1[10]
	arg_2_0.pos = {
		arg_2_1[11],
		arg_2_1[12]
	}
	arg_2_0.layer = arg_2_1[13]
	arg_2_0.effType = arg_2_1[14]
	arg_2_0.effDegree = arg_2_1[15]
	arg_2_0.effDelayTimes = arg_2_1[16]
	arg_2_0.effTimes = arg_2_1[17]
	arg_2_0.effRate = arg_2_1[18]
end

return var_0_0
