module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaMapCollapseStep", package.seeall)

local var_0_0 = class("TianShiNaNaMapCollapseStep", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.CheckMapCollapse)
	arg_1_0:onDone(true)
end

return var_0_0
