module("modules.logic.survival.model.shelter.SurvivalTaskMo", package.seeall)

local var_0_0 = pureTable("SurvivalTaskMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1.id
	arg_1_0.status = arg_1_1.status
	arg_1_0.progress = arg_1_1.progress
	arg_1_0.moduleId = arg_1_2
	arg_1_0.co = SurvivalConfig.instance:getTaskCo(arg_1_0.moduleId, arg_1_0.id)
end

function var_0_0.Create(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.New()

	var_2_0.id = arg_2_1
	var_2_0.moduleId = arg_2_0
	var_2_0.status = SurvivalEnum.TaskStatus.Doing
	var_2_0.progress = 0
	var_2_0.co = SurvivalConfig.instance:getTaskCo(arg_2_0, arg_2_1)

	return var_2_0
end

function var_0_0.isCangetReward(arg_3_0)
	return arg_3_0.status == SurvivalEnum.TaskStatus.Done
end

function var_0_0.isFinish(arg_4_0)
	return arg_4_0.status == SurvivalEnum.TaskStatus.Finish or arg_4_0.status == SurvivalEnum.TaskStatus.Fail
end

function var_0_0.isUnFinish(arg_5_0)
	return arg_5_0.status == SurvivalEnum.TaskStatus.Doing
end

function var_0_0.isFail(arg_6_0)
	return arg_6_0.status == SurvivalEnum.TaskStatus.Fail
end

function var_0_0.getName(arg_7_0)
	return arg_7_0.co and arg_7_0.co.desc
end

function var_0_0.getDesc(arg_8_0)
	return arg_8_0.co and arg_8_0.co.desc2
end

function var_0_0.setTaskFinish(arg_9_0)
	arg_9_0.status = SurvivalEnum.TaskStatus.Finish
end

return var_0_0
