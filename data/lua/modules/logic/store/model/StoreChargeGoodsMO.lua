module("modules.logic.store.model.StoreChargeGoodsMO", package.seeall)

local var_0_0 = pureTable("StoreChargeGoodsMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.belongStoreId = arg_1_1
	arg_1_0.id = arg_1_2.id
	arg_1_0.buyCount = arg_1_2.buyCount
	arg_1_0.firstCharge = arg_1_2.firstCharge
	arg_1_0.config = StoreConfig.instance:getChargeGoodsConfig(arg_1_0.id)
end

return var_0_0
