module("modules.logic.versionactivity2_4.act181.controller.Activity181Controller", package.seeall)

local var_0_0 = class("Activity181Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.getActivityInfo(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	Activity181Rpc.instance:SendGet181InfosRequest(arg_5_1, arg_5_2, arg_5_3)
end

function var_0_0.getBonus(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	Activity181Rpc.instance:SendGet181BonusRequest(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
end

function var_0_0.getSPBonus(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	Activity181Rpc.instance:SendGet181SpBonusRequest(arg_7_1, arg_7_2, arg_7_3)
end

var_0_0.instance = var_0_0.New()

return var_0_0
