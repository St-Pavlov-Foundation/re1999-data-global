module("modules.logic.room.model.backpack.RoomCritterDecomposeListModel", package.seeall)

local var_0_0 = class("RoomCritterDecomposeListModel", ListScrollModel)
local var_0_1 = 6

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
	arg_1_0:clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.clearData(arg_3_0)
	arg_3_0:clearCritterList()
	arg_3_0:setIsSortByRareAscend(false)
	arg_3_0:setFilterRare(CritterEnum.CritterDecomposeMinRare)
	arg_3_0:setFilterMature(CritterEnum.MatureFilterType.All)
end

function var_0_0.clearCritterList(arg_4_0)
	if arg_4_0.critterList then
		tabletool.clear(arg_4_0.critterList)
	else
		arg_4_0.critterList = {}
	end

	arg_4_0:clearSelectedCritter()
end

function var_0_0.clearSelectedCritter(arg_5_0)
	if arg_5_0.selectedCritterDict then
		tabletool.clear(arg_5_0.selectedCritterDict)
	else
		arg_5_0.selectedCritterDict = {}
	end

	arg_5_0.selectedCritterCount = 0

	CritterController.instance:dispatchEvent(CritterEvent.CritterDecomposeChangeSelect)
end

function var_0_0.updateCritterList(arg_6_0, arg_6_1)
	arg_6_0:clearCritterList()

	local var_6_0 = CritterModel.instance:getAllCritters()
	local var_6_1 = not arg_6_0.filterMature or arg_6_0.filterMature == CritterEnum.MatureFilterType.All
	local var_6_2 = arg_6_0.filterMature == CritterEnum.MatureFilterType.Mature

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_3 = false

		if var_6_1 then
			var_6_3 = arg_6_0:checkCanDecompose(iter_6_1, arg_6_1)
		else
			local var_6_4 = iter_6_1:isMaturity()

			if var_6_2 and var_6_4 or not var_6_2 and not var_6_4 then
				var_6_3 = arg_6_0:checkCanDecompose(iter_6_1, arg_6_1)
			end
		end

		if var_6_3 then
			table.insert(arg_6_0.critterList, iter_6_1)
		end
	end

	arg_6_0:sortCritterList()
end

function var_0_0.checkCanDecompose(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = false

	if arg_7_1 and not arg_7_1:isLock() then
		local var_7_1 = arg_7_1:getId()
		local var_7_2 = arg_7_1:getDefineCfg()
		local var_7_3 = arg_7_1:isCultivating()
		local var_7_4 = ManufactureModel.instance:getCritterWorkingBuilding(var_7_1)
		local var_7_5 = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(var_7_1)

		if not var_7_3 and not var_7_4 and not var_7_5 and var_7_2.rare < var_0_1 then
			if arg_7_2 then
				var_7_0 = arg_7_2:isPassedFilter(arg_7_1)
			else
				var_7_0 = true
			end
		end
	end

	return var_7_0
end

function var_0_0.sortCritterList(arg_8_0)
	if arg_8_0:getIsSortByRareAscend() then
		table.sort(arg_8_0.critterList, CritterHelper.sortByRareAscend)
	else
		table.sort(arg_8_0.critterList, CritterHelper.sortByRareDescend)
	end
end

function var_0_0.refreshCritterShowList(arg_9_0)
	arg_9_0:setList(arg_9_0.critterList)
end

function var_0_0.checkDecomposeCountLimit(arg_10_0)
	local var_10_0 = true
	local var_10_1 = CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.DecomposeCountLimit)
	local var_10_2 = tonumber(var_10_1)

	if var_10_2 and arg_10_0.selectedCritterDict then
		local var_10_3 = 0
		local var_10_4 = 0
		local var_10_5 = CritterModel.instance:getAllCritters()

		for iter_10_0, iter_10_1 in ipairs(var_10_5) do
			if iter_10_1:isMaturity() then
				var_10_3 = var_10_3 + 1

				local var_10_6 = iter_10_1:getId()

				if arg_10_0.selectedCritterDict[var_10_6] then
					var_10_4 = var_10_4 + 1
				end
			end
		end

		if var_10_2 > var_10_3 - var_10_4 then
			var_10_0 = false
		end
	end

	return var_10_0
