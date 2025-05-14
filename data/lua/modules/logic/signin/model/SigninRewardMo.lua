module("modules.logic.signin.model.SigninRewardMo", package.seeall)

local var_0_0 = pureTable("SigninRewardMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.materilType = nil
	arg_1_0.materilId = nil
	arg_1_0.quantity = nil
	arg_1_0.uid = nil
	arg_1_0.isGold = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.materilType = arg_2_1.materilType
	arg_2_0.materilId = arg_2_1.materilId
	arg_2_0.quantity = arg_2_1.quantity
	arg_2_0.uid = arg_2_1.uid
end

function var_0_0.initValue(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0.materilType = arg_3_1
	arg_3_0.materilId = arg_3_2
	arg_3_0.quantity = arg_3_3
	arg_3_0.uid = arg_3_4
	arg_3_0.isGold = arg_3_5
end

return var_0_0
