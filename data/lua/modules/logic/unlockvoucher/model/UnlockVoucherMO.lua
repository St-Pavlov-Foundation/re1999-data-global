module("modules.logic.unlockvoucher.model.UnlockVoucherMO", package.seeall)

local var_0_0 = pureTable("UnlockVoucherMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.getTime = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = tonumber(arg_2_1.voucherId)
	arg_2_0.getTime = arg_2_1.getTime
end

function var_0_0.reset(arg_3_0, arg_3_1)
	arg_3_0:init(arg_3_1)
end

return var_0_0
