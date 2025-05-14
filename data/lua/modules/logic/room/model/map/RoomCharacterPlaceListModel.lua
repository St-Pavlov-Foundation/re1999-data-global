module("modules.logic.room.model.map.RoomCharacterPlaceListModel", package.seeall)

local var_0_0 = class("RoomCharacterPlaceListModel", ListScrollModel)

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
end

function var_0_0.clearMapData(arg_5_0)
	var_0_0.super.clear(arg_5_0)

	arg_5_0._selectHeroId = nil
end

function var_0_0.clearFilterData(arg_6_0)
	arg_6_0._filterCareerDict = {}
	arg_6_0._order = RoomCharacterEnum.CharacterOrderType.RareDown

	arg_6_0:setIsFilterOnBirthday()
end

function var_0_0.setCharacterPlaceList(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = HeroModel.instance:getList()

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_2 = iter_7_1.config.career

		if RoomConfig.instance:getRoomCharacterConfig(iter_7_1.skin) then
			local var_7_3 = arg_7_0:isFilterCareer(var_7_2)

			if arg_7_0:isFilterBirthday(iter_7_1.heroId) and var_7_3 then
				local var_7_4 = RoomCharacterModel.instance:getCharacterMOById(iter_7_1.heroId)
				local var_7_5 = var_7_4 and var_7_4:isPlaceSourceState() and (var_7_4.characterState == RoomCharacterEnum.CharacterState.Map or var_7_4.characterState == RoomCharacterEnum.CharacterState.Revert)
				local var_7_6 = RoomCharacterPlaceMO.New()

				var_7_6:init({
					heroId = iter_7_1.heroId,
					use = var_7_5
				})
				table.insert(var_7_0, var_7_6)
			end
		end
	end

	table.sort(var_7_0, arg_7_0._sortFunction)
	arg_7_0:setList(var_7_0)
	arg_7_0:_refreshSelect()
end

function var_0_0._sortFunction(arg_8_0, arg_8_1)
	if arg_8_0.use and not arg_8_1.use then
		return true
	elseif not arg_8_0.use and arg_8_1.use then
		return false
	end

	local var_8_0 = var_0_0.instance._selectHeroId

	if var_8_0 and not arg_8_0.use and not arg_8_1.use then
		if arg_8_0.heroId == var_8_0 and arg_8_1.heroId ~= var_8_0 then
			return true
		elseif arg_8_0.heroId ~= var_8_0 and arg_8_1.heroId == var_8_0 then
			return false
		end
	end

	local var_8_1 = var_0_0.instance:getOrder()

	if var_8_1 == RoomCharacterEnum.CharacterOrderType.RareUp and arg_8_0.heroConfig.rare ~= arg_8_1.heroConfig.rare then
		return arg_8_0.heroConfig.rare < arg_8_1.heroConfig.rare
	elseif var_8_1 == RoomCharacterEnum.CharacterOrderType.RareDown and arg_8_0.heroConfig.rare ~= arg_8_1.heroConfig.rare then
		return arg_8_0.heroConfig.rare > arg_8_1.heroConfig.rare
	end

	local var_8_2 = HeroConfig.instance:getFaithPercent(arg_8_0.heroMO.faith)[1]
	local var_8_3 = HeroConfig.instance:getFaithPercent(arg_8_1.heroMO.faith)[1]

	if var_8_1 == RoomCharacterEnum.CharacterOrderType.FaithUp then
		if var_8_2 ~= var_8_3 then
			return var_8_2 < var_8_3
		end

		if arg_8_0.heroConfig.rare ~= arg_8_1.heroConfig.rare then
			return arg_8_0.heroConfig.rare > arg_8_1.heroConfig.rare
		end
	elseif var_8_1 == RoomCharacterEnum.CharacterOrderType.FaithDown then
		if var_8_2 ~= var_8_3 then
			return var_8_3 < var_8_2
		end

		if arg_8_0.heroConfig.rare ~= arg_8_1.heroConfig.rare then
			return arg_8_0.heroConfig.rare > arg_8_1.heroConfig.rare
		end
	end

	local var_8_4 = RoomCharacterModel.instance:isOnBirthday(arg_8_0.heroId)

	if var_8_4 ~= RoomCharacterModel.instance:isOnBirthday(arg_8_1.heroId) then
		return var_8_4
	end

	return arg_8_0.id < arg_8_1.id
end

function var_0_0.setOrder(arg_9_0, arg_9_1)
	arg_9_0._order = arg_9_1
end

function var_0_0.getOrder(arg_10_0)
	return arg_10_0._order
end

function var_0_0.setFilterCareer(arg_11_0, arg_11_1)
	arg_11_0._filterCareerDict = {}

	if arg_11_1 and #arg_11_1 > 0 then
		for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
			arg_11_0._filterCareerDict[iter_11_1] = true
		end
	end

	arg_11_0:setIsFilterOnBirthday()
end

function var_0_0.getFilterCareer(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._filterCareerDict) do
		if iter_12_1 == true then
			return iter_12_0
		end
	end
end

function var_0_0.isFilterCareer(arg_13_0, arg_13_1)
	return arg_13_0:isFilterCareerEmpty() or arg_13_0._filterCareerDict[arg_13_1]
end

function var_0_0.isFilterCareerEmpty(arg_14_0)
	return not LuaUtil.tableNotEmpty(arg_14_0._filterCareerDict)
end

function var_0_0.getIsFilterOnBirthday(arg_15_0)
	return arg_15_0._isFilterOnBirthday
end

function var_0_0.setIsFilterOnBirthday(arg_16_0, arg_16_1)
	arg_16_0._isFilterOnBirthday = arg_16_1
end

function var_0_0.isFilterBirthday(arg_17_0, arg_17_1)
	local var_17_0 = true
	local var_17_1 = arg_17_0:getIsFilterOnBirthday()

	if arg_17_1 and var_17_1 then
		var_17_0 = RoomCharacterModel.instance:isOnBirthday(arg_17_1)
	end

	return var_17_0
end

function var_0_0.hasHeroOnBirthday(arg_18_0)
	local var_18_0 = false
	local var_18_1 = arg_18_0:getList()

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		if RoomCharacterModel.instance:isOnBirthday(iter_18_1.id) then
			var_18_0 = true

			break
		end
	end

	return var_18_0
end

function var_0_0.clearSelect(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0._scrollViews) do
		iter_19_1:setSelect(nil)
	end

	arg_19_0._selectHeroId = nil
end

function var_0_0._refreshSelect(arg_20_0)
	local var_20_0
	local var_20_1 = arg_20_0:getList()

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		if iter_20_1.id == arg_20_0._selectHeroId then
			var_20_0 = iter_20_1
		end
	end

	for iter_20_2, iter_20_3 in ipairs(arg_20_0._scrollViews) do
		iter_20_3:setSelect(var_20_0)
	end
end

function var_0_0.setSelect(arg_21_0, arg_21_1)
	arg_21_0._selectHeroId = arg_21_1

	arg_21_0:_refreshSelect()
end

function var_0_0.initCharacterPlace(arg_22_0)
	arg_22_0:setCharacterPlaceList()
end

function var_0_0.initFilter(arg_23_0)
	arg_23_0:setFilterCareer()
end

function var_0_0.initOrder(arg_24_0)
	arg_24_0._order = RoomCharacterEnum.CharacterOrderType.RareDown
end

var_0_0.instance = var_0_0.New()

return var_0_0
