module("modules.logic.survival.model.map.SurvivalFollowTaskMo", package.seeall)

local var_0_0 = pureTable("SurvivalFollowTaskMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.type = 1
	arg_1_0.moduleId = 0
	arg_1_0.taskId = 0
	arg_1_0.followUnitUid = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.type = arg_2_1.moduleId == SurvivalEnum.TaskModule.MapMainTarget and 1 or 2
	arg_2_0.moduleId = arg_2_1.moduleId
	arg_2_0.taskId = arg_2_1.taskId
	arg_2_0.followUnitUid = arg_2_1.followUnitUid
end

return var_0_0
