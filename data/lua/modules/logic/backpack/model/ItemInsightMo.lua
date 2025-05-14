module("modules.logic.backpack.model.ItemInsightMo", package.seeall)

local var_0_0 = pureTable("ItemInsightMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.insightId = 0
	arg_1_0.uid = 0
	arg_1_0.quantity = 0
	arg_1_0.expireTime = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.insightId = tonumber(arg_2_1.itemId)
	arg_2_0.uid = tonumber(arg_2_1.uid)
	arg_2_0.quantity = tonumber(arg_2_1.quantity)
	arg_2_0.expireTime = arg_2_1.expireTime
end

function var_0_0.reset(arg_3_0, arg_3_1)
	arg_3_0.insightId = tonumber(arg_3_1.itemId)
	arg_3_0.uid = tonumber(arg_3_1.uid)
	arg_3_0.quantity = tonumber(arg_3_1.quantity)
	arg_3_0.expireTime = arg_3_1.expireTime
end

return var_0_0
