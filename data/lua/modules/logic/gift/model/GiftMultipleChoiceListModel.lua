module("modules.logic.gift.model.GiftMultipleChoiceListModel", package.seeall)

local var_0_0 = class("GiftMultipleChoiceListModel", ListScrollModel)

function var_0_0.setPropList(arg_1_0, arg_1_1)
	arg_1_0._moList = arg_1_1 and arg_1_1 or {}

	arg_1_0:setList(arg_1_0._moList)
end

function var_0_0.getOptionalGiftIdList(arg_2_0, arg_2_1)
	local var_2_0 = {}
	local var_2_1 = ItemModel.instance:getOptionalGiftMaterialSubTypeList(arg_2_1)

	for iter_2_0, iter_2_1 in pairs(var_2_1) do
		table.insert(var_2_0, iter_2_1)
	end

	return var_2_0
end

function var_0_0.getOptionalGiftInfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getOptionalGiftIdList(arg_3_1)
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		local var_3_2 = {
			1,
			iter_3_1,
			1
		}

		table.insert(var_3_1, var_3_2)
	end

	return var_3_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
