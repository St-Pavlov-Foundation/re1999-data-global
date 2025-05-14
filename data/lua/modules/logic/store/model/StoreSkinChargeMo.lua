module("modules.logic.store.model.StoreSkinChargeMo", package.seeall)

local var_0_0 = pureTable("StoreSkinChargeMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.belongStoreId = arg_1_1
	arg_1_0.id = arg_1_2.id
	arg_1_0.buyCount = arg_1_2.buyCount
	arg_1_0.config = StoreConfig.instance:getChargeGoodsConfig(arg_1_0.id)
end

function var_0_0.getSkinChargePrice(arg_2_0)
	local var_2_0
	local var_2_1

	if arg_2_0.config then
		var_2_0 = arg_2_0.config.price
		var_2_1 = arg_2_0.config.originalCost
	end

	return var_2_0, var_2_1
end

function var_0_0.isSoldOut(arg_3_0)
	return arg_3_0.buyCount > 0
end

return var_0_0
