module("modules.logic.survival.controller.work.step.SurvivalCircleUpdateWork", package.seeall)

local var_0_0 = class("SurvivalCircleUpdateWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	SurvivalMapModel.instance:getSceneMo().circle = arg_1_0._stepMo.paramInt[1] or 0

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapCircleUpdate)
	SurvivalMapHelper.instance:getSceneFogComp():setRainDis()
	arg_1_0:onDone(true)
end

function var_0_0.getRunOrder(arg_2_0, arg_2_1, arg_2_2)
	return SurvivalEnum.StepRunOrder.Before
end

return var_0_0
