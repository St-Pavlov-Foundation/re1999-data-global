module("modules.logic.versionactivity.model.mo.VersionActivity112TaskMO", package.seeall)

local var_0_0 = pureTable("VersionActivity112TaskMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.actId = arg_1_1.activityId
	arg_1_0.id = arg_1_1.taskId
	arg_1_0.config = arg_1_1
	arg_1_0.progress = 0
	arg_1_0.hasGetBonus = false
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.progress = arg_2_1.progress
	arg_2_0.hasGetBonus = arg_2_1.hasGetBonus
end

function var_0_0.canGetBonus(arg_3_0)
	return arg_3_0.hasGetBonus == false and arg_3_0.config.maxProgress <= arg_3_0.progress
end

return var_0_0
