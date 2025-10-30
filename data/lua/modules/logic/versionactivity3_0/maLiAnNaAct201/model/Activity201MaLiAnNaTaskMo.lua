module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.Activity201MaLiAnNaTaskMo", package.seeall)

local var_0_0 = pureTable("Activity201MaLiAnNaTaskMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1.id
	arg_1_0.activityId = arg_1_1.activityId
	arg_1_0.config = arg_1_1
	arg_1_0.taskMO = arg_1_2
	arg_1_0.preFinish = false
end

function var_0_0.updateMO(arg_2_0, arg_2_1)
	arg_2_0.taskMO = arg_2_1
end

function var_0_0.isLock(arg_3_0)
	return arg_3_0.taskMO == nil
end

function var_0_0.isFinished(arg_4_0)
	if arg_4_0.preFinish then
		return true
	end

	if arg_4_0.taskMO then
		return arg_4_0.taskMO.finishCount > 0
	end

	return false
end

function var_0_0.getMaxProgress(arg_5_0)
	return arg_5_0.config and arg_5_0.config.maxProgress or 0
end

function var_0_0.getFinishProgress(arg_6_0)
	return arg_6_0.taskMO and arg_6_0.taskMO.progress or 0
end

function var_0_0.alreadyGotReward(arg_7_0)
	local var_7_0 = arg_7_0:getMaxProgress()

	if var_7_0 > 0 and arg_7_0.taskMO then
		return var_7_0 <= arg_7_0.taskMO.progress and arg_7_0.taskMO.finishCount == 0
	end

	return false
end

return var_0_0
