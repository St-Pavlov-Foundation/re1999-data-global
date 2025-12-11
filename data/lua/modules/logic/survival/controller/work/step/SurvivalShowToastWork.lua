module("modules.logic.survival.controller.work.step.SurvivalShowToastWork", package.seeall)

local var_0_0 = class("SurvivalShowToastWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._stepMo.paramInt[1] or 0

	ToastController.instance:showToast(var_1_0)
	arg_1_0:onDone(true)
end

function var_0_0.getRunOrder(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	return SurvivalEnum.StepRunOrder.Before
end

return var_0_0
