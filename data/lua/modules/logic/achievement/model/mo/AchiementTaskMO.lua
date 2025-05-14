module("modules.logic.achievement.model.mo.AchiementTaskMO", package.seeall)

local var_0_0 = pureTable("AchiementTaskMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.cfg = arg_1_1
	arg_1_0.id = arg_1_1.id
end

function var_0_0.updateByServerData(arg_2_0, arg_2_1)
	arg_2_0.progress = arg_2_1.progress
	arg_2_0.hasFinished = arg_2_1.hasFinish
	arg_2_0.isNew = arg_2_1.new
	arg_2_0.finishTime = arg_2_1.finishTime
end

return var_0_0
