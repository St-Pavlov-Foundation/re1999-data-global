module("modules.logic.equip.model.EquipInfoBaseListModel", package.seeall)

local var_0_0 = class("EquipInfoBaseListModel", ListScrollModel)

var_0_0.SortBy = {
	Rare = 2,
	Level = 1
}
var_0_0.levelAscend = false
var_0_0.rareAscend = false

function var_0_0.onInit(arg_1_0)
	arg_1_0.equipMoList = {}
	arg_1_0.levelAscend = false
	arg_1_0.rareAscend = false
	arg_1_0.isChangeSort = false
	arg_1_0.sortBy = var_0_0.SortBy.Level
end

function var_0_0.onOpen(arg_2_0, arg_2_1)
	arg_2_0.heroMo = arg_2_1.heroMo

	arg_2_0:initEquipList()
end

function var_0_0.initEquipList(arg_3_0, arg_3_1)
	arg_3_0.equipMoList = {}
	arg_3_0.recommendEquip = arg_3_0.heroMo and arg_3_0.heroMo:getRecommendEquip() or {}

	local var_3_0 = LuaUtil.tableNotEmpty(arg_3_0.recommendEquip)
	local var_3_1 = arg_3_1:isFiltering()

	for iter_3_0, iter_3_1 in ipairs(EquipModel.instance:getEquips()) do
		if EquipHelper.isNormalEquip(iter_3_1.config) then
			if var_3_1 then
				if arg_3_1:checkIsIncludeTag(iter_3_1.config) then
					iter_3_1.recommondIndex = var_3_0 and tabletool.indexOf(arg_3_0.recommendEquip, iter_3_1.equipId) or -1

					table.insert(arg_3_0.equipMoList, iter_3_1)
				end
			else
				iter_3_1.recommondIndex = var_3_0 and tabletool.indexOf(arg_3_0.recommendEquip, iter_3_1.equipId) or -1

				table.insert(arg_3_0.equipMoList, iter_3_1)
			end
		end
	end

	arg_3_0:resortEquip()
end

function var_0_0.refreshEquipList(arg_4_0)
	arg_4_0:setList(arg_4_0.equipMoList)
end

function var_0_0.isEmpty(arg_5_0)
	if arg_5_0.equipMoList then
		return #arg_5_0.equipMoList == 0
	else
		return true
	end
end

function var_0_0.resortEquip(arg_6_0)
	var_0_0.levelAscend = arg_6_0.levelAscend
	var_0_0.rareAscend = arg_6_0.rareAscend
	var_0_0.isChangeSort = arg_6_0.isChangeSort

	if arg_6_0.sortBy == var_0_0.SortBy.Level then
		table.sort(arg_6_0.equipMoList, arg_6_0._sortByLevel)
	elseif arg_6_0.sortBy == var_0_0.SortBy.Rare then
		table.sort(arg_6_0.equipMoList, arg_6_0._sortByRare)
	else
		logError("not found sotBy : " .. tostring(arg_6_0.sortBy))
		table.sort(arg_6_0.equipMoList, arg_6_0._sortByLevel)
	end
end

function var_0_0._changeSortByLevel(arg_7_0)
	if arg_7_0.sortBy == var_0_0.SortBy.Level then
		arg_7_0.levelAscend = not arg_7_0.levelAscend
	else
		arg_7_0.sortBy = var_0_0.SortBy.Level
		arg_7_0.levelAscend = false
	end

	arg_7_0.isChangeSort = true
end

function var_0_0._changeSortByRare(arg_8_0)
	if arg_8_0.sortBy == var_0_0.SortBy.Rare then
		arg_8_0.rareAscend = not arg_8_0.rareAscend
	else
		arg_8_0.sortBy = var_0_0.SortBy.Rare
		arg_8_0.rareAscend = false
	end

	arg_8_0.isChangeSort = true
end

function var_0_0.changeSortByLevel(arg_9_0)
	arg_9_0:_changeSortByLevel()
	arg_9_0:resortEquip()
	arg_9_0:refreshEquipList()
end

function var_0_0.changeSortByRare(arg_10_0)
	arg_10_0:_changeSortByRare()
	arg_10_0:resortEquip()
	arg_10_0:refreshEquipList()
end

