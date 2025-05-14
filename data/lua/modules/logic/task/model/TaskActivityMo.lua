module("modules.logic.task.model.TaskActivityMo", package.seeall)

local var_0_0 = pureTable("TaskActivityMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.typeId = 0
	arg_1_0.defineId = 0
	arg_1_0.value = 0
	arg_1_0.gainValue = 0
	arg_1_0.expiryTime = 0
	arg_1_0.config = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:update(arg_2_1)

	arg_2_0.config = arg_2_2
end

function var_0_0.update(arg_3_0, arg_3_1)
	arg_3_0.typeId = arg_3_1.typeId
	arg_3_0.defineId = arg_3_1.defineId
	arg_3_0.value = arg_3_1.value
	arg_3_0.gainValue = arg_3_1.gainValue
	arg_3_0.expiryTime = arg_3_1.expiryTime
end

function var_0_0.getbonus(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == arg_4_0.typeId then
		arg_4_0.defineId = arg_4_2
		arg_4_0.gainValue = arg_4_0.gainValue + arg_4_0.config.needActivity
	end
end

return var_0_0
