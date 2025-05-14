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

var_0_0.instance = var_0_0.New()

return var_0_0
