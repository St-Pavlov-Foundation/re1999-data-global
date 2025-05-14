module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaStepBase", package.seeall)

local var_0_0 = class("TianShiNaNaStepBase", BaseWork)

function var_0_0.initData(arg_1_0, arg_1_1)
	arg_1_0._data = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	arg_2_0:onDone(true)
end

return var_0_0
