module("modules.logic.survival.controller.work.step.SurvivalCircleShrinkFinishWork", package.seeall)

local var_0_0 = class("SurvivalCircleShrinkFinishWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._stepMo.paramInt[1] or 0
	local var_1_1 = SurvivalMapModel.instance:getSceneMo()

	for iter_1_0, iter_1_1 in ipairs(var_1_1.safeZone) do
		if iter_1_1.round == var_1_0 then
			table.remove(var_1_1.safeZone, iter_1_0)

			break
		end
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShrinkInfoUpdate)
	arg_1_0:onDone(true)
end

function var_0_0.getRunOrder(arg_2_0, arg_2_1, arg_2_2)
	return SurvivalEnum.StepRunOrder.Before
end

return var_0_0
