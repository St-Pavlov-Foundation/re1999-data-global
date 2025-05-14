module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotEnchantBagListModel", package.seeall)

local var_0_0 = class("V1a6_CachotEnchantBagListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._collectionDataDic = nil
	arg_1_0._curSelectCollectionId = nil
	arg_1_0._curSelectHoleIndex = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.onInitData(arg_3_0, arg_3_1)
	arg_3_0._collectionDataDic = arg_3_0:getAllCollectionDataByType()

	arg_3_0:switchCategory(arg_3_1)
end

function var_0_0.getAllCollectionDataByType(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = V1a6_CachotModel.instance:getRogueInfo().collections
	local var_4_2 = V1a6_CachotCollectionEnchantView.AllFilterType

	var_4_0[var_4_2] = {}

	for iter_4_0, iter_4_1 in pairs(V1a6_CachotEnum.CollectionType) do
		var_4_0[iter_4_1] = {}
	end

	if var_4_1 then
		for iter_4_2, iter_4_3 in ipairs(var_4_1) do
			local var_4_3 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(iter_4_3.cfgId)
			local var_4_4 = var_4_3 and var_4_3.type

			if var_4_4 and var_4_4 ~= V1a6_CachotEnum.CollectionType.Enchant then
				local var_4_5 = var_4_0[var_4_4]

				table.insert(var_4_0[var_4_2], iter_4_3)

				if var_4_5 then
					table.insert(var_4_5, iter_4_3)
				else
					local var_4_6 = var_4_3.id

					logError(string.format("collectionType match error, collectionId = %s, collectionType = %s", var_4_6, var_4_4))
				end
			end
		end
	end

	for iter_4_4, iter_4_5 in pairs(var_4_0) do
		table.sort(iter_4_5, arg_4_0.sortFunc)
	end

	return var_4_0
end

function var_0_0.sortFunc(arg_5_0, arg_5_1)
	local var_5_0 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(arg_5_0.cfgId)
	local var_5_1 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(arg_5_1.cfgId)

	if var_5_0 and var_5_1 and var_5_0.holeNum ~= var_5_1.holeNum and (var_5_0.holeNum == 0 or var_5_1.holeNum == 0) then
		return var_5_0.holeNum ~= 0
	end

	if var_5_0 and var_5_1 and var_5_0.type ~= var_5_1.type then
		return var_5_0.type < var_5_1.type
	end

	return arg_5_0.id > arg_5_1.id
end

function var_0_0.isBagEmpty(arg_6_0)
	return arg_6_0:getCount() <= 0
end

function var_0_0.selectCell(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._curSelectCollectionId

	if arg_7_1 and arg_7_1 > 0 and arg_7_2 then
		arg_7_0:selectCellInternal(arg_7_1, arg_7_2)
	else
		arg_7_0:selectCellInternal(var_7_0, false)
	end
end

function var_0_0.selectCellInternal(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:getById(arg_8_1)
	local var_8_1

	if var_8_0 then
		local var_8_2 = arg_8_0:getIndex(var_8_0)

		var_0_0.super.selectCell(arg_8_0, var_8_2, arg_8_2)

		var_8_1 = arg_8_2 and var_8_0.id
	end

	arg_8_0._curSelectCollectionId = var_8_1
end

function var_0_0.getCurSelectCollectionId(arg_9_0)
	return arg_9_0._curSelectCollectionId
end

function var_0_0.getCurSelectHoleIndex(arg_10_0)
	return arg_10_0._curSelectHoleIndex or V1a6_CachotEnum.CollectionHole.Left
end

function var_0_0.markCurSelectHoleIndex(arg_11_0, arg_11_1)
	arg_11_0._curSelectHoleIndex = arg_11_1
end

function var_0_0.getCurSelectCategory(arg_12_0)
	return arg_12_0._curSelectCategory
end

function var_0_0.switchCategory(arg_13_0, arg_13_1)
	arg_13_0._curSelectCategory = arg_13_1 or V1a6_CachotCollectionEnchantView.AllFilterType

	local var_13_0 = arg_13_0._collectionDataDic[arg_13_0._curSelectCategory]

	if var_13_0 then
		arg_13_0:setList(var_13_0)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
