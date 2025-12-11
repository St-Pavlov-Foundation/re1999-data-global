module("modules.logic.survival.controller.work.step.SurvivalUpdateExPointsWork", package.seeall)

local var_0_0 = class("SurvivalUpdateExPointsWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	SurvivalMapModel.instance:addExploredPoint2(arg_1_0._stepMo.hex)
	arg_1_0:onDone(true)
end

function var_0_0.getRunOrder(arg_2_0, arg_2_1, arg_2_2)
	return SurvivalEnum.StepRunOrder.Before
end

return var_0_0
