module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaGuideStep", package.seeall)

local var_0_0 = class("TianShiNaNaGuideStep", TianShiNaNaStepBase)

function var_0_0.onStart(arg_1_0, arg_1_1)
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.OnGuideTrigger, tostring(arg_1_0._data.guideId))
	arg_1_0:onDone(true)
end

return var_0_0