end

function var_0_0.fastAddCritter(arg_11_0)
	tabletool.clear(arg_11_0.selectedCritterDict)

	arg_11_0.selectedCritterCount = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.critterList) do
		if not iter_11_1:isLock() then
			local var_11_0 = iter_11_1:getDefineCfg()

			if arg_11_0:getFilterRare() >= var_11_0.rare then
				arg_11_0.selectedCritterCount = arg_11_0.selectedCritterCount + 1
				arg_11_0.selectedCritterDict[iter_11_1.id] = true
			end

			if arg_11_0.selectedCritterCount >= CritterEnum.DecomposeMaxCount then
				break
			end
		end
	end

	CritterController.instance:dispatchEvent(CritterEvent.CritterDecomposeChangeSelect)
end

function var_0_0.selectDecomposeCritter(arg_12_0, arg_12_1)
	if arg_12_0.selectedCritterCount >= CritterEnum.DecomposeMaxCount then
		return
	end

	if arg_12_0.selectedCritterDict[arg_12_1.id] then
		return
	end

	arg_12_0.selectedCritterDict[arg_12_1.id] = true
	arg_12_0.selectedCritterCount = arg_12_0.selectedCritterCount + 1

	CritterController.instance:dispatchEvent(CritterEvent.CritterDecomposeChangeSelect)
end

function var_0_0.unselectDecomposeCritter(arg_13_0, arg_13_1)
	if not arg_13_0.selectedCritterDict[arg_13_1.id] then
		return
	end

	arg_13_0.selectedCritterDict[arg_13_1.id] = nil
	arg_13_0.selectedCritterCount = arg_13_0.selectedCritterCount - 1

	CritterController.instance:dispatchEvent(CritterEvent.CritterDecomposeChangeSelect)
end

function var_0_0.isSelect(arg_14_0, arg_14_1)
	return arg_14_0.selectedCritterDict[arg_14_1]
end

function var_0_0.getSelectCount(arg_15_0)
	return arg_15_0.selectedCritterCount
end

function var_0_0.getDecomposeCritterCount(arg_16_0)
	local var_16_0 = 0

	if arg_16_0.selectedCritterDict then
		for iter_16_0, iter_16_1 in pairs(arg_16_0.selectedCritterDict) do
			local var_16_1 = CritterModel.instance:getCritterMOByUid(iter_16_0):getDefineCfg()
			local var_16_2 = DungeonConfig.instance:getRewardItems(var_16_1.banishBonus)

			for iter_16_2, iter_16_3 in ipairs(var_16_2) do
				var_16_0 = var_16_0 + iter_16_3[3]
			end
		end
	end

	return var_16_0
end

function var_0_0.getSelectUIds(arg_17_0)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(arg_17_0.selectedCritterDict) do
		var_17_0[#var_17_0 + 1] = iter_17_0
	end

	return var_17_0
end

function var_0_0.setFilterMature(arg_18_0, arg_18_1)
	arg_18_0.filterMature = arg_18_1
end

function var_0_0.setFilterRare(arg_19_0, arg_19_1)
	arg_19_0.filterRare = arg_19_1
end

function var_0_0.setIsSortByRareAscend(arg_20_0, arg_20_1)
	arg_20_0._rareAscend = arg_20_1

	CritterController.instance:dispatchEvent(CritterEvent.CritterChangeSort)
end

function var_0_0.getFilterMature(arg_21_0)
	return arg_21_0.filterMature or CritterEnum.MatureFilterType.All
end

function var_0_0.getFilterRare(arg_22_0)
	return arg_22_0.filterRare or CritterEnum.CritterDecomposeMinRare
end

function var_0_0.getIsSortByRareAscend(arg_23_0)
	return arg_23_0._rareAscend
end

function var_0_0.isEmpty(arg_24_0)
	return arg_24_0:getCount() <= 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
