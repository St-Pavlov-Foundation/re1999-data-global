module("modules.logic.room.model.gift.RoomBuildingGiftListModel", package.seeall)

local var_0_0 = class("RoomBuildingGiftListModel", ListScrollModel)

function var_0_0.initMoList(arg_1_0)
	arg_1_0._subType = MaterialEnum.MaterialType.Building

	for iter_1_0, iter_1_1 in ipairs(room_building.configList) do
		if iter_1_1.canExchange then
			local var_1_0 = iter_1_1.rare
			local var_1_1 = arg_1_0._moList[var_1_0]

			if not var_1_1 then
				var_1_1 = {}
				arg_1_0._moList[var_1_0] = var_1_1
			end

			local var_1_2 = RoomGiftShowBuildingMo.New()

			var_1_2:init(iter_1_1)
			table.insert(var_1_1, var_1_2)
		end
	end

	for iter_1_2 = 1, 5 do
		local var_1_3 = arg_1_0._moList[iter_1_2]
		local var_1_4 = arg_1_0._moList[iter_1_2 - 1]

		if var_1_4 then
			if var_1_3 then
				tabletool.addValues(arg_1_0._moList[iter_1_2], var_1_4)
			else
				arg_1_0._moList[iter_1_2] = var_1_4
			end
		end
	end

	arg_1_0._subTypeInfo = RoomBlockGiftEnum.SubTypeInfo[arg_1_0._subType]
end

function var_0_0.getRareMoList(arg_2_0, arg_2_1)
	if not arg_2_0._moList then
		arg_2_0._moList = {}

		arg_2_0:initMoList()
	end

	return arg_2_0._moList[arg_2_1]
end

function var_0_0.setMoList(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getRareMoList(arg_3_1)
	local var_3_1 = {}

	arg_3_0._themeBuilding = {}
	arg_3_0._themeIds = {}

	if var_3_0 then
		local var_3_2 = arg_3_0:isAllColloct(arg_3_1)

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if var_3_2 or not iter_3_1:isCollect() then
				table.insert(var_3_1, iter_3_1)
			end

			local var_3_3 = RoomConfig.instance:getThemeIdByItem(iter_3_1.id, iter_3_1.subType)

			if var_3_3 then
				if not arg_3_0._themeBuilding[var_3_3] then
					arg_3_0._themeBuilding[var_3_3] = {}
				end

				if not arg_3_0:isHasTheme(var_3_3) then
					table.insert(arg_3_0._themeIds, var_3_3)
				end

				table.insert(arg_3_0._themeBuilding[var_3_3], iter_3_1)
			else
				logError("该建筑没找到主题:" .. iter_3_1.id)
			end
		end
	end

	table.sort(var_3_1, arg_3_0._sort)
	arg_3_0:setList(var_3_1)
end

function var_0_0.openSubType(arg_4_0, arg_4_1)
	arg_4_0:onModelUpdate()

	if arg_4_0:isAllColloct(arg_4_1) then
		GameFacade.showToast(arg_4_0._subTypeInfo.AllColloctToast)
	end
end

function var_0_0.isAllColloct(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getRareMoList(arg_5_1)

	if not var_5_0 then
		return true
	end

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if not iter_5_1:isCollect() then
			return false
		end
	end

	return true
end

function var_0_0.onSort(arg_6_0)
	if RoomThemeFilterListModel.instance:getSelectCount() > 0 then
		arg_6_0:_sortThemeBuilding()
	else
		local var_6_0 = arg_6_0:getList()

		table.sort(var_6_0, arg_6_0._sort)
		arg_6_0:setList(var_6_0)
	end
end

function var_0_0._sort(arg_7_0, arg_7_1)
	if arg_7_0:isCollect() ~= arg_7_1:isCollect() then
		return arg_7_1:isCollect()
	end

	local var_7_0 = RoomBlockBuildingGiftModel.instance:getSortBlockRare()
	local var_7_1 = RoomBlockBuildingGiftModel.instance:getSortBlockNum()
	local var_7_2 = arg_7_0:getBuildingAreaConfig().occupy
	local var_7_3 = arg_7_1:getBuildingAreaConfig().occupy

	if var_7_0 ~= RoomBlockGiftEnum.SortType.None then
		if arg_7_0.rare == arg_7_1.rare and var_7_2 == var_7_3 then
			return arg_7_0.id < arg_7_1.id
		end

		if var_7_0 == RoomBlockGiftEnum.SortType.Order then
			return arg_7_0.rare > arg_7_1.rare
		end

		return arg_7_0.rare < arg_7_1.rare
	end

	if var_7_2 == var_7_3 then
		if arg_7_0.rare == arg_7_1.rare then
			return arg_7_0.id < arg_7_1.id
		end

		return arg_7_0.rare > arg_7_1.rare
	end

	if var_7_1 ~= RoomBlockGiftEnum.SortType.Reverse then
		return var_7_3 < var_7_2
	end

	return var_7_2 < var_7_3
end

function var_0_0.isHasTheme(arg_8_0, arg_8_1)
	return LuaUtil.tableContains(arg_8_0._themeIds, arg_8_1)
end

function var_0_0.setThemeList(arg_9_0)
	RoomThemeFilterListModel.instance:initThemeData(arg_9_0._themeIds)
end

function var_0_0.setThemeMoList(arg_10_0)
	arg_10_0._themeMoList = {}

	local var_10_0 = RoomThemeFilterListModel.instance:getSelectIdList()
	local var_10_1 = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if arg_10_0:isHasTheme(iter_10_1) then
			local var_10_2 = {
				themeId = iter_10_1,
				moList = arg_10_0._themeBuilding[iter_10_1]
			}

			table.insert(arg_10_0._themeMoList, var_10_2)
		else
			table.insert(var_10_1, iter_10_1)
		end
	end

	for iter_10_2, iter_10_3 in ipairs(var_10_1) do
		RoomThemeFilterListModel.instance:setSelectById(iter_10_3, false)
	end

	arg_10_0:_sortThemeBuilding()
end

function var_0_0.getThemeMoList(arg_11_0)
	return arg_11_0._themeMoList
end

function var_0_0._sortThemeBuilding(arg_12_0)
	if arg_12_0._themeMoList then
		table.sort(arg_12_0._themeMoList, arg_12_0._sortTheme)

		for iter_12_0, iter_12_1 in ipairs(arg_12_0._themeMoList) do
			table.sort(iter_12_1.moList, arg_12_0._sort)
		end

		RoomBlockGiftController.instance:dispatchEvent(RoomBlockGiftEvent.OnSortTheme)
	end
end

function var_0_0._sortTheme(arg_13_0, arg_13_1)
	if arg_13_0.themeId ~= arg_13_1.themeId then
		return arg_13_0.themeId > arg_13_1.themeId
	end
end

function var_0_0.onSelect(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1.isSelect = arg_14_2

	local var_14_0 = arg_14_0:getIndex(arg_14_1)

	arg_14_0:selectCell(var_14_0, arg_14_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
