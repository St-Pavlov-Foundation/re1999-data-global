module("modules.logic.equip.model.EquipDecomposeListModel", package.seeall)

local var_0_0 = class("EquipDecomposeListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

var_0_0.SortTag = {
	Rare = 2,
	Level = 1
}
var_0_0.DefaultFilterRare = 4

function var_0_0.checkEquipCanDecompose(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return false
	end

	if arg_3_1.level > 1 then
		return false
	end

	local var_3_0 = arg_3_1.config

	if not EquipHelper.isNormalEquip(var_3_0) then
		return false
	end

	if var_3_0.rare >= var_0_0.DefaultFilterRare then
		return false
	end

	if not arg_3_0.filterMo then
		return true
	end

	return arg_3_0.filterMo:checkIsIncludeTag(arg_3_1.config)
end

function var_0_0.getSortTag(arg_4_0)
	return arg_4_0.sortTag
end

function var_0_0.getSortIsAscend(arg_5_0, arg_5_1)
	if arg_5_1 == var_0_0.SortTag.Level then
		return arg_5_0.levelAscend
	else
		return arg_5_0.rareAscend
	end
end

function var_0_0.isEmpty(arg_6_0)
	return #arg_6_0.equipList == 0
end

function var_0_0.getEquipData(arg_7_0)
	if arg_7_0.equipList then
		tabletool.clear(arg_7_0.equipList)
	else
		arg_7_0.equipList = {}
	end

	for iter_7_0, iter_7_1 in ipairs(EquipModel.instance:getEquips()) do
		if arg_7_0:checkEquipCanDecompose(iter_7_1) then
			table.insert(arg_7_0.equipList, iter_7_1)
		end
	end
end

function var_0_0.initEquipData(arg_8_0)
	arg_8_0.selectedEquipDict = {}
	arg_8_0.selectedEquipCount = 0
	arg_8_0.sortTag = var_0_0.SortTag.Rare

	arg_8_0:resetLevelSortStatus()
	arg_8_0:resetRareSortStatus()
	arg_8_0:getEquipData()
	arg_8_0:sortEquipList()
end

function var_0_0.updateEquipData(arg_9_0, arg_9_1)
	arg_9_0:clearSelectEquip()

	arg_9_0.filterMo = arg_9_1

	arg_9_0:getEquipData()
	arg_9_0:sortEquipList()
end

function var_0_0.resetLevelSortStatus(arg_10_0)
	arg_10_0.levelAscend = false
end

function var_0_0.resetRareSortStatus(arg_11_0)
	arg_11_0.rareAscend = false
end

function var_0_0.changeLevelSortStatus(arg_12_0)
	arg_12_0.sortTag = var_0_0.SortTag.Level
	arg_12_0.levelAscend = not arg_12_0.levelAscend

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSortStatusChange)
end

function var_0_0.changeRareStatus(arg_13_0)
	arg_13_0.sortTag = var_0_0.SortTag.Rare
	arg_13_0.rareAscend = not arg_13_0.rareAscend

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSortStatusChange)
end

function var_0_0.sortEquipList(arg_14_0)
	if arg_14_0.sortTag == var_0_0.SortTag.Level then
		table.sort(arg_14_0.equipList, var_0_0.sortByLv)
	else
		table.sort(arg_14_0.equipList, var_0_0.sortByRare)
	end
end

function var_0_0.sortByLv(arg_15_0, arg_15_1)
	if arg_15_0.level ~= arg_15_1.level then
		if var_0_0.instance.levelAscend then
			return arg_15_0.level < arg_15_1.level
		else
			return arg_15_0.level > arg_15_1.level
		end
	end

	local var_15_0 = arg_15_0.config
	local var_15_1 = arg_15_1.config

	if var_15_0.rare ~= var_15_1.rare then
		if var_0_0.instance.rareAscend then
			return var_15_0.rare < var_15_1.rare
		else
			return var_15_0.rare > var_15_1.rare
		end
	end

	if var_15_0.id ~= var_15_1.id then
		return var_15_0.id < var_15_1.id
	end

	return arg_15_0.id < arg_15_1.id
