module("modules.logic.survival.controller.work.SurvivalFollowTaskUpdateWork", package.seeall)

local var_0_0 = class("SurvivalFollowTaskUpdateWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = SurvivalMapModel.instance:getSceneMo()

	var_1_0.followTask:init(arg_1_0._stepMo.followTask)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnFollowTaskUpdate, var_1_0.followTask)
	arg_1_0:onDone(true)
end

return var_0_0
