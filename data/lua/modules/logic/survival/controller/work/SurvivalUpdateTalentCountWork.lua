module("modules.logic.survival.controller.work.SurvivalUpdateTalentCountWork", package.seeall)

local var_0_0 = class("SurvivalUpdateTalentCountWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	SurvivalMapModel.instance:getSceneMo().gainTalentNum = arg_1_0._stepMo.paramInt[1] or 0

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnTalentCountUpdate)

	SurvivalMapModel.instance.isGetTalent = true

	arg_1_0:onDone(true)
end

return var_0_0