end

function var_0_0.sortByRare(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.config
	local var_16_1 = arg_16_1.config

	if var_16_0.rare ~= var_16_1.rare then
		if var_0_0.instance.rareAscend then
			return var_16_0.rare < var_16_1.rare
		else
			return var_16_0.rare > var_16_1.rare
		end
	end

	if arg_16_0.level ~= arg_16_1.level then
		if var_0_0.instance.levelAscend then
			return arg_16_0.level < arg_16_1.level
		else
			return arg_16_0.level > arg_16_1.level
		end
	end

	if var_16_0.id ~= var_16_1.id then
		return var_16_0.id < var_16_1.id
	end

	return arg_16_0.id < arg_16_1.id
end

function var_0_0.refreshEquip(arg_17_0)
	arg_17_0:setList(arg_17_0.equipList)
end

function var_0_0.getSelectCount(arg_18_0)
	return arg_18_0.selectedEquipCount
end

function var_0_0.isSelect(arg_19_0, arg_19_1)
	return arg_19_0.selectedEquipDict[arg_19_1]
end

function var_0_0.selectEquipMo(arg_20_0, arg_20_1)
	if arg_20_0.selectedEquipCount >= EquipEnum.DecomposeMaxCount then
		return
	end

	if arg_20_0.selectedEquipDict[arg_20_1.id] then
		return
	end

	arg_20_0.selectedEquipDict[arg_20_1.id] = true
	arg_20_0.selectedEquipCount = arg_20_0.selectedEquipCount + 1

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSelectEquipChange)
end

function var_0_0.desSelectEquipMo(arg_21_0, arg_21_1)
	if not arg_21_0.selectedEquipDict[arg_21_1.id] then
		return
	end

	arg_21_0.selectedEquipDict[arg_21_1.id] = nil
	arg_21_0.selectedEquipCount = arg_21_0.selectedEquipCount - 1

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSelectEquipChange)
end

function var_0_0.getDecomposeEquipCount(arg_22_0)
	local var_22_0 = arg_22_0:getAddExp()

	return math.floor(var_22_0 / 100)
end

function var_0_0.getAddExp(arg_23_0)
	local var_23_0 = 0

	if arg_23_0.selectedEquipDict then
		for iter_23_0, iter_23_1 in pairs(arg_23_0.selectedEquipDict) do
			local var_23_1 = EquipModel.instance:getEquip(tostring(iter_23_0))

			var_23_0 = var_23_0 + EquipConfig.instance:getIncrementalExp(var_23_1)
		end
	end

	return var_23_0
end

function var_0_0.fastAddEquip(arg_24_0)
	tabletool.clear(arg_24_0.selectedEquipDict)

	arg_24_0.selectedEquipCount = 0

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.equipList) do
		if not iter_24_1.isLock then
			if iter_24_1.config.rare <= arg_24_0.filterRare then
				arg_24_0.selectedEquipCount = arg_24_0.selectedEquipCount + 1
				arg_24_0.selectedEquipDict[iter_24_1.id] = true
			end

			if arg_24_0.selectedEquipCount >= EquipEnum.DecomposeMaxCount then
				break
			end
		end
	end

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSelectEquipChange)
end

function var_0_0.setFilterRare(arg_25_0, arg_25_1)
	arg_25_0.filterRare = arg_25_1
end

function var_0_0.clearSelectEquip(arg_26_0)
	tabletool.clear(arg_26_0.selectedEquipDict)

	arg_26_0.selectedEquipCount = 0

	EquipController.instance:dispatchEvent(EquipEvent.OnEquipDecomposeSelectEquipChange)
end

function var_0_0.clear(arg_27_0)
	tabletool.clear(arg_27_0.equipList)
	var_0_0.super.clear(arg_27_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
