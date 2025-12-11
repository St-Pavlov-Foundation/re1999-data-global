module("modules.logic.survival.controller.work.step.SurvivalMagmaStatusUpdateWork", package.seeall)

local var_0_0 = class("SurvivalMagmaStatusUpdateWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	SurvivalMapModel.instance:getSceneMo().sceneProp.magmaStatus = arg_1_0._stepMo.paramInt[1] or SurvivalEnum.MagmaStatus.Normal

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMagmaStatusUpdate)
	arg_1_0:onDone(true)
end

return var_0_0
