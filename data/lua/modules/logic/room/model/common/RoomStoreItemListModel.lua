module("modules.logic.room.model.common.RoomStoreItemListModel", package.seeall)

local var_0_0 = class("RoomStoreItemListModel", ListScrollModel)

function var_0_0.setStoreGoodsMO(arg_1_0, arg_1_1)
	arg_1_0.storeGoodsMO = arg_1_1

	local var_1_0 = arg_1_1.config
	local var_1_1, var_1_2 = arg_1_1:getAllCostInfo()
	local var_1_3 = {
		var_1_1,
		var_1_2
	}

	arg_1_0._costsId = 1

	local var_1_4 = GameUtil.splitString2(var_1_0.product, true)
	local var_1_5 = string.splitToNumber(var_1_0.reduction, "#")
	local var_1_6 = {}
	local var_1_7 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_5) do
		local var_1_8 = StoreConfig.instance:getGoodsConfig(iter_1_1)
		local var_1_9 = GameUtil.splitString2(var_1_8.cost, true)[1]
		local var_1_10 = GameUtil.splitString2(var_1_8.cost2, true)[1]
		local var_1_11 = GameUtil.splitString2(var_1_8.product, true)[1]
		local var_1_12 = var_1_11[1]
		local var_1_13 = var_1_11[2]

		var_1_7[var_1_12] = var_1_7[var_1_12] or {}
		var_1_7[var_1_12][var_1_13] = {
			var_1_9[3],
			var_1_10[3]
		}
	end

	for iter_1_2 = 1, #var_1_4 do
		local var_1_14 = var_1_4[iter_1_2]
		local var_1_15 = RoomStoreItemMO.New()
		local var_1_16 = {}

		var_1_15:init(var_1_14[2], var_1_14[1], var_1_14[3], arg_1_0._costId, arg_1_1)

		for iter_1_3, iter_1_4 in ipairs(var_1_3) do
			if iter_1_4 then
				local var_1_17 = iter_1_4[1]
				local var_1_18 = var_1_17[3]

				if var_1_7[var_1_14[1]] and var_1_7[var_1_14[1]][var_1_14[2]] then
					var_1_18 = var_1_7[var_1_14[1]][var_1_14[2]][iter_1_3]
				end

				var_1_15:addCost(iter_1_3, var_1_17[2], var_1_17[1], var_1_18)
			end
		end

		table.insert(var_1_6, var_1_15)
	end

	arg_1_0:setList(var_1_6)
	arg_1_0:onModelUpdate()
end

function var_0_0.getCostId(arg_2_0)
	return arg_2_0._costsId or 1
end

function var_0_0.setCostId(arg_3_0, arg_3_1)
	if arg_3_1 == 1 or arg_3_1 == 2 then
		arg_3_0._costsId = arg_3_1

		arg_3_0:onModelUpdate()
	end
end

function var_0_0.getTotalPriceByCostId(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getList()

	arg_4_1 = arg_4_1 or arg_4_0._costsId

	local var_4_1 = 0

	for iter_4_0 = 1, #var_4_0 do
		var_4_1 = var_4_1 + var_4_0[iter_4_0]:getTotalPriceByCostId(arg_4_1)
	end

	return var_4_1
end

function var_0_0.getRoomStoreItemMOHasTheme(arg_5_0)
	local var_5_0 = arg_5_0:getList()

	for iter_5_0 = 1, #var_5_0 do
		local var_5_1 = var_5_0[iter_5_0]

		if var_5_1.themeId then
			return var_5_1
		end
	end

	return nil
end

function var_0_0.setIsSelectCurrency(arg_6_0, arg_6_1)
	arg_6_0.isSelectCurrency = arg_6_1
end

function var_0_0.getIsSelectCurrency(arg_7_0)
	return arg_7_0.isSelectCurrency
end

var_0_0.instance = var_0_0.New()

return var_0_0
