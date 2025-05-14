local var_0_0 = pureTable("Season123ItemMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.uid = 0
	arg_1_0.itemId = 0
	arg_1_0.quantity = 0
end

function var_0_0.setData(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.uid
	arg_2_0.uid = arg_2_1.uid
	arg_2_0.itemId = arg_2_1.itemId
	arg_2_0.quantity = arg_2_1.quantity
end

function var_0_0.reset(arg_3_0, arg_3_1)
	arg_3_0.id = arg_3_1.uid
	arg_3_0.uid = arg_3_1.uid
	arg_3_0.itemId = arg_3_1.itemId
	arg_3_0.quantity = arg_3_1.quantity
end

return var_0_0
