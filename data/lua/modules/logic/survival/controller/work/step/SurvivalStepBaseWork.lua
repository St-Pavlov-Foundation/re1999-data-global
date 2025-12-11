module("modules.logic.survival.controller.work.step.SurvivalStepBaseWork", package.seeall)

local var_0_0 = class("SurvivalStepBaseWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._stepMo = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	arg_2_0:onDone(true)
end

function var_0_0.getRunOrder(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	return SurvivalEnum.StepRunOrder.After
end

return var_0_0