function var_0_0.isSortByLevel(arg_11_0)
	return arg_11_0.sortBy == var_0_0.SortBy.Level
end

function var_0_0.isSortByRare(arg_12_0)
	return arg_12_0.sortBy == var_0_0.SortBy.Rare
end

function var_0_0.getSortState(arg_13_0)
	return arg_13_0.levelAscend and 1 or -1, arg_13_0.rareAscend and 1 or -1
end

function var_0_0._sortByLevel(arg_14_0, arg_14_1)
	local var_14_0, var_14_1 = EquipHelper.typeSort(arg_14_0.config, arg_14_1.config)

	if var_14_1 then
		return var_14_0
	end

	if arg_14_0.equipType == EquipEnum.ClientEquipType.TrialEquip ~= (arg_14_1.equipType == EquipEnum.ClientEquipType.TrialEquip) then
		return arg_14_0.equipType == EquipEnum.ClientEquipType.TrialEquip
	end

	if arg_14_0.recommondIndex ~= arg_14_1.recommondIndex then
		if arg_14_0.recommondIndex < 0 or arg_14_1.recommondIndex < 0 then
			return arg_14_0.recommondIndex > 0
		end

		if not var_0_0.isChangeSort then
			return arg_14_0.recommondIndex < arg_14_1.recommondIndex
		end
	end

	if arg_14_0.level ~= arg_14_1.level then
		if var_0_0.levelAscend then
			return arg_14_0.level < arg_14_1.level
		else
			return arg_14_0.level > arg_14_1.level
		end
	end

	if arg_14_0.config.rare ~= arg_14_1.config.rare then
		if var_0_0.rareAscend then
			return arg_14_0.config.rare < arg_14_1.config.rare
		else
			return arg_14_0.config.rare > arg_14_1.config.rare
		end
	end

	if arg_14_0.equipId ~= arg_14_1.equipId then
		return arg_14_0.equipId > arg_14_1.equipId
	end

	return arg_14_0.id < arg_14_1.id
end

function var_0_0._sortByRare(arg_15_0, arg_15_1)
	local var_15_0, var_15_1 = EquipHelper.typeSort(arg_15_0.config, arg_15_1.config)

	if var_15_1 then
		return var_15_0
	end

	if arg_15_0.equipType == EquipEnum.ClientEquipType.TrialEquip ~= (arg_15_1.equipType == EquipEnum.ClientEquipType.TrialEquip) then
		return arg_15_0.equipType == EquipEnum.ClientEquipType.TrialEquip
	end

	if arg_15_0.recommondIndex ~= arg_15_1.recommondIndex and (arg_15_0.recommondIndex < 0 or arg_15_1.recommondIndex < 0) then
		return arg_15_0.recommondIndex > 0
	end

	if arg_15_0.config.rare ~= arg_15_1.config.rare then
		if var_0_0.rareAscend then
			return arg_15_0.config.rare < arg_15_1.config.rare
		else
			return arg_15_0.config.rare > arg_15_1.config.rare
		end
	end

	if arg_15_0.level ~= arg_15_1.level then
		if var_0_0.levelAscend then
			return arg_15_0.level < arg_15_1.level
		else
			return arg_15_0.level > arg_15_1.level
		end
	end

	if arg_15_0.equipId ~= arg_15_1.equipId then
		return arg_15_0.equipId > arg_15_1.equipId
	end

	return arg_15_0.id < arg_15_1.id
end

function var_0_0.setCurrentSelectEquipMo(arg_16_0, arg_16_1)
	arg_16_0.currentSelectEquipMo = arg_16_1
end

function var_0_0.getCurrentSelectEquipMo(arg_17_0)
	return arg_17_0.currentSelectEquipMo
end

function var_0_0.isSelectedEquip(arg_18_0, arg_18_1)
	return arg_18_0.currentSelectEquipMo and arg_18_0.currentSelectEquipMo.uid == arg_18_1
end

function var_0_0.clear(arg_19_0)
	arg_19_0:onInit()

	arg_19_0.selectedEquipMo = nil
end

function var_0_0.clearRecommend(arg_20_0)
	if not EquipModel.instance:getEquips() then
		return
	end

	for iter_20_0, iter_20_1 in ipairs(EquipModel.instance:getEquips()) do
		iter_20_1:clearRecommend()
	end
end

return var_0_0
