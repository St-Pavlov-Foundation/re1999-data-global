module("modules.logic.survival.controller.work.step.SurvivalDelTalentWork", package.seeall)

local var_0_0 = class("SurvivalDelTalentWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = SurvivalShelterModel.instance:getWeekInfo()

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._stepMo.paramInt) do
		tabletool.removeValue(var_1_0.talents, iter_1_1)
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnTalentChange)
	arg_1_0:onDone(true)
end

return var_0_0
