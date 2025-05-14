module("modules.logic.store.model.StoreChargeGoodsItemListModel", package.seeall)

local var_0_0 = class("StoreChargeGoodsItemListModel", ListScrollModel)

function var_0_0.setMOList(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._moList = {}

	if arg_1_1 then
		for iter_1_0, iter_1_1 in pairs(arg_1_1) do
			if iter_1_1.config.belongStoreId == arg_1_2 then
				table.insert(arg_1_0._moList, iter_1_1)
			end
		end

		if #arg_1_0._moList > 1 then
			table.sort(arg_1_0._moList, arg_1_0._sortFunction)
		end
	end

	arg_1_0:setList(arg_1_0._moList)
end

function var_0_0._sortFunction(arg_2_0, arg_2_1)
	local var_2_0 = StoreConfig.instance:getChargeGoodsConfig(arg_2_0.id)
	local var_2_1 = StoreConfig.instance:getChargeGoodsConfig(arg_2_1.id)

	if var_2_0.order ~= var_2_1.order then
		return var_2_0.order < var_2_1.order
	end

	return var_2_0.id < var_2_1.id
end

var_0_0.instance = var_0_0.New()

return var_0_0
