module("modules.logic.seasonver.act166.model.Season166BaseSpotMO", package.seeall)

local var_0_0 = pureTable("Season166BaseSpotMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.isEnter = false
	arg_1_0.maxScore = 0
end

function var_0_0.setData(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.isEnter = arg_2_1.isEnter
	arg_2_0.maxScore = arg_2_1.maxScore
end

return var_0_0
