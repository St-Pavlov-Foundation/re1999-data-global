module("modules.logic.store.model.ActivityStoreMo", package.seeall)

local var_0_0 = pureTable("ActivityStoreMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.actId = arg_1_1
	arg_1_0.id = arg_1_2.id
	arg_1_0.config = ActivityStoreConfig.instance:getStoreConfig(arg_1_1, arg_1_0.id)

	arg_1_0:updateData(arg_1_2)
end

function var_0_0.updateData(arg_2_0, arg_2_1)
	arg_2_0.buyCount = arg_2_1.buyCount
end

return var_0_0
