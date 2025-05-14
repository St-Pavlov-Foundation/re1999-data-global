module("modules.logic.versionactivity2_2.eliminate.model.EliminateSelectChessMenListModel", package.seeall)

local var_0_0 = class("EliminateSelectChessMenListModel", MultiSortListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._initList = {}
	arg_2_0._addList = {}
	arg_2_0._presetList = {}
	arg_2_0._selectedChessMen = nil
	arg_2_0._quickEdit = nil
end

function var_0_0.setQuickEdit(arg_3_0, arg_3_1)
	arg_3_0._quickEdit = arg_3_1
end

function var_0_0.getQuickEdit(arg_4_0)
	return arg_4_0._quickEdit
end

function var_0_0.getAddIds(arg_5_0)
	local var_5_0 = {}

	for iter_5_0 = 1, arg_5_0._addMaxCount do
		local var_5_1 = arg_5_0._addList[iter_5_0]

		if var_5_1 then
			table.insert(var_5_0, var_5_1.config.id)
		end
	end

	return var_5_0
end

function var_0_0.isInAddList(arg_6_0, arg_6_1)
	for iter_6_0 = 1, arg_6_0._addMaxCount do
		if arg_6_0._addList[iter_6_0] == arg_6_1 then
			return true
		end
	end
end

function var_0_0.getAddChessMen(arg_7_0, arg_7_1)
	return arg_7_0._addList[arg_7_1]
end

function var_0_0.getAddMaxCount(arg_8_0)
	return arg_8_0._addMaxCount
end

function var_0_0.getAutoList(arg_9_0)
	if #arg_9_0._presetList > 0 then
		return arg_9_0._presetList
	end

	local var_9_0 = {}

	for iter_9_0 = 1, arg_9_0._addMaxCount do
		local var_9_1 = arg_9_0._initList[iter_9_0]

		if var_9_1 and EliminateTeamSelectionModel.instance:hasChessPieceOrPreset(var_9_1.config.id) then
			table.insert(var_9_0, var_9_1.config.id)
		else
			break
		end
	end

	return var_9_0
end

function var_0_0.canAddChessMen(arg_10_0, arg_10_1)
	for iter_10_0 = 1, arg_10_0._addMaxCount do
		if arg_10_0._addList[iter_10_0] == nil then
			return true
		end
	end
end

function var_0_0.addSelectedChessMen(arg_11_0, arg_11_1)
	tabletool.removeValue(arg_11_0._initList, arg_11_1)

	for iter_11_0 = 1, arg_11_0._addMaxCount do
		if arg_11_0._addList[iter_11_0] == nil then
			arg_11_0._addList[iter_11_0] = arg_11_1

			break
		end
	end

	arg_11_0:_changeChessMen()
end

function var_0_0._removeListValue(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		if iter_12_1 == arg_12_2 then
			arg_12_1[iter_12_0] = nil

			break
		end
	end
end

function var_0_0.removeSelectedChessMen(arg_13_0, arg_13_1)
	arg_13_0:_removeListValue(arg_13_0._addList, arg_13_1)
	table.insert(arg_13_0._initList, arg_13_1)
	arg_13_0:_changeChessMen()
end

function var_0_0._changeChessMen(arg_14_0)
	arg_14_0:updateList()
	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.ChangeChessMen)
end

function var_0_0.setSelectedChessMen(arg_15_0, arg_15_1)
	arg_15_0._selectedChessMen = arg_15_1

	EliminateMapController.instance:dispatchEvent(EliminateMapEvent.SelectChessMen)
end

function var_0_0.getSelectedChessMen(arg_16_0)
	return arg_16_0._selectedChessMen
end

function var_0_0._sortRare(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0.config.level
	local var_17_1 = arg_17_1.config.level

	if var_17_0 ~= var_17_1 then
		if arg_17_2 then
			return var_17_0 < var_17_1
		else
			return var_17_1 < var_17_0
		end
	end
end

function var_0_0._sortPower(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_0.config.defaultPower
	local var_18_1 = arg_18_1.config.defaultPower

	if var_18_0 ~= var_18_1 then
		if arg_18_2 then
			return var_18_0 < var_18_1
		else
			return var_18_1 < var_18_0
		end
	end
end

function var_0_0._sortResource(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = arg_19_0.costValue
	local var_19_1 = arg_19_1.costValue

	if var_19_0 ~= var_19_1 then
		if arg_19_2 then
			return var_19_0 < var_19_1
		else
			return var_19_1 < var_19_0
		end
	end
end

function var_0_0._sortDefault(arg_20_0, arg_20_1, arg_20_2)
	return arg_20_0.config.id < arg_20_1.config.id
end

function var_0_0._sortFirst(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = EliminateTeamSelectionModel.instance:hasChessPieceOrPreset(arg_21_0.config.id)

	if var_21_0 ~= EliminateTeamSelectionModel.instance:hasChessPieceOrPreset(arg_21_1.config.id) then
		return var_21_0
	end
end

function var_0_0.initList(arg_22_0)
	arg_22_0:initSort()
	arg_22_0:addSortType(EliminateMapEnum.SortType.Rare, var_0_0._sortRare)
	arg_22_0:addSortType(EliminateMapEnum.SortType.Power, var_0_0._sortPower)
	arg_22_0:addSortType(EliminateMapEnum.SortType.Resource, var_0_0._sortResource)
	arg_22_0:addOtherSort(var_0_0._sortFirst, var_0_0._sortDefault)
	arg_22_0:setCurSortType(EliminateMapEnum.SortType.Rare)

	arg_22_0._addMaxCount = EliminateOutsideModel.instance:getUnlockSlotNum()
	arg_22_0._initList = tabletool.copy(EliminateConfig.instance:getSoldierChessList())
	arg_22_0._addList = {}
	arg_22_0._presetList = {}

	arg_22_0:_initPresetList()
	arg_22_0:_initPrevSelectedChecss()
	arg_22_0:_cleanList()
	arg_22_0:updateList()
end

function var_0_0._cleanList(arg_23_0)
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(arg_23_0._addList) do
		var_23_0[iter_23_1.id] = true
	end

	for iter_23_2 = #arg_23_0._initList, 1, -1 do
		if var_23_0[arg_23_0._initList[iter_23_2].id] then
			table.remove(arg_23_0._initList, iter_23_2)
		end
	end
end

function var_0_0._initPrevSelectedChecss(arg_24_0)
	if EliminateTeamSelectionModel.instance:isPreset() then
		return
	end

	local var_24_0 = EliminateMapController.getPrefsString(EliminateMapEnum.PrefsKey.ChessSelected, "")
	local var_24_1 = string.split(var_24_0, ",")

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		local var_24_2 = string.split(iter_24_1, "_")
		local var_24_3 = tonumber(var_24_2[1])
		local var_24_4 = tonumber(var_24_2[2])

		if var_24_3 and var_24_4 then
			local var_24_5 = EliminateConfig.instance:getSoldierChessById(var_24_4)

			if var_24_5 then
				arg_24_0._addList[var_24_3] = var_24_5
			end
		end
	end
end

function var_0_0.serializeAddList(arg_25_0)
	local var_25_0

	for iter_25_0 = 1, arg_25_0._addMaxCount do
		local var_25_1 = arg_25_0._addList[iter_25_0]

		if var_25_1 then
			local var_25_2 = string.format("%d_%d", iter_25_0, var_25_1.id)

			if string.nilorempty(var_25_0) then
				var_25_0 = var_25_2
			else
				var_25_0 = var_25_0 .. "," .. var_25_2
			end
		end
	end

	return var_25_0
end

function var_0_0._initPresetList(arg_26_0)
	if not EliminateTeamSelectionModel.instance:isPreset() then
		return
	end

	for iter_26_0 = #arg_26_0._initList, 1, -1 do
		local var_26_0 = arg_26_0._initList[iter_26_0]

		if var_26_0 and EliminateTeamSelectionModel.instance:isPresetSoldier(var_26_0.id) then
			table.insert(arg_26_0._presetList, var_26_0.id)
			table.insert(arg_26_0._addList, var_26_0)
			table.remove(arg_26_0._initList, iter_26_0)
		end
	end
end

function var_0_0.updateList(arg_27_0)
	arg_27_0:setSortList(arg_27_0._initList)
end

function var_0_0.clearList(arg_28_0)
	arg_28_0:clear()
	arg_28_0:reInit()
end

var_0_0.instance = var_0_0.New()

return var_0_0
