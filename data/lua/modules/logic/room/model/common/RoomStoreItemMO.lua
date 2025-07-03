module("modules.logic.room.model.common.RoomStoreItemMO", package.seeall)

local var_0_0 = pureTable("RoomStoreItemMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.id = arg_1_1
	arg_1_0.itemId = arg_1_1
	arg_1_0.itemNum = arg_1_3 or 0
	arg_1_0.materialType = arg_1_2
	arg_1_0._costId = arg_1_4
	arg_1_0.belongStoreId = arg_1_5.belongStoreId
	arg_1_0.storeGoodsMO = arg_1_5
	arg_1_0.themeId = RoomConfig.instance:getThemeIdByItem(arg_1_1, arg_1_2)
end

function var_0_0.getNeedNum(arg_2_0)
	if arg_2_0.materialType == MaterialEnum.MaterialType.BlockPackage or arg_2_0.materialType == MaterialEnum.MaterialType.SpecialBlock then
		return 1
	end

	local var_2_0 = arg_2_0:getItemConfig()

	if var_2_0 and var_2_0.numLimit and var_2_0.numLimit > 0 then
		return var_2_0.numLimit
	end

	return 9999
end

function var_0_0.getItemQuantity(arg_3_0)
	return ItemModel.instance:getItemQuantity(arg_3_0.materialType, arg_3_0.id) or 0
end

function var_0_0.getItemConfig(arg_4_0)
	return ItemModel.instance:getItemConfig(arg_4_0.materialType, arg_4_0.id)
end

function var_0_0.getTotalPriceByCostId(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getCostById(arg_5_1)

	if not var_5_0 then
		logNormal(string.format("RoomStoreItemMO costId:%s itemId:%s", arg_5_1, arg_5_0.id))

		return 0
	end

	return arg_5_0:getCanBuyNum() * var_5_0.price
end

function var_0_0.getCanBuyNum(arg_6_0)
	local var_6_0 = arg_6_0:getNeedNum()
	local var_6_1 = arg_6_0:getItemQuantity()

	if var_6_0 <= var_6_1 then
		return 0
	end

	return (math.min(var_6_0 - var_6_1, arg_6_0.itemNum))
end

function var_0_0.addCost(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0._costs = arg_7_0._costs or {}
	arg_7_0._costs[arg_7_1] = {
		costId = arg_7_1,
		itemId = arg_7_2,
		itemType = arg_7_3,
		price = arg_7_4
	}
end

function var_0_0.getCostById(arg_8_0, arg_8_1)
	return arg_8_0._costs and arg_8_0._costs[arg_8_1]
end

function var_0_0.getStoreGoodsMO(arg_9_0)
	return arg_9_0.storeGoodsMO
end

function var_0_0.checkShowTicket(arg_10_0)
	if arg_10_0.storeGoodsMO.belongStoreId == StoreEnum.StoreId.OldRoomStore or arg_10_0.storeGoodsMO.belongStoreId == StoreEnum.StoreId.NewRoomStore then
		if arg_10_0.materialType ~= MaterialEnum.MaterialType.BlockPackage and arg_10_0.materialType ~= MaterialEnum.MaterialType.Building then
			return false
		end

		if not string.nilorempty(arg_10_0.storeGoodsMO.config.nameEn) then
			return
		end

		if arg_10_0:getItemConfig().rare <= 3 then
			if ItemModel.instance:getItemCount(StoreEnum.NormalRoomTicket) > 0 or ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
				return true
			end
		elseif arg_10_0:getItemConfig().rare <= 5 and ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
			return true
		end
	end

	return false
end

function var_0_0.getTicketId(arg_11_0)
	if arg_11_0:getItemConfig().rare <= 3 then
		if ItemModel.instance:getItemCount(StoreEnum.NormalRoomTicket) > 0 then
			return StoreEnum.NormalRoomTicket
		elseif ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
			return StoreEnum.TopRoomTicket
		end
	elseif arg_11_0:getItemConfig().rare <= 5 and ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
		return StoreEnum.TopRoomTicket
	end
end

return var_0_0
