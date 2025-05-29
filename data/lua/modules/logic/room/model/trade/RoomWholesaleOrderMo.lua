module("modules.logic.room.model.trade.RoomWholesaleOrderMo", package.seeall)

local var_0_0 = class("RoomWholesaleOrderMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.orderId = nil
	arg_1_0.goodId = nil
	arg_1_0.todaySoldCount = nil
	arg_1_0.co = nil
end

function var_0_0.initMo(arg_2_0, arg_2_1)
	arg_2_0.orderId = arg_2_1.orderId
	arg_2_0.goodId = arg_2_1.goodId
	arg_2_0.todaySoldCount = arg_2_1.todaySoldCount
	arg_2_0.co = ManufactureConfig.instance:getManufactureItemCfg(arg_2_0.goodId)

	local var_2_0 = arg_2_0:getMaxCount()

	arg_2_0.soldCount = RoomTradeModel.instance:isMaxWeelyOrder() and 0 or math.min(1, var_2_0)
	arg_2_0.itemCo = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, arg_2_0.co.itemId)
end

function var_0_0.refreshTodaySoldCount(arg_3_0, arg_3_1)
	arg_3_0.todaySoldCount = arg_3_1
end

function var_0_0.getGoodsName(arg_4_0)
	return arg_4_0.itemCo and arg_4_0.itemCo.name
end

function var_0_0.getGoodsIcon(arg_5_0)
	return arg_5_0.itemCo and arg_5_0.itemCo.icon
end

function var_0_0.getMaxCount(arg_6_0)
	return ManufactureModel.instance:getManufactureItemCount(arg_6_0.goodId, false)
end

function var_0_0.getMaxCountStr(arg_7_0)
	local var_7_0 = arg_7_0:getMaxCount()

	return GameUtil.numberDisplay(var_7_0)
end

function var_0_0.getTodaySoldCount(arg_8_0)
	return arg_8_0.todaySoldCount
end

function var_0_0.getTodaySoldCountStr(arg_9_0)
	return GameUtil.numberDisplay(arg_9_0.todaySoldCount)
end

function var_0_0.getItem(arg_10_0)
	local var_10_0 = ManufactureConfig.instance:getManufactureItemCfg(arg_10_0.goodId)
	local var_10_1 = MaterialEnum.MaterialType.Item

	if var_10_0 then
		local var_10_2 = var_10_0.itemId

		return var_10_1, var_10_2
	end
end

function var_0_0.getUnitPrice(arg_11_0)
	local var_11_0 = MaterialEnum.MaterialType.Currency
	local var_11_1 = CurrencyEnum.CurrencyType.RoomTrade
	local var_11_2 = arg_11_0.co.wholesalePrice

	return var_11_0, var_11_1, var_11_2
end

function var_0_0.getPriceRatio(arg_12_0)
	local var_12_0 = arg_12_0.co.orderPrice
	local var_12_1 = arg_12_0.co.wholesalePrice

	return -math.floor((var_12_0 - var_12_1) / var_12_0 * 100 + 0.5)
end

function var_0_0.getSoldCount(arg_13_0)
	local var_13_0 = arg_13_0:getMaxCount()

	return (math.min(var_13_0, arg_13_0.soldCount))
end

function var_0_0.getSoldCountStr(arg_14_0)
	local var_14_0 = arg_14_0:getSoldCount()

	return GameUtil.numberDisplay(var_14_0)
end

function var_0_0.addSoldCount(arg_15_0, arg_15_1)
	arg_15_0.soldCount = arg_15_0.soldCount + (arg_15_1 or 1)
	arg_15_0.soldCount = arg_15_0:getSoldCount()
end

function var_0_0.reduceSoldCount(arg_16_0, arg_16_1)
	arg_16_0.soldCount = arg_16_0.soldCount - (arg_16_1 or 1)
	arg_16_0.soldCount = math.max(0, arg_16_0.soldCount)
end

function var_0_0.setSoldCount(arg_17_0, arg_17_1)
	arg_17_1 = arg_17_1 or 0

	local var_17_0 = arg_17_0:getMaxCount()

	arg_17_0.soldCount = GameUtil.clamp(arg_17_1, 0, var_17_0)
end

return var_0_0
