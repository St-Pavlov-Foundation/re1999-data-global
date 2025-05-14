module("modules.logic.rouge.dlc.102.model.RougeCollectionLevelUpListModel", package.seeall)

local var_0_0 = class("RougeCollectionLevelUpListModel", ListScrollModel)

function var_0_0.initList(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = RougeDLCModel102.instance:getAllCanLevelUpSpCollection()

	arg_1_0.maxSelectCount = arg_1_1
	arg_1_0.selectCount = 0
	arg_1_0.selectMoList = {}
	arg_1_0.allMoList = {}
	arg_1_0.baseTagFilterMap = arg_1_2
	arg_1_0.extraTagFilterMap = arg_1_3

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0:addCollection(iter_1_1.id, iter_1_1.cfgId, arg_1_4)
	end

	arg_1_0.showMoList = {}

	arg_1_0:filterCollection()
end

function var_0_0.addCollection(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not arg_2_1 or not arg_2_2 then
		return
	end

	if arg_2_1 == 0 or arg_2_2 == 0 then
		return
	end

	if arg_2_3 then
		if not RougeCollectionHelper.isUniqueCollection(arg_2_2) then
			table.insert(arg_2_0.allMoList, {
				uid = arg_2_1,
				collectionId = arg_2_2
			})
		end
	else
		table.insert(arg_2_0.allMoList, {
			uid = arg_2_1,
			collectionId = arg_2_2
		})
	end
end

function var_0_0.filterCollection(arg_3_0)
	tabletool.clear(arg_3_0.showMoList)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.allMoList) do
		if RougeCollectionHelper.checkCollectionHasAnyOneTag(iter_3_1.collectionId, nil, arg_3_0.baseTagFilterMap, arg_3_0.extraTagFilterMap) then
			table.insert(arg_3_0.showMoList, iter_3_1)
		end
	end
end

function var_0_0.refresh(arg_4_0)
	arg_4_0:setList(arg_4_0.showMoList)
end

function var_0_0.getSelectMoList(arg_5_0)
	return arg_5_0.selectMoList
end

function var_0_0.checkCanSelect(arg_6_0)
	return #arg_6_0.selectMoList < arg_6_0.maxSelectCount
end

function var_0_0.getSelectCount(arg_7_0)
	return arg_7_0.selectCount
end

function var_0_0.selectMo(arg_8_0, arg_8_1)
	if arg_8_0.selectCount >= arg_8_0.maxSelectCount then
		return
	end

	if tabletool.indexOf(arg_8_0.selectMoList, arg_8_1) then
		return
	end

	arg_8_0.selectCount = arg_8_0.selectCount + 1

	tabletool.removeValue(arg_8_0.showMoList, arg_8_1)
	table.insert(arg_8_0.selectMoList, arg_8_1)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectLossCollectionChange)
end

function var_0_0.deselectMo(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.selectMoList) do
		if iter_9_1 == arg_9_1 then
			arg_9_0.selectCount = arg_9_0.selectCount - 1

			table.remove(arg_9_0.selectMoList, iter_9_0)
			table.insert(arg_9_0.showMoList, arg_9_1)
			RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectLossCollectionChange)

			return
		end
	end
end

function var_0_0.isFiltering(arg_10_0)
	return not GameUtil.tabletool_dictIsEmpty(arg_10_0.baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(arg_10_0.extraTagFilterMap)
end

function var_0_0.getAllMoCount(arg_11_0)
	return arg_11_0.allMoList and #arg_11_0.allMoList or 0
end

function var_0_0.clear(arg_12_0)
	arg_12_0.maxSelectCount = nil
	arg_12_0.selectCount = nil
	arg_12_0.selectMoList = nil
	arg_12_0.allMoList = nil
	arg_12_0.showMoList = nil
	arg_12_0.baseTagFilterMap = nil
	arg_12_0.extraTagFilterMap = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
