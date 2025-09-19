module("modules.logic.survival.controller.work.SurvivalGetTalentWork", package.seeall)

local var_0_0 = class("SurvivalGetTalentWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0:onDone(true)
end

function var_0_0._onCloseView(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.SurvivalTalentGetView then
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

return var_0_0
