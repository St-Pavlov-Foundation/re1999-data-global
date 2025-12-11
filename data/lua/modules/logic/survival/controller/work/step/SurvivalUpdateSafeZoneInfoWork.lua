module("modules.logic.survival.controller.work.step.SurvivalUpdateSafeZoneInfoWork", package.seeall)

local var_0_0 = class("SurvivalUpdateSafeZoneInfoWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._stepMo.safeZone.shrinkInfo
	local var_1_1 = SurvivalMapModel.instance:getSceneMo()

	var_1_1.safeZone = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_2 = SurvivalShrinkInfoMo.New()

		var_1_2:init(iter_1_1)
		table.insert(var_1_1.safeZone, var_1_2)
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnShrinkInfoUpdate)
	arg_1_0:onDone(true)
end

function var_0_0.getRunOrder(arg_2_0, arg_2_1, arg_2_2)
	return SurvivalEnum.StepRunOrder.Before
end

return var_0_0
