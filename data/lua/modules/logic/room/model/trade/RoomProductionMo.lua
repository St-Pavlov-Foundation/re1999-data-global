module("modules.logic.room.model.trade.RoomProductionMo", package.seeall)

local var_0_0 = class("RoomProductionMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.productionId = nil
	arg_1_0.quantity = nil
end

function var_0_0.initMo(arg_2_0, arg_2_1)
	arg_2_0.productionId = arg_2_1.productionId
	arg_2_0.quantity = arg_2_1.quantity or 0
	arg_2_0.co = ManufactureConfig.instance:getManufactureItemCfg(arg_2_0.productionId)
end

function var_0_0.getCurQuantity(arg_3_0)
	return ManufactureModel.instance:getManufactureItemCount(arg_3_0.productionId, false)
end

function var_0_0.isEnoughCount(arg_4_0)
	local var_4_0 = arg_4_0:getCurQuantity() or 0

	return var_4_0 >= arg_4_0.quantity, var_4_0
end

function var_0_0.getQuantityStr(arg_5_0)
	local var_5_0 = "#a63838"
	local var_5_1 = luaLang("room_trade_progress")
	local var_5_2, var_5_3 = arg_5_0:isEnoughCount()

	if var_5_2 then
		var_5_0 = "#220F04"
	elseif not arg_5_0:isPlacedProduceBuilding() or arg_5_0:checkProduceBuildingLevel() then
		var_5_0 = "#6F6F6F"
		var_5_1 = luaLang("room_trade_progress_wrong")
	end

	return GameUtil.getSubPlaceholderLuaLangThreeParam(var_5_1, var_5_0, GameUtil.numberDisplay(var_5_3), GameUtil.numberDisplay(arg_5_0.quantity))
end

function var_0_0.isPlacedProduceBuilding(arg_6_0)
	return (ManufactureController.instance:checkPlaceProduceBuilding(arg_6_0.productionId))
end

function var_0_0.checkProduceBuildingLevel(arg_7_0)
	local var_7_0, var_7_1 = ManufactureController.instance:checkProduceBuildingLevel(arg_7_0.productionId)

	return var_7_0, var_7_1
end

function var_0_0.getItem(arg_8_0)
	local var_8_0 = MaterialEnum.MaterialType.Item

	if arg_8_0.co then
		local var_8_1 = arg_8_0.co.itemId

		return var_8_0, var_8_1
	end
end

function var_0_0.getOrderPrice(arg_9_0)
	return arg_9_0:getOneOrderPrice() * arg_9_0.quantity
end

function var_0_0.getOneOrderPrice(arg_10_0)
	local var_10_0 = ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.OrderPriceMul) or 1

	return arg_10_0.co and arg_10_0.co.orderPrice * var_10_0 or 0
end

return var_0_0
