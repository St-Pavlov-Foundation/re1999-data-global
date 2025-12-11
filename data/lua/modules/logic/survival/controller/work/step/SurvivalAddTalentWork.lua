module("modules.logic.survival.controller.work.step.SurvivalAddTalentWork", package.seeall)

local var_0_0 = class("SurvivalAddTalentWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = SurvivalShelterModel.instance:getWeekInfo()

	tabletool.addValues(var_1_0.talents, arg_1_0._stepMo.paramInt)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnTalentChange)
	arg_1_0:onDone(true)
end

return var_0_0
