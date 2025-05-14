module("modules.logic.room.model.layout.RoomLayoutItemMO", package.seeall)

local var_0_0 = pureTable("RoomLayoutItemMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.id = arg_1_1
	arg_1_0.itemId = arg_1_2
	arg_1_0.itemType = arg_1_3
	arg_1_0.materialType = arg_1_3
	arg_1_0.itemNum = arg_1_4 or 1
	arg_1_0.itemIndex = 1
end

function var_0_0.getItemQuantity(arg_2_0)
	return ItemModel.instance:getItemQuantity(arg_2_0.materialType, arg_2_0.itemId) or 0
end

function var_0_0.getItemConfig(arg_3_0)
	return ItemModel.instance:getItemConfig(arg_3_0.materialType, arg_3_0.itemId)
end

function var_0_0.getNeedNum(arg_4_0)
	if arg_4_0.materialType == MaterialEnum.MaterialType.BlockPackage or arg_4_0.materialType == MaterialEnum.MaterialType.SpecialBlock then
		return 1
	end

	return arg_4_0.itemNum
end

function var_0_0.isLack(arg_5_0)
	local var_5_0 = arg_5_0:getNeedNum()

	if arg_5_0:isBuilding() then
		var_5_0 = math.max(var_5_0, arg_5_0.itemIndex)
	end

	return var_5_0 > arg_5_0:getItemQuantity()
end

function var_0_0.isBuilding(arg_6_0)
	return arg_6_0.materialType == MaterialEnum.MaterialType.Building
end

function var_0_0.isBlockPackage(arg_7_0)
	return arg_7_0.materialType == MaterialEnum.MaterialType.BlockPackage
end

function var_0_0.isSpecialBlock(arg_8_0)
	return arg_8_0.materialType == MaterialEnum.MaterialType.SpecialBlock
end

return var_0_0
