module("modules.logic.survival.controller.work.step.SurvivalUpdatePointsWork", package.seeall)

local var_0_0 = class("SurvivalUpdatePointsWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	SurvivalMapModel.instance:addExploredPoint(arg_1_0._stepMo.hex)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapExploredPointUpdate)
	arg_1_0:onDone(true)
end

function var_0_0.getRunOrder(arg_2_0, arg_2_1, arg_2_2)
	return SurvivalEnum.StepRunOrder.Before
end

return var_0_0
