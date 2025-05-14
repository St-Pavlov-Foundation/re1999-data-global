module("modules.logic.signin.model.SignInHistoryInfoMo", package.seeall)

local var_0_0 = pureTable("SignInHistoryInfoMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.month = 1
	arg_1_0.hasSignInDays = {}
	arg_1_0.hasMonthCardDays = {}
	arg_1_0.birthdayHeroIds = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.month = arg_2_1.month
	arg_2_0.hasSignInDays = arg_2_0:_getListInfo(arg_2_1.hasSignInDays)
	arg_2_0.hasMonthCardDays = arg_2_0:_getListInfo(arg_2_1.hasMonthCardDays)
	arg_2_0.birthdayHeroIds = arg_2_0:_getListInfo(arg_2_1.birthdayHeroIds)
end

function var_0_0._getListInfo(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {}
	local var_3_1 = arg_3_1 and #arg_3_1 or 0

	for iter_3_0 = 1, var_3_1 do
		local var_3_2 = arg_3_1[iter_3_0]

		if arg_3_2 then
			var_3_2 = arg_3_2.New()

			var_3_2:init(arg_3_1[iter_3_0])
		end

		table.insert(var_3_0, var_3_2)
	end

	return var_3_0
end

return var_0_0
