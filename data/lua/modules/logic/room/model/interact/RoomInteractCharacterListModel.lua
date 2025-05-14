module("modules.logic.room.model.interact.RoomInteractCharacterListModel", package.seeall)

local var_0_0 = class("RoomInteractCharacterListModel", ListScrollModel)

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
	arg_4_0:clearMapData()
	arg_4_0:clearFilterData()

	arg_4_0._heroMODict = nil
end

function var_0_0.clearMapData(arg_5_0)
	var_0_0.super.clear(arg_5_0)

	arg_5_0._selectHeroId = nil
end

function var_0_0.clearFilterData(arg_6_0)
	arg_6_0._filterCareerDict = {}
	arg_6_0._order = RoomCharacterEnum.CharacterOrderType.RareDown
end

function var_0_0.setCharacterList(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = HeroModel.instance:getList()

	arg_7_0._heroMODict = arg_7_0._heroMODict or {}

	local var_7_2 = RoomInteractBuildingModel.instance

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_3 = iter_7_1.config.career
		local var_7_4 = RoomConfig.instance:getRoomCharacterConfig(iter_7_1.skin)
		local var_7_5 = RoomCharacterModel.instance:getCharacterMOById(iter_7_1.heroId)

		if var_7_4 and var_7_5 then
			local var_7_6 = iter_7_1.heroId

			if arg_7_0:isFilterCareer(var_7_3) then
				local var_7_7 = arg_7_0._heroMODict[var_7_6]

				if not var_7_7 then
					var_7_7 = RoomInteractCharacterMO.New()

					var_7_7:init({
						use = false,
						heroId = var_7_6
					})

					arg_7_0._heroMODict[var_7_6] = var_7_7
				end

				var_7_7.use = var_7_2:isSelectHeroId(var_7_6)

				table.insert(var_7_0, var_7_7)
			end
		end
	end

	table.sort(var_7_0, arg_7_0:_getSortFunction())
	arg_7_0:setList(var_7_0)
	arg_7_0:_refreshSelect()
end

function var_0_0.updateCharacterList(arg_8_0)
	local var_8_0 = arg_8_0:getList()
	local var_8_1 = RoomInteractBuildingModel.instance

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		iter_8_1.use = var_8_1:isSelectHeroId(iter_8_1.heroId)
	end

	arg_8_0:onModelUpdate()
end

function var_0_0._getSortFunction(arg_9_0)
	if arg_9_0._sortFunc then
		return arg_9_0._sortFunc
	end

	function arg_9_0._sortFunc(arg_10_0, arg_10_1)
		if arg_10_0.heroConfig.rare ~= arg_10_1.heroConfig.rare then
			local var_10_0 = arg_9_0:getOrder()

			if var_10_0 == RoomCharacterEnum.CharacterOrderType.RareUp then
				return arg_10_0.heroConfig.rare < arg_10_1.heroConfig.rare
			elseif var_10_0 == RoomCharacterEnum.CharacterOrderType.RareDown then
				return arg_10_0.heroConfig.rare > arg_10_1.heroConfig.rare
			end
		end

		if arg_10_0.id ~= arg_10_1.id then
			return arg_10_0.id < arg_10_1.id
		end
	end

	return arg_9_0._sortFunc
end

function var_0_0.setOrder(arg_11_0, arg_11_1)
	arg_11_0._order = arg_11_1
end

function var_0_0.getOrder(arg_12_0)
	return arg_12_0._order
end

function var_0_0.setFilterCareer(arg_13_0, arg_13_1)
	arg_13_0._filterCareerDict = {}

	if arg_13_1 and #arg_13_1 > 0 then
		for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
			arg_13_0._filterCareerDict[iter_13_1] = true
		end
	end
end

function var_0_0.getFilterCareer(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._filterCareerDict) do
		if iter_14_1 == true then
			return iter_14_0
		end
	end
end

function var_0_0.isFilterCareer(arg_15_0, arg_15_1)
	return arg_15_0:isFilterCareerEmpty() or arg_15_0._filterCareerDict[arg_15_1]
end

function var_0_0.isFilterCareerEmpty(arg_16_0)
	return not LuaUtil.tableNotEmpty(arg_16_0._filterCareerDict)
end

function var_0_0.clearSelect(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0._scrollViews) do
		iter_17_1:setSelect(nil)
	end

	arg_17_0._selectHeroId = nil
end

function var_0_0._refreshSelect(arg_18_0)
	local var_18_0
	local var_18_1 = arg_18_0:getList()

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		if iter_18_1.id == arg_18_0._selectHeroId then
			var_18_0 = iter_18_1
		end
	end

	for iter_18_2, iter_18_3 in ipairs(arg_18_0._scrollViews) do
		iter_18_3:setSelect(var_18_0)
	end
end

function var_0_0.setSelect(arg_19_0, arg_19_1)
	arg_19_0._selectHeroId = arg_19_1

	arg_19_0:_refreshSelect()
end

function var_0_0.initCharacter(arg_20_0)
	arg_20_0:setCharacterList()
end

function var_0_0.initFilter(arg_21_0)
	arg_21_0:setFilterCareer()
end

function var_0_0.initOrder(arg_22_0)
	arg_22_0._order = RoomCharacterEnum.CharacterOrderType.RareDown
end

var_0_0.instance = var_0_0.New()

return var_0_0
