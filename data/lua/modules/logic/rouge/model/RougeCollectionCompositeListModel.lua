module("modules.logic.rouge.model.RougeCollectionCompositeListModel", package.seeall)

local var_0_0 = class("RougeCollectionCompositeListModel", ListScrollModel)

function var_0_0.onInitData(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._baseTagFilterMap = arg_1_1
	arg_1_0._extraTagFilterMap = arg_1_2

	arg_1_0:filterCollection()
end

function var_0_0.filterCollection(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = RougeCollectionConfig.instance:getCollectionSynthesisList()

	if var_2_1 then
		for iter_2_0, iter_2_1 in ipairs(var_2_1) do
			local var_2_2 = RougeCollectionHelper.checkCollectionHasAnyOneTag(iter_2_1.product, nil, arg_2_0._baseTagFilterMap, arg_2_0._extraTagFilterMap)
			local var_2_3 = RougeDLCHelper.isCurrentUsingContent(iter_2_1.version)

			if var_2_2 and var_2_3 then
				table.insert(var_2_0, iter_2_1)
			end
		end
	end

	table.sort(var_2_0, arg_2_0.sortFunc)
	arg_2_0:setList(var_2_0)
end

function var_0_0.sortFunc(arg_3_0, arg_3_1)
	local var_3_0 = RougeCollectionModel.instance:checkIsCanCompositeCollection(arg_3_0.id)

	if var_3_0 ~= RougeCollectionModel.instance:checkIsCanCompositeCollection(arg_3_1.id) then
		return var_3_0
	end

	return arg_3_0.id < arg_3_1.id
end

function var_0_0.isBagEmpty(arg_4_0)
	return arg_4_0:getCount() <= 0
end

function var_0_0.selectCell(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getByIndex(arg_5_1)

	if not var_5_0 then
		return
	end

	arg_5_0._curSelectId = arg_5_2 and var_5_0.id or 0

	var_0_0.super.selectCell(arg_5_0, arg_5_1, arg_5_2)
end

function var_0_0.selectFirstOrDefault(arg_6_0)
	if not arg_6_0:isBagEmpty() then
		arg_6_0:selectCell(1, true)
	end
end

function var_0_0.getCurSelectCellId(arg_7_0)
	return arg_7_0._curSelectId or 0
end

function var_0_0.isFiltering(arg_8_0)
	return not GameUtil.tabletool_dictIsEmpty(arg_8_0._baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(arg_8_0._extraTagFilterMap)
end

var_0_0.instance = var_0_0.New()

return var_0_0
