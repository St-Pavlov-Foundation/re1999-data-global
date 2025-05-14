module("modules.logic.rouge.model.RougeCollectionUnEnchantListModel", package.seeall)

local var_0_0 = class("RougeCollectionUnEnchantListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._collections = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.onInitData(arg_3_0, arg_3_1)
	arg_3_0._collections = {}

	if arg_3_1 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
			local var_3_0 = RougeCollectionModel.instance:getCollectionByUid(iter_3_1)

			table.insert(arg_3_0._collections, var_3_0)
		end
	end

	arg_3_0:setList(arg_3_0._collections)
end

function var_0_0.isBagEmpty(arg_4_0)
	return arg_4_0:getCount() <= 0
end

function var_0_0.markCurSelectHoleIndex(arg_5_0, arg_5_1)
	arg_5_0._selectHoleIndex = arg_5_1 or 1
end

function var_0_0.getCurSelectHoleIndex(arg_6_0)
	return arg_6_0._selectHoleIndex
end

function var_0_0.switchSelectCollection(arg_7_0, arg_7_1)
	arg_7_0._curSelectCollectionId = arg_7_1
end

function var_0_0.getCurSelectIndex(arg_8_0)
	local var_8_0 = arg_8_0:getCurSelectCollectionId()
	local var_8_1 = arg_8_0:getById(var_8_0)

	return (arg_8_0:getIndex(var_8_1))
end

function var_0_0.getCurSelectCollectionId(arg_9_0)
	return arg_9_0._curSelectCollectionId
end

var_0_0.instance = var_0_0.New()

return var_0_0
