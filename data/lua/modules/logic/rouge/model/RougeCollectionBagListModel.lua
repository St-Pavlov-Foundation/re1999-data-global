module("modules.logic.rouge.model.RougeCollectionBagListModel", package.seeall)

local var_0_0 = class("RougeCollectionBagListModel", ListScrollModel)

function var_0_0.onInitData(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._baseTagFilterMap = arg_1_1
	arg_1_0._extraTagFilterMap = arg_1_2

	arg_1_0:filterCollection()
	arg_1_0:markCurSelectCollectionId()
end

function var_0_0.filterCollection(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = RougeCollectionModel.instance:getBagAreaCollection()

	if var_2_1 then
		for iter_2_0, iter_2_1 in ipairs(var_2_1) do
			local var_2_2 = iter_2_1:getAllEnchantCfgId()

			if RougeCollectionHelper.checkCollectionHasAnyOneTag(iter_2_1.cfgId, var_2_2, arg_2_0._baseTagFilterMap, arg_2_0._extraTagFilterMap) then
				table.insert(var_2_0, iter_2_1)
			end
		end
	end

	table.sort(var_2_0, arg_2_0.sortFunc)
	arg_2_0:setList(var_2_0)
end

function var_0_0.sortFunc(arg_3_0, arg_3_1)
	local var_3_0 = RougeCollectionConfig.instance:getCollectionCfg(arg_3_0.cfgId)
	local var_3_1 = RougeCollectionConfig.instance:getCollectionCfg(arg_3_1.cfgId)

	if var_3_0 and var_3_1 and var_3_0.showRare ~= var_3_1.showRare then
		return var_3_0.showRare > var_3_1.showRare
	end

	local var_3_2 = RougeCollectionConfig.instance:getCollectionCellCount(arg_3_0.cfgId, RougeEnum.CollectionEditorParamType.Shape)
	local var_3_3 = RougeCollectionConfig.instance:getCollectionCellCount(arg_3_1.cfgId, RougeEnum.CollectionEditorParamType.Shape)

	if var_3_2 ~= var_3_3 then
		return var_3_3 < var_3_2
	end

	return arg_3_0.id < arg_3_1.id
end

function var_0_0.isBagEmpty(arg_4_0)
	return arg_4_0:getCount() <= 0
end

function var_0_0.isFiltering(arg_5_0)
	return not GameUtil.tabletool_dictIsEmpty(arg_5_0._baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(arg_5_0._extraTagFilterMap)
end

function var_0_0.isCollectionSelect(arg_6_0, arg_6_1)
	if not arg_6_1 or not arg_6_0._curSelectCollection then
		return
	end

	return arg_6_0._curSelectCollection == arg_6_1
end

function var_0_0.markCurSelectCollectionId(arg_7_0, arg_7_1)
	arg_7_0._curSelectCollection = arg_7_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
