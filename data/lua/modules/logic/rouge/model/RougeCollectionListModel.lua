module("modules.logic.rouge.model.RougeCollectionListModel", package.seeall)

local var_0_0 = class("RougeCollectionListModel", MixScrollModel)

function var_0_0.onInitData(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._selectedConfig = nil
	arg_1_0._baseTagFilterMap = arg_1_1
	arg_1_0._extraTagFilterMap = arg_1_2
	arg_1_0._selectedType = arg_1_3
	arg_1_0._updatePos = arg_1_4

	if arg_1_4 then
		arg_1_0._posMap = {}
	end

	arg_1_0:onCollectionDataUpdate()
end

function var_0_0.getPos(arg_2_0, arg_2_1)
	local var_2_0 = lua_rouge_collection_unlock.configDict[arg_2_1]

	return var_2_0 and var_2_0.sortId or 0
end

function var_0_0.setSelectedConfig(arg_3_0, arg_3_1)
	arg_3_0._selectedConfig = arg_3_1

	RougeController.instance:dispatchEvent(RougeEvent.OnClickCollectionListItem)
end

function var_0_0.getSelectedConfig(arg_4_0)
	return arg_4_0._selectedConfig
end

function var_0_0._canShow(arg_5_0, arg_5_1)
	if not arg_5_1.interactable then
		return false
	end

	if arg_5_0._selectedType == 1 then
		return true
	end

	local var_5_0 = RougeOutsideModel.instance:collectionIsPass(arg_5_1.id)

	if arg_5_0._selectedType == 2 then
		return var_5_0
	end

	return not var_5_0
end

function var_0_0.onCollectionDataUpdate(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = {}
	local var_6_2 = {}
	local var_6_3 = 0
	local var_6_4 = {}
	local var_6_5 = RougeCollectionConfig.instance:getAllInteractCollections()

	if var_6_5 then
		for iter_6_0, iter_6_1 in pairs(var_6_5) do
			if RougeCollectionHelper.checkCollectionHasAnyOneTag(iter_6_1.id, nil, arg_6_0._baseTagFilterMap, arg_6_0._extraTagFilterMap) then
				local var_6_6 = var_6_0[iter_6_1.type]

				if not var_6_6 then
					var_6_6 = {
						type = iter_6_1.type
					}
					var_6_0[iter_6_1.type] = var_6_6

					table.insert(var_6_1, var_6_6)
				end

				if arg_6_0:_canShow(iter_6_1) then
					table.insert(var_6_6, iter_6_1)
				end
			end
		end
	end

	table.sort(var_6_1, var_0_0.sortType)

	local var_6_7 = 1

	arg_6_0._firstType = nil

	for iter_6_2, iter_6_3 in ipairs(var_6_1) do
		local var_6_8 = var_6_0[iter_6_3.type]

		table.sort(var_6_8, var_0_0.sortTypeList)

		local var_6_9

		for iter_6_4, iter_6_5 in ipairs(var_6_8) do
			if not var_6_9 then
				var_6_9 = {}

				if iter_6_4 == 1 and arg_6_0._firstType then
					var_6_9.type = iter_6_3.type
				end

				if not arg_6_0._firstType then
					arg_6_0._firstType = iter_6_3.type
				end

				table.insert(var_6_2, var_6_9)

				if var_6_9.type then
					var_6_4[var_6_9.type] = var_6_3
				end

				var_6_3 = var_6_3 + (var_6_9.type and RougeEnum.CollectionHeight.Big or RougeEnum.CollectionHeight.Small)
			end

			table.insert(var_6_9, iter_6_5)

			if arg_6_0._updatePos then
				arg_6_0._posMap[iter_6_5.id] = var_6_7
				var_6_7 = var_6_7 + 1
			end

			if not arg_6_0._selectedConfig then
				arg_6_0:setSelectedConfig(iter_6_5)
			end

			if #var_6_9 >= RougeEnum.CollectionListRowNum then
				var_6_9 = nil
			end
		end
	end

	if arg_6_0._updatePos then
		arg_6_0._enchantList = var_6_0[RougeEnum.CollectionType.Enchant]
	end

	arg_6_0._typeHeightMap = var_6_4
	arg_6_0._typeList = var_6_1

	arg_6_0:setList(var_6_2)
end

function var_0_0.getTypeHeightMap(arg_7_0)
	return arg_7_0._typeHeightMap
end

function var_0_0.getTypeList(arg_8_0)
	return arg_8_0._typeList
end

function var_0_0.getFirstType(arg_9_0)
	return arg_9_0._firstType
end

function var_0_0.getEnchantList(arg_10_0)
	return arg_10_0._enchantList
end

function var_0_0.sortType(arg_11_0, arg_11_1)
	local var_11_0 = RougeEnum.CollectionTypeSort[arg_11_0.type]
	local var_11_1 = RougeEnum.CollectionTypeSort[arg_11_1.type]

	if not var_11_0 or not var_11_1 then
		if not var_11_0 then
			logError(string.format("无法查询到收藏夹造物类型排序，类型 = %s", arg_11_0.type))
		end

		if not var_11_1 then
			logError(string.format("无法查询到收藏夹造物类型排序，类型 = %s", arg_11_1.type))
		end

		return var_11_0 ~= nil
	end

	return var_11_0 < var_11_1
end

function var_0_0.getSize(arg_12_0)
	return (RougeCollectionConfig.instance:getCollectionCellCount(arg_12_0, RougeEnum.CollectionEditorParamType.Shape))
end

function var_0_0.sortTypeList(arg_13_0, arg_13_1)
	local var_13_0 = var_0_0.instance:getPos(arg_13_0.id)
	local var_13_1 = var_0_0.instance:getPos(arg_13_1.id)

	if var_13_0 ~= var_13_1 then
		return var_13_0 < var_13_1
	end

	return arg_13_0.id < arg_13_1.id
end

function var_0_0.getInfoList(arg_14_0, arg_14_1)
	arg_14_0._mixCellInfo = {}

	local var_14_0 = arg_14_0:getList()

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_1 = iter_14_1.type and RougeEnum.CollectionHeight.Big or RougeEnum.CollectionHeight.Small
		local var_14_2 = iter_14_1.type and 1 or 2
		local var_14_3 = SLFramework.UGUI.MixCellInfo.New(var_14_2, var_14_1)

		table.insert(arg_14_0._mixCellInfo, var_14_3)
	end

	return arg_14_0._mixCellInfo
end

function var_0_0.isFiltering(arg_15_0)
	return not GameUtil.tabletool_dictIsEmpty(arg_15_0._baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(arg_15_0._extraTagFilterMap)
end

var_0_0.instance = var_0_0.New()

return var_0_0
