module("modules.logic.versionactivity1_3.chess.model.Activity122TaskMO", package.seeall)

local var_0_0 = pureTable("Activity122TaskMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1.id
	arg_1_0.config = arg_1_1
	arg_1_0.taskMO = arg_1_2
end

function var_0_0.updateMO(arg_2_0, arg_2_1)
	arg_2_0.taskMO = arg_2_1
end

function var_0_0.isLock(arg_3_0)
	return arg_3_0.taskMO == nil
end

function var_0_0.isFinished(arg_4_0)
	if arg_4_0.taskMO then
		return arg_4_0.taskMO.hasFinished
	end

	return false
end

function var_0_0.getProgress(arg_5_0)
	return arg_5_0.taskMO and arg_5_0.taskMO.progress or 0
end

function var_0_0.getMaxProgress(arg_6_0)
	return arg_6_0.config and arg_6_0.config.maxProgress or 0
end

function var_0_0.getFinishProgress(arg_7_0)
	return arg_7_0.taskMO and arg_7_0.taskMO.finishCount or 0
end

function var_0_0.alreadyGotReward(arg_8_0)
	return arg_8_0:getFinishProgress() > 0
end

function var_0_0.haveRewardToGet(arg_9_0)
	return arg_9_0:getFinishProgress() == 0 and arg_9_0:isFinished()
end

return var_0_0
