module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaHideStep", package.seeall)

local var_0_0 = class("TianShiNaNaHideStep", TianShiNaNaStepBase)

function var_0_0.onStart(arg_1_0, arg_1_1)
	TianShiNaNaModel.instance:removeUnit(arg_1_0._data.id)
	arg_1_0:onDone(true)
end

return var_0_0
