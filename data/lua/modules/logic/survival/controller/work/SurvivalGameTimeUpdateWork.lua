module("modules.logic.survival.controller.work.SurvivalGameTimeUpdateWork", package.seeall)

local var_0_0 = class("SurvivalGameTimeUpdateWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = SurvivalMapModel.instance:getSceneMo()

	var_1_0.gameTime = arg_1_0._stepMo.paramInt[1] or 0
	var_1_0.currMaxGameTime = arg_1_0._stepMo.paramInt[2] or 0
	var_1_0.addTime = var_1_0.currMaxGameTime - tonumber((SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.TotalTime)))

	local var_1_1 = arg_1_0._stepMo.paramInt[3] or SurvivalEnum.GameTimeUpdateReason.Normal

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnMapGameTimeUpdate, var_1_1)
	arg_1_0:onDone(true)
end

return var_0_0
