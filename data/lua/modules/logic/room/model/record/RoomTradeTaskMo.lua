module("modules.logic.room.model.record.RoomTradeTaskMo", package.seeall)

local var_0_0 = class("RoomTradeTaskMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = nil
	arg_1_0.progress = nil
	arg_1_0.hasFinish = nil
	arg_1_0.new = nil
	arg_1_0.finishTime = nil
	arg_1_0.co = nil
end

function var_0_0.initMo(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1.id
	arg_2_0.progress = arg_2_1.progress
	arg_2_0.hasFinish = arg_2_1.hasFinish
	arg_2_0.new = arg_2_1.new
	arg_2_0.finishTime = arg_2_1.finishTime
	arg_2_0.co = arg_2_2
end

function var_0_0.setNew(arg_3_0, arg_3_1)
	arg_3_0.new = false
end

function var_0_0.isFinish(arg_4_0)
	if arg_4_0.co then
		return arg_4_0.progress >= arg_4_0.co.maxProgress
	end
end

function var_0_0.isNormalTask(arg_5_0)
	return true
end

return var_0_0
