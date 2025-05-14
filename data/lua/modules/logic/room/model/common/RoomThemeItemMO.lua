module("modules.logic.room.model.common.RoomThemeItemMO", package.seeall)

local var_0_0 = pureTable("RoomThemeItemMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_1
	arg_1_0.itemId = arg_1_1
	arg_1_0.itemNum = arg_1_2 or 0
	arg_1_0.materialType = arg_1_3
end

function var_0_0.getItemQuantity(arg_2_0)
	return ItemModel.instance:getItemQuantity(arg_2_0.materialType, arg_2_0.id) or 0
end

function var_0_0.getItemConfig(arg_3_0)
	return ItemModel.instance:getItemConfig(arg_3_0.materialType, arg_3_0.id)
end

return var_0_0
