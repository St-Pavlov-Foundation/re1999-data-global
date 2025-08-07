module("modules.logic.store.model.StoreClothesGoodsItemListModel", package.seeall)

local var_0_0 = class("StoreClothesGoodsItemListModel", StoreNormalGoodsItemListModel)

function var_0_0.setMOList(arg_1_0, arg_1_1)
	arg_1_0._moList = {}

	if arg_1_1 then
		for iter_1_0, iter_1_1 in pairs(arg_1_1) do
			table.insert(arg_1_0._moList, iter_1_1)
		end

		if #arg_1_0._moList > 1 then
			table.sort(arg_1_0._moList, StoreNormalGoodsItemListModel._sortFunction)
		end

		StoreController.instance:dispatchEvent(StoreEvent.CheckSkinViewEmpty, false)
	else
		StoreController.instance:dispatchEvent(StoreEvent.CheckSkinViewEmpty, true)
	end

	if next(arg_1_0._moList) then
		StoreController.instance:dispatchEvent(StoreEvent.CheckSkinViewEmpty, false)
	else
		StoreController.instance:dispatchEvent(StoreEvent.CheckSkinViewEmpty, true)
	end

	arg_1_0:setList(arg_1_0._moList)
end

function var_0_0.findMOByProduct(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0:getList()
	local var_2_1 = #var_2_0

	for iter_2_0 = 1, var_2_1 do
		local var_2_2 = var_2_0[iter_2_0]

		if var_2_2 and var_2_2:hasProduct(arg_2_1, arg_2_2) then
			return var_2_2
		end
	end

	return nil
end

function var_0_0.getGoodIndex(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getList()

	for iter_3_0 = 1, #var_3_0 do
		if var_3_0[iter_3_0].goodsId == arg_3_1 then
			return iter_3_0
		end
	end

	return 1
end

var_0_0.instance = var_0_0.New()

return var_0_0
