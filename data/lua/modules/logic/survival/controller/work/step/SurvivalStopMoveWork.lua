module("modules.logic.survival.controller.work.step.SurvivalStopMoveWork", package.seeall)

local var_0_0 = class("SurvivalStopMoveWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	SurvivalMapModel.instance:setMoveToTarget()
	SurvivalMapModel.instance:setShowTarget()
	arg_1_0:onDone(true)
end

return var_0_0
