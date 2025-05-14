module("modules.logic.rouge.model.RougeCollectionHandBookListModel", package.seeall)

local var_0_0 = class("RougeCollectionHandBookListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._baseTagFilterMap = arg_1_1
	arg_1_0._extraTagFilterMap = arg_1_2
	arg_1_0._curSelectId = nil

	arg_1_0:onCollectionDataUpdate()
	arg_1_0:selectFirstOrDefault()
end

function var_0_0.onCollectionDataUpdate(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = RougeCollectionConfig.instance:getCollectionSynthesisList()

	if var_2_1 then
		for iter_2_0, iter_2_1 in ipairs(var_2_1) do
			if RougeCollectionHelper.checkCollectionHasAnyOneTag(iter_2_1.product, nil, arg_2_0._baseTagFilterMap, arg_2_0._extraTagFilterMap) then
				table.insert(var_2_0, iter_2_1)
			end
		end
	end

	arg_2_0:setList(var_2_0)
end

function var_0_0.isBagEmpty(arg_3_0)
	return arg_3_0:getCount() <= 0
end

function var_0_0.selectCell(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0:getByIndex(arg_4_1)

	if not var_4_0 then
		arg_4_0._curSelectId = nil

		return
	end

	arg_4_0._curSelectId = arg_4_2 and var_4_0.id or 0

	var_0_0.super.selectCell(arg_4_0, arg_4_1, arg_4_2)
end

function var_0_0.selectFirstOrDefault(arg_5_0)
	if not arg_5_0:getById(arg_5_0._curSelectId) then
		arg_5_0:selectCell(1, true)
	end
end

function var_0_0.getCurSelectCellId(arg_6_0)
	return arg_6_0._curSelectId or 0
end

function var_0_0.updateFilterMap(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._baseTagFilterMap = arg_7_1
	arg_7_0._extraTagFilterMap = arg_7_2

	arg_7_0:onCollectionDataUpdate()
	arg_7_0:selectFirstOrDefault()
end

function var_0_0.isCurSelectTargetId(arg_8_0, arg_8_1)
	return arg_8_0._curSelectId == arg_8_1
end

function var_0_0.isFiltering(arg_9_0)
	return not GameUtil.tabletool_dictIsEmpty(arg_9_0._baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(arg_9_0._extraTagFilterMap)
end

var_0_0.instance = var_0_0.New()

return var_0_0
