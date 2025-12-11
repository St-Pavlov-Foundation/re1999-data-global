module("modules.logic.survival.controller.work.step.SurvivalSearchPanelChangeWork", package.seeall)

local var_0_0 = class("SurvivalSearchPanelChangeWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	SurvivalMapModel.instance.searchChangeItems = {
		items = arg_1_0._stepMo.items,
		panelUid = arg_1_0._stepMo.paramLong[1]
	}

	arg_1_0:onDone(true)
end

return var_0_0
