module("modules.logic.backpack.model.ItemMo", package.seeall)

local var_0_0 = pureTable("ItemMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.quantity = 0
	arg_1_0.lastUseTime = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.itemId
	arg_2_0.quantity = arg_2_1.quantity
	arg_2_0.lastUseTime = arg_2_1.lastUseTime
	arg_2_0.lastUpdateTime = arg_2_1.lastUpdateTime
end

function var_0_0.initFromMaterialData(arg_3_0, arg_3_1)
	arg_3_0.id = arg_3_1.materilId
	arg_3_0.quantity = arg_3_1.quantity
	arg_3_0.lastUseTime = nil
	arg_3_0.lastUpdateTime = nil
end

return var_0_0
