module("modules.logic.survival.controller.work.step.SurvivalFollowTaskUpdateWork", package.seeall)

local var_0_0 = class("SurvivalFollowTaskUpdateWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = SurvivalMapModel.instance:getSceneMo()
	local var_1_1

	if arg_1_0._stepMo.followTask.moduleId == SurvivalEnum.TaskModule.MapMainTarget then
		var_1_1 = var_1_0.mainTask
	elseif arg_1_0._stepMo.followTask.moduleId == SurvivalEnum.TaskModule.NormalTask then
		var_1_1 = var_1_0.followTask
	end

	if var_1_1 then
		var_1_1:init(arg_1_0._stepMo.followTask)
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnFollowTaskUpdate, var_1_1)
	end

	arg_1_0:onDone(true)
end

return var_0_0
