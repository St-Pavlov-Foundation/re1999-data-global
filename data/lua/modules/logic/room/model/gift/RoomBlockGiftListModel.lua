module("modules.logic.room.model.gift.RoomBlockGiftListModel", package.seeall)

local var_0_0 = class("RoomBlockGiftListModel", ListScrollModel)

function var_0_0.setMoList(arg_1_0, arg_1_1)
	arg_1_0._subType = RoomBlockGiftEnum.SubType[1]

	local var_1_0 = RoomBlockBuildingGiftModel.instance:getBlockIds(arg_1_1, arg_1_0._subType)
	local var_1_1 = {}

	arg_1_0._themeBlocks = {}
	arg_1_0._themeIds = {}

	local var_1_2 = RoomBlockBuildingGiftModel.instance:isAllColloctBySubType(arg_1_1, arg_1_0._subType)

	if var_1_0 then
		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			local var_1_3 = arg_1_0:getById(iter_1_1)

			if not var_1_3 then
				var_1_3 = RoomGiftShowBlockMo.New()

				var_1_3:init(iter_1_1, arg_1_0._subType)
			end

			if var_1_2 or not var_1_3:isCollect() then
				table.insert(var_1_1, var_1_3)
			end

			local var_1_4 = RoomConfig.instance:getThemeIdByItem(iter_1_1, arg_1_0._subType)

			if var_1_4 then
				if not arg_1_0._themeBlocks[var_1_4] then
					arg_1_0._themeBlocks[var_1_4] = {}
				end

				if not arg_1_0:isHasTheme(var_1_4) then
					table.insert(arg_1_0._themeIds, var_1_4)
				end

				table.insert(arg_1_0._themeBlocks[var_1_4], var_1_3)
			else
				logError("该地块包没找到主题:" .. iter_1_1)
			end
		end
	end

	arg_1_0:setList(var_1_1)
end

function var_0_0.onSort(arg_2_0)
	if RoomThemeFilterListModel.instance:getSelectCount() > 0 then
		arg_2_0:_sortThemeBlocks()
	else
		local var_2_0 = arg_2_0:getList()

		table.sort(var_2_0, arg_2_0._sort)
		arg_2_0:setList(var_2_0)
	end
end

function var_0_0._sort(arg_3_0, arg_3_1)
	if arg_3_0:isCollect() ~= arg_3_1:isCollect() then
		return arg_3_1:isCollect()
	end

	local var_3_0 = RoomBlockBuildingGiftModel.instance:getSortBlockRare()
	local var_3_1 = RoomBlockBuildingGiftModel.instance:getSortBlockNum()
	local var_3_2 = arg_3_0:getBlockNum()
	local var_3_3 = arg_3_1:getBlockNum()

	if var_3_0 ~= RoomBlockGiftEnum.SortType.None then
		if arg_3_0.rare == arg_3_1.rare and var_3_2 == var_3_3 then
			return arg_3_0.id < arg_3_1.id
		end

		if var_3_0 == RoomBlockGiftEnum.SortType.Order then
			return arg_3_0.rare > arg_3_1.rare
		end

		return arg_3_0.rare < arg_3_1.rare
	end

	if var_3_2 == var_3_3 then
		if arg_3_0.rare == arg_3_1.rare then
			return arg_3_0.id < arg_3_1.id
		end

		return arg_3_0.rare > arg_3_1.rare
	end

	if var_3_1 ~= RoomBlockGiftEnum.SortType.Reverse then
		return var_3_3 < var_3_2
	end

	return var_3_2 < var_3_3
end

function var_0_0.setThemeList(arg_4_0)
	RoomThemeFilterListModel.instance:initThemeData(arg_4_0._themeIds)
end

function var_0_0.isHasTheme(arg_5_0, arg_5_1)
	return LuaUtil.tableContains(arg_5_0._themeIds, arg_5_1)
end

function var_0_0.setThemeMoList(arg_6_0)
	arg_6_0._themeMoList = {}

	local var_6_0 = RoomThemeFilterListModel.instance:getSelectIdList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if arg_6_0:isHasTheme(iter_6_1) then
			local var_6_1 = {
				themeId = iter_6_1,
				moList = arg_6_0._themeBlocks[iter_6_1]
			}

			table.insert(arg_6_0._themeMoList, var_6_1)
		else
			RoomThemeFilterListModel.instance:setSelectById(iter_6_1, false)
		end
	end

	arg_6_0:_sortThemeBlocks()
end

function var_0_0.getThemeMoList(arg_7_0)
	return arg_7_0._themeMoList
end

function var_0_0._sortThemeBlocks(arg_8_0)
	if arg_8_0._themeMoList then
		table.sort(arg_8_0._themeMoList, arg_8_0._sortTheme)

		for iter_8_0, iter_8_1 in ipairs(arg_8_0._themeMoList) do
			table.sort(iter_8_1.moList, arg_8_0._sort)
		end

		RoomBlockGiftController.instance:dispatchEvent(RoomBlockGiftEvent.OnSortTheme)
	end
end

function var_0_0._sortTheme(arg_9_0, arg_9_1)
	if arg_9_0.themeId ~= arg_9_1.themeId then
		return arg_9_0.themeId > arg_9_1.themeId
	end
end

function var_0_0.initSelect(arg_10_0)
	local var_10_0 = RoomBlockBuildingGiftModel.instance:getSelectByType(arg_10_0._subType)

	if var_10_0 then
		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			local var_10_1 = arg_10_0:getById(iter_10_1)

			arg_10_0:onSelect(var_10_1, true)
		end
	end
end

function var_0_0.onSelect(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getIndex(arg_11_1)

	arg_11_0:selectCell(var_11_0, arg_11_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
