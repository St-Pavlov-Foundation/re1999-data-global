module("modules.logic.sp01.odyssey.model.OdysseyItemListMo", package.seeall)

local var_0_0 = pureTable("OdysseyItemListMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.itemId = arg_1_1.id
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.itemMo = arg_1_1
	arg_1_0.type = arg_1_2
	arg_1_0.isEquip = arg_1_3 or false
end

return var_0_0
