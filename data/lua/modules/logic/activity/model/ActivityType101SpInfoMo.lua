module("modules.logic.activity.model.ActivityType101SpInfoMo", package.seeall)

local var_0_0 = pureTable("ActivityType101SpInfoMo")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.state = var_0_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.state = arg_2_1.state
end

function var_0_0.isNotCompleted(arg_3_0)
	return arg_3_0.state == var_0_1
end

function var_0_0.isAvailable(arg_4_0)
	return arg_4_0.state == var_0_2
end

function var_0_0.isReceived(arg_5_0)
	return arg_5_0.state == var_0_3
end

function var_0_0.isNone(arg_6_0)
	return arg_6_0.state == var_0_1
end

function var_0_0.setState_Received(arg_7_0)
	arg_7_0.state = var_0_3
end

return var_0_0
