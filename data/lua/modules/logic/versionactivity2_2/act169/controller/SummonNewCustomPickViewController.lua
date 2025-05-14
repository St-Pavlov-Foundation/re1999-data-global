module("modules.logic.versionactivity2_2.act169.controller.SummonNewCustomPickViewController", package.seeall)

local var_0_0 = class("SummonNewCustomPickViewController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.getSummonInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	SummonNewCustomPickViewRpc.instance:sendGet169InfoRequest(arg_4_1, arg_4_2, arg_4_3)
end

function var_0_0.reInit(arg_5_0)
	SummonNewCustomPickViewModel.instance:reInit()
end

var_0_0.instance = var_0_0.New()

return var_0_0
