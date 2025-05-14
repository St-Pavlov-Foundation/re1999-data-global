module("modules.logic.room.model.critter.RoomTrainCritterListModel", package.seeall)

local var_0_0 = class("RoomTrainCritterListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0._clearData(arg_4_0)
	return
end

function var_0_0.setCritterList(arg_5_0, arg_5_1)
	arg_5_0._filterMO = arg_5_1

	if arg_5_0._sortAttrId == nil then
		arg_5_0._sortAttrId = CritterEnum.AttributeType.Efficiency
	end

	if arg_5_0._isSortHightToLow == nil then
		arg_5_0._isSortHightToLow = true
	end

	arg_5_0:updateCritterList()
end

function var_0_0.updateCritterList(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._filterMO
	local var_6_1 = {}
	local var_6_2 = {}
	local var_6_3 = CritterModel.instance:getList()

	for iter_6_0 = 1, #var_6_3 do
		local var_6_4 = var_6_3[iter_6_0]

		if var_6_4 and not var_6_4:isMaturity() then
			if var_6_4:isCultivating() and arg_6_1 ~= var_6_4.id or var_6_0 and not var_6_0:isPassedFilter(var_6_4) then
				var_6_2[var_6_4.id] = var_6_4
			else
				table.insert(var_6_1, var_6_4)
			end
		end
	end

	arg_6_0._trainCritterMODict = var_6_2

	table.sort(var_6_1, arg_6_0:_getSortFunction())
	arg_6_0:setList(var_6_1)
end

function var_0_0.sortByAttrId(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 ~= nil then
		arg_7_0._sortAttrId = arg_7_1
	end

	if arg_7_2 ~= nil then
		arg_7_0._isSortHightToLow = arg_7_2
	end

	arg_7_0:sort(arg_7_0:_getSortFunction())
end

function var_0_0._getSortFunction(arg_8_0)
	arg_8_0._trainHeroMO = RoomTrainHeroListModel.instance:getById(RoomTrainHeroListModel.instance:getSelectId())

	if arg_8_0._sortFunc then
		return arg_8_0._sortFunc
	end

	function arg_8_0._sortFunc(arg_9_0, arg_9_1)
		if arg_8_0._trainHeroMO then
			local var_9_0 = arg_8_0:_getCritterValue(arg_8_0._trainHeroMO, arg_9_0)
			local var_9_1 = arg_8_0:_getCritterValue(arg_8_0._trainHeroMO, arg_9_1)

			if var_9_0 ~= var_9_1 then
				return var_9_1 < var_9_0
			end
		end

		local var_9_2, var_9_3 = arg_8_0:_getAttrValue(arg_9_0, arg_8_0._sortAttrId)
		local var_9_4, var_9_5 = arg_8_0:_getAttrValue(arg_9_1, arg_8_0._sortAttrId)

		if var_9_3 ~= var_9_5 then
			if arg_8_0._isSortHightToLow then
				return var_9_5 < var_9_3
			end

			return var_9_3 < var_9_5
		end

		if var_9_2 ~= var_9_4 then
			if arg_8_0._isSortHightToLow then
				return var_9_4 < var_9_2
			end

			return var_9_2 < var_9_4
		end

		return CritterHelper.sortByTotalAttrValue(arg_9_0, arg_9_1)
	end

	return arg_8_0._sortFunc
end

function var_0_0._getCritterValue(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1:chcekPrefernectCritterId(arg_10_2:getDefineId()) then
		local var_10_0 = arg_10_1:getPrefernectType()

		if var_10_0 == CritterEnum.PreferenceType.All then
			return 110
		elseif var_10_0 == CritterEnum.PreferenceType.Catalogue then
			return 120
		elseif var_10_0 == CritterEnum.PreferenceType.Critter then
			return 130
		end

		return 10
	end

	return 0
end

function var_0_0._getAttrValue(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 == CritterEnum.AttributeType.Efficiency then
		return arg_11_1.efficiency, arg_11_1.efficiencyIncrRate
	elseif arg_11_2 == CritterEnum.AttributeType.Patience then
		return arg_11_1.patience, arg_11_1.patienceIncrRate
	elseif arg_11_2 == CritterEnum.AttributeType.Lucky then
		return arg_11_1.lucky, arg_11_1.luckyIncrRate
	end

	return 0
end

function var_0_0.getSortAttrId(arg_12_0)
	return arg_12_0._sortAttrId
end

function var_0_0.getSortIsHightToLow(arg_13_0)
	return arg_13_0._isSortHightToLow
end

function var_0_0.clearSelect(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._scrollViews) do
		iter_14_1:setSelect(nil)
	end

	arg_14_0._selectUid = nil
end

function var_0_0._refreshSelect(arg_15_0)
	local var_15_0 = arg_15_0:getById(arg_15_0._selectUid)

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._scrollViews) do
		iter_15_1:setSelect(var_15_0)
	end
end

function var_0_0.setSelect(arg_16_0, arg_16_1)
	arg_16_0._selectUid = arg_16_1

	arg_16_0:_refreshSelect()
end

function var_0_0.getSelectId(arg_17_0)
	return arg_17_0._selectUid
end

function var_0_0.getById(arg_18_0, arg_18_1)
	return var_0_0.super.getById(arg_18_0, arg_18_1) or arg_18_0._trainCritterMODict and arg_18_0._trainCritterMODict[arg_18_1]
end

function var_0_0.setFilterResType(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0._filterIncludeList = {}
	arg_19_0._filterExcludeList = {}

	arg_19_0:_setList(arg_19_0._filterIncludeList, arg_19_1)
	arg_19_0:_setList(arg_19_0._filterExcludeList, arg_19_2)
end

function var_0_0.isFilterType(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_0:_isSameValue(arg_20_0._filterIncludeList, arg_20_1) and arg_20_0:_isSameValue(arg_20_0._filterExcludeList, arg_20_2) then
		return true
	end

	return false
end

function var_0_0.isFilterTypeEmpty(arg_21_0)
	return arg_21_0:_isEmptyList(arg_21_0._filterTypeList)
end

function var_0_0._setList(arg_22_0, arg_22_1, arg_22_2)
	tabletool.addValues(arg_22_1, arg_22_2)
end

function var_0_0._isListValue(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_2 and tabletool.indexOf(arg_23_1, arg_23_2) then
		return true
	end

	return false
end

function var_0_0._isSameValue(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0:_isEmptyList(arg_24_1) and arg_24_0:_isEmptyList(arg_24_2) then
		return true
	end

	if #arg_24_1 ~= #arg_24_2 then
		return false
	end

	for iter_24_0, iter_24_1 in ipairs(arg_24_2) do
		if not tabletool.indexOf(arg_24_1, iter_24_1) then
			return false
		end
	end

	for iter_24_2, iter_24_3 in ipairs(arg_24_1) do
		if not tabletool.indexOf(arg_24_2, iter_24_3) then
			return false
		end
	end

	return true
end

function var_0_0._isEmptyList(arg_25_0, arg_25_1)
	return arg_25_1 == nil or #arg_25_1 < 1
end

var_0_0.instance = var_0_0.New()

return var_0_0
