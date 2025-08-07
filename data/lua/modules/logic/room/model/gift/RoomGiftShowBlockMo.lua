module("modules.logic.room.model.gift.RoomGiftShowBlockMo", package.seeall)

local var_0_0 = pureTable("RoomGiftShowBlockMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.packageId = arg_1_1
	arg_1_0.config = RoomConfig.instance:getBlockPackageConfig(arg_1_1)
	arg_1_0.rare = arg_1_0.config.rare or 0
	arg_1_0.subType = arg_1_2
	arg_1_0.itemCofig = ItemModel.instance:getItemConfig(arg_1_2, arg_1_1)
end

function var_0_0.getBlockNum(arg_2_0)
	local var_2_0 = RoomConfig.instance:getBlockListByPackageId(arg_2_0.id)

	return var_2_0 and #var_2_0 or 0
end

function var_0_0.isCollect(arg_3_0)
	return ItemModel.instance:getItemQuantity(arg_3_0.subType, arg_3_0.id) > 0
end

return var_0_0
