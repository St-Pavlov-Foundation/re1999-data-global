module("modules.logic.rouge.map.model.listmodel.RougeLossCollectionListModel", package.seeall)

local var_0_0 = class("RougeLossCollectionListModel", ListScrollModel)

function var_0_0.setLossType(arg_1_0, arg_1_1)
	arg_1_0.lossType = arg_1_1
end

function var_0_0.getLossType(arg_2_0)
	return arg_2_0.lossType
end

function var_0_0.initList(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0.maxSelectCount = arg_3_1
	arg_3_0.selectCount = 0
	arg_3_0.selectMoList = {}
	arg_3_0.allMoList = {}
	arg_3_0.baseTagFilterMap = arg_3_3
	arg_3_0.extraTagFilterMap = arg_3_4

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		arg_3_0:addCollection(iter_3_1.id, iter_3_1.cfgId, arg_3_5)

		local var_3_0 = iter_3_1:getAllEnchantId()
		local var_3_1 = iter_3_1:getAllEnchantCfgId()

		for iter_3_2, iter_3_3 in ipairs(var_3_0) do
			arg_3_0:addCollection(iter_3_3, var_3_1[iter_3_2], arg_3_5)
		end
	end

	arg_3_0.showMoList = {}

	arg_3_0:filterCollection()
end

function var_0_0.addCollection(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_1 or not arg_4_2 then
		return
	end

	if arg_4_1 == 0 or arg_4_2 == 0 then
		return
	end

	if arg_4_3 then
		if not RougeCollectionHelper.isUniqueCollection(arg_4_2) then
			table.insert(arg_4_0.allMoList, {
				uid = arg_4_1,
				collectionId = arg_4_2
			})
		end
	else
		table.insert(arg_4_0.allMoList, {
			uid = arg_4_1,
			collectionId = arg_4_2
		})
	end
end

function var_0_0.filterCollection(arg_5_0)
	tabletool.clear(arg_5_0.showMoList)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.allMoList) do
		if RougeCollectionHelper.checkCollectionHasAnyOneTag(iter_5_1.collectionId, nil, arg_5_0.baseTagFilterMap, arg_5_0.extraTagFilterMap) then
			table.insert(arg_5_0.showMoList, iter_5_1)
		end
	end
end

function var_0_0.refresh(arg_6_0)
	arg_6_0:setList(arg_6_0.showMoList)
end

function var_0_0.getSelectMoList(arg_7_0)
	return arg_7_0.selectMoList
end

function var_0_0.checkCanSelect(arg_8_0)
	return #arg_8_0.selectMoList < arg_8_0.maxSelectCount
end

function var_0_0.getSelectCount(arg_9_0)
	return arg_9_0.selectCount
end

function var_0_0.selectMo(arg_10_0, arg_10_1)
	if arg_10_0.selectCount >= arg_10_0.maxSelectCount then
		return
	end

	if tabletool.indexOf(arg_10_0.selectMoList, arg_10_1) then
		return
	end

	arg_10_0.selectCount = arg_10_0.selectCount + 1

	tabletool.removeValue(arg_10_0.showMoList, arg_10_1)
	table.insert(arg_10_0.selectMoList, arg_10_1)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectLossCollectionChange)
end

function var_0_0.deselectMo(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.selectMoList) do
		if iter_11_1 == arg_11_1 then
			arg_11_0.selectCount = arg_11_0.selectCount - 1

			table.remove(arg_11_0.selectMoList, iter_11_0)
			table.insert(arg_11_0.showMoList, arg_11_1)
			RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectLossCollectionChange)

			return
		end
	end
end

function var_0_0.isFiltering(arg_12_0)
	return not GameUtil.tabletool_dictIsEmpty(arg_12_0.baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(arg_12_0.extraTagFilterMap)
end

function var_0_0.clear(arg_13_0)
	arg_13_0.maxSelectCount = nil
	arg_13_0.selectCount = nil
	arg_13_0.selectMoList = nil
	arg_13_0.allMoList = nil
	arg_13_0.showMoList = nil
	arg_13_0.baseTagFilterMap = nil
	arg_13_0.extraTagFilterMap = nil
	arg_13_0.lossType = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
