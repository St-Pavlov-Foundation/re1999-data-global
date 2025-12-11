module("modules.logic.sp01.act208.controller.Act208Controller", package.seeall)

local var_0_0 = class("Act208Controller", BaseController)

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

function var_0_0.getActInfo(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	Act208Rpc.instance:sendGetAct208InfoRequest(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
end

function var_0_0.getBonus(arg_6_0, arg_6_1, arg_6_2)
	Act208Rpc.instance:sendAct208ReceiveBonusRequest(arg_6_1, arg_6_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
