module("modules.logic.task.model.TaskMo", package.seeall)

local var_0_0 = pureTable("TaskMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.progress = 0
	arg_1_0.hasFinished = false
	arg_1_0.finishCount = 0
	arg_1_0.config = nil
	arg_1_0.type = 0
	arg_1_0.expiryTime = 0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.config = arg_2_2

	arg_2_0:update(arg_2_1)
end

function var_0_0.update(arg_3_0, arg_3_1)
	arg_3_0.id = arg_3_1.id
	arg_3_0.progress = arg_3_1.progress
	arg_3_0.hasFinished = arg_3_1.hasFinished
	arg_3_0.finishCount = arg_3_1.finishCount
	arg_3_0.type = arg_3_1.type
	arg_3_0.expiryTime = arg_3_1.expiryTime
end

function var_0_0.finishTask(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == arg_4_0.id then
		arg_4_0.finishCount = arg_4_2
		arg_4_0.hasFinished = true
	end
end

function var_0_0.getMaxFinishCount(arg_5_0)
	return arg_5_0.config and arg_5_0.config.maxFinishCount or 1
end

function var_0_0.isClaimed(arg_6_0)
	return arg_6_0.finishCount >= arg_6_0:getMaxFinishCount()
end

function var_0_0.isClaimable(arg_7_0)
	return not arg_7_0:isClaimed() and arg_7_0.hasFinished
end

function var_0_0.isFinished(arg_8_0)
	return arg_8_0.hasFinished or arg_8_0:isClaimed()
end

function var_0_0.isUnfinished(arg_9_0)
	return not arg_9_0:isClaimed() and not arg_9_0:isClaimable()
end

return var_0_0
