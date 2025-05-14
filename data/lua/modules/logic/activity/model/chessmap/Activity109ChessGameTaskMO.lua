module("modules.logic.activity.model.chessmap.Activity109ChessGameTaskMO", package.seeall)

local var_0_0 = pureTable("Activity109ChessGameTaskMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.config = arg_1_1.config
	arg_1_0.taskMO = arg_1_1
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

function var_0_0.alreadyGotReward(arg_5_0)
	if arg_5_0.taskMO then
		return arg_5_0.taskMO.finishCount > 0
	end

	return false
end

return var_0_0
