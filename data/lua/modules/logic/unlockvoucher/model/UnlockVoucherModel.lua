module("modules.logic.unlockvoucher.model.UnlockVoucherModel", package.seeall)

local var_0_0 = class("UnlockVoucherModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.getVoucher(arg_3_0, arg_3_1)
	return arg_3_0:getById(arg_3_1)
end

function var_0_0.setVoucherInfos(arg_4_0, arg_4_1)
	arg_4_0:clear()

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0:addVoucher(iter_4_1)
	end
end

function var_0_0.addVoucher(arg_5_0, arg_5_1)
	local var_5_0 = UnlockVoucherMO.New()

	var_5_0:init(arg_5_1)
	arg_5_0:addAtLast(var_5_0)
end

function var_0_0.updateVoucherInfos(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_0 = arg_6_0:getVoucher(iter_6_1.voucherId)

		if var_6_0 then
			var_6_0:reset(iter_6_1)
		else
			arg_6_0:addVoucher(iter_6_1)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
