module("modules.logic.signin.model.SignInHeroBirthdayInfoMo", package.seeall)

local var_0_0 = pureTable("SignInHeroBirthdayInfoMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.heroId = 0
	arg_1_0.birthdayCount = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.heroId = arg_2_1.heroId
	arg_2_0.birthdayCount = arg_2_1.birthdayCount
end

function var_0_0.reset(arg_3_0, arg_3_1)
	arg_3_0.heroId = arg_3_1.heroId
	arg_3_0.birthdayCount = arg_3_1.birthdayCount
end

function var_0_0.addBirthdayCount(arg_4_0)
	arg_4_0.birthdayCount = arg_4_0.birthdayCount + 1
end

return var_0_0
