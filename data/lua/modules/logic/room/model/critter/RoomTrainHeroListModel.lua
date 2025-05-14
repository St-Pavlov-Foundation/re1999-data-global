module("modules.logic.room.model.critter.RoomTrainHeroListModel", package.seeall)

local var_0_0 = class("RoomTrainHeroListModel", ListScrollModel)

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
	arg_4_0:clearData()
	arg_4_0:clearFilterData()
end

function var_0_0.clearData(arg_5_0)
	var_0_0.super.clear(arg_5_0)

	arg_5_0._selectHeroId = nil
end

function var_0_0.clearFilterData(arg_6_0)
	arg_6_0._order = RoomCharacterEnum.CharacterOrderType.RareDown
end

function var_0_0.setHeroList(arg_7_0, arg_7_1)
	arg_7_0.critterFilterMO = arg_7_1

	arg_7_0:updateHeroList()
end

function var_0_0.updateHeroList(arg_8_0, arg_8_1)
	local var_8_0 = CritterModel.instance:getCultivatingCritters()
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if arg_8_1 ~= iter_8_1.trainInfo.heroId then
			var_8_1[iter_8_1.trainInfo.heroId] = true
		end
	end

	local var_8_2 = {}

	arg_8_0._trainHeroMODict = arg_8_0._trainHeroMODict or {}

	local var_8_3 = HeroModel.instance:getList()
	local var_8_4 = CritterConfig.instance
	local var_8_5 = arg_8_0:_isHasFilterType(CritterEnum.FilterType.Race)

	for iter_8_2, iter_8_3 in ipairs(var_8_3) do
		if var_8_4:getCritterHeroPreferenceCfg(iter_8_3.heroId) ~= nil then
			local var_8_6 = arg_8_0:getById(iter_8_3.heroId)

			if var_8_6 == nil then
				var_8_6 = RoomTrainHeroMO.New()

				var_8_6:initHeroMO(iter_8_3)

				arg_8_0._trainHeroMODict[iter_8_3.heroId] = var_8_6
			else
				var_8_6:updateSkinId(iter_8_3.skin)
			end

			if var_8_1[iter_8_3.heroId] or var_8_5 and not arg_8_0:_checkFilterisPass(var_8_6) then
				-- block empty
			else
				table.insert(var_8_2, var_8_6)
			end
		end
	end

	table.sort(var_8_2, arg_8_0:_getSortFunction())
	arg_8_0:setList(var_8_2)
	arg_8_0:_refreshSelect()
end

function var_0_0._isHasFilterType(arg_9_0, arg_9_1)
	if arg_9_0.critterFilterMO then
		local var_9_0 = arg_9_0.critterFilterMO:getFilterCategoryDict()
		local var_9_1 = var_9_0 and var_9_0[arg_9_1]

		if var_9_1 and #var_9_1 > 0 then
			return true
		end
	end

	return false
end

function var_0_0._checkFilterisPass(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:getPrefernectType()
	local var_10_1 = arg_10_1:getPrefernectIds()

	if var_10_0 == CritterEnum.PreferenceType.All then
		return true
	elseif var_10_0 == CritterEnum.PreferenceType.Catalogue then
		for iter_10_0 = 1, #var_10_1 do
			if arg_10_0.critterFilterMO:checkRaceByCatalogueId(var_10_1[var_10_1]) then
				return true
			end
		end
	elseif var_10_0 == CritterEnum.PreferenceType.Critter then
		for iter_10_1 = 1, #var_10_1 do
			local var_10_2 = CritterConfig.instance:getCritterCatalogue(var_10_1[iter_10_1])

			if arg_10_0.critterFilterMO:checkRaceByCatalogueId(var_10_2) then
				return true
			end
		end
	end

	return false
end

function var_0_0.sortByAttrId(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 ~= nil then
		arg_11_0._sortAttrId = arg_11_1
	end

	if arg_11_2 ~= nil then
		arg_11_0._isSortHightToLow = arg_11_2
	end

	arg_11_0:sort(arg_11_0:_getSortFunction())
end

function var_0_0._getSortFunction(arg_12_0)
	arg_12_0._critterMO = RoomTrainCritterListModel.instance:getById(RoomTrainCritterListModel.instance:getSelectId())

	if arg_12_0._sortFunc then
		return arg_12_0._sortFunc
	end

	function arg_12_0._sortFunc(arg_13_0, arg_13_1)
		if arg_12_0._critterMO then
			local var_13_0 = arg_12_0:_getCritterValue(arg_13_0, arg_12_0._critterMO)
			local var_13_1 = arg_12_0:_getCritterValue(arg_13_1, arg_12_0._critterMO)

			if var_13_0 ~= var_13_1 then
				return var_13_1 < var_13_0
			end
		end

		local var_13_2 = arg_12_0:_getAttrValue(arg_13_0, arg_12_0._sortAttrId)
		local var_13_3 = arg_12_0:_getAttrValue(arg_13_1, arg_12_0._sortAttrId)

		if var_13_2 ~= var_13_3 then
			if arg_12_0._isSortHightToLow then
				return var_13_3 < var_13_2
			end

			return var_13_2 < var_13_3
		end

		if arg_13_0.heroConfig.rare ~= arg_13_1.heroConfig.rare then
			return arg_13_0.heroConfig.rare > arg_13_1.heroConfig.rare
		end

		if arg_13_0.heroId ~= arg_13_1.heroId then
			return arg_13_0.heroId > arg_13_1.heroId
		end
	end

	return arg_12_0._sortFunc
end

function var_0_0._getAttrValue(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1:getAttributeInfoMO().attributeId == arg_14_2 then
		return 100
	end

	return 0
end

function var_0_0._getCritterValue(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1:chcekPrefernectCritterId(arg_15_2:getDefineId()) then
		local var_15_0 = arg_15_1:getPrefernectType()

		if var_15_0 == CritterEnum.PreferenceType.All then
			return 110
		elseif var_15_0 == CritterEnum.PreferenceType.Catalogue then
			return 120
		elseif var_15_0 == CritterEnum.PreferenceType.Critter then
			return 130
		end

		return 10
	end

	return 0
end

function var_0_0.setOrder(arg_16_0, arg_16_1)
	arg_16_0._order = arg_16_1
end

function var_0_0.getOrder(arg_17_0)
	return arg_17_0._order
end

function var_0_0.getById(arg_18_0, arg_18_1)
	return var_0_0.super.getById(arg_18_0, arg_18_1) or arg_18_0._trainHeroMODict and arg_18_0._trainHeroMODict[arg_18_1]
end

function var_0_0.clearSelect(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0._scrollViews) do
		iter_19_1:setSelect(nil)
	end

	arg_19_0._selectHeroId = nil
end

function var_0_0._refreshSelect(arg_20_0)
	local var_20_0 = arg_20_0:getById(arg_20_0._selectHeroId)

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._scrollViews) do
		iter_20_1:setSelect(var_20_0)
	end
end

function var_0_0.getSelectId(arg_21_0)
	return arg_21_0._selectHeroId
end

function var_0_0.setSelect(arg_22_0, arg_22_1)
	arg_22_0._selectHeroId = arg_22_1

	arg_22_0:_refreshSelect()
end

function var_0_0.initFilter(arg_23_0)
	arg_23_0:setFilterCareer()
end

function var_0_0.initOrder(arg_24_0)
	arg_24_0._order = RoomCharacterEnum.CharacterOrderType.RareDown
end

var_0_0.instance = var_0_0.New()

return var_0_0
