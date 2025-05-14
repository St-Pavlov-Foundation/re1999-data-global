module("modules.logic.signin.model.SignInMonthCardHistoryMo", package.seeall)

local var_0_0 = pureTable("SignInMonthCardHistoryMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.startTime = 0
	arg_1_0.endTime = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.startTime = arg_2_1.startTime
	arg_2_0.endTime = arg_2_1.endTime
end

return var_0_0
