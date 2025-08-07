module("modules.logic.room.model.gift.RoomBlockBuildingGiftModel", package.seeall)

local var_0_0 = class("RoomBlockBuildingGiftModel", BaseModel)

function var_0_0.init(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	arg_3_0._selectSubType = nil
	arg_3_0._selectMo = nil
	arg_3_0._themeFilterList = nil

	RoomThemeFilterListModel.instance:clear()
end

function var_0_0.getGiftBlockMos(arg_4_0, arg_4_1)
	if not arg_4_0._blocksMos then
		arg_4_0._blocksMos = {}
	end

	local var_4_0 = arg_4_0._blocksMos[arg_4_1]

	if var_4_0 then
		return var_4_0
	end

	local var_4_1 = ItemConfig.instance:getItemCo(arg_4_1)
	local var_4_2 = {}
	local var_4_3 = GameUtil.splitString2(var_4_1.effect, true)

	for iter_4_0, iter_4_1 in ipairs(var_4_3) do
		for iter_4_2, iter_4_3 in ipairs(iter_4_1) do
			local var_4_4 = {
				RoomBlockGiftEnum.SubType[iter_4_0],
				iter_4_3
			}

			var_4_4[3] = 1

			table.insert(var_4_2, var_4_4)
		end
	end

	table.sort(var_4_2, arg_4_0._sortBlocks)

	arg_4_0._blocksMos[arg_4_1] = var_4_2

	return var_4_2
end

function var_0_0.getBlockIds(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0._blockTypeIds then
		arg_5_0._blockTypeIds = {}
	end

	if not arg_5_0._blockTypeIds[arg_5_1] then
		arg_5_0._blockTypeIds[arg_5_1] = {}
	end

	if arg_5_0._blockTypeIds[arg_5_1][arg_5_2] then
		return arg_5_0._blockTypeIds[arg_5_1][arg_5_2]
	end

	local var_5_0 = arg_5_0:getGiftBlockMos(arg_5_1)

	if var_5_0 then
		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			local var_5_1 = iter_5_1[1]

			if not arg_5_0._blockTypeIds[arg_5_1][var_5_1] then
				arg_5_0._blockTypeIds[arg_5_1][var_5_1] = {}
			end

			table.insert(arg_5_0._blockTypeIds[arg_5_1][var_5_1], iter_5_1[2])
		end
	end

	return arg_5_0._blockTypeIds[arg_5_1][arg_5_2]
end

function var_0_0._sortBlocks(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0[1]
	local var_6_1 = arg_6_0[2]
	local var_6_2 = arg_6_1[1]
	local var_6_3 = arg_6_1[2]
	local var_6_4 = ItemModel.instance:getItemConfig(var_6_0, var_6_1)
	local var_6_5 = ItemModel.instance:getItemConfig(var_6_2, var_6_3)

	if var_6_4.rare ~= var_6_5.rare then
		return var_6_4.rare > var_6_5.rare
	end

	if var_6_0 ~= var_6_2 then
		return var_6_0 == RoomBlockGiftEnum.SubType[2]
	end

	if var_6_0 == RoomBlockGiftEnum.SubType[2] then
		local var_6_6 = RoomConfig.instance:getBuildingConfig(var_6_1)
		local var_6_7 = RoomConfig.instance:getBuildingConfig(var_6_3)
		local var_6_8 = RoomConfig.instance:getBuildingAreaConfig(var_6_6.areaId)
		local var_6_9 = RoomConfig.instance:getBuildingAreaConfig(var_6_7.areaId)

		if var_6_8.occupy ~= var_6_9.occupy then
			return var_6_8.occupy > var_6_9.occupy
		end
	else
		local var_6_10 = RoomConfig.instance:getBlockListByPackageId(var_6_1)
		local var_6_11 = var_6_10 and #var_6_10 or 0
		local var_6_12 = RoomConfig.instance:getBlockListByPackageId(var_6_3)
		local var_6_13 = var_6_12 and #var_6_12 or 0

		if var_6_4.rare ~= var_6_5.rare then
			return var_6_13 < var_6_11
		end
	end

	return var_6_3 < var_6_1
end

function var_0_0.isAllColloct(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(RoomBlockGiftEnum.SubType) do
		if not arg_7_0:isAllColloctBySubType(arg_7_1, iter_7_1, false) then
			return false
		end
	end

	return true
end

function var_0_0.isAllColloctBySubType(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_2 = arg_8_2 or arg_8_0:getSelectSubType()

	local var_8_0 = arg_8_0:getBlockIds(arg_8_1, arg_8_2)
	local var_8_1 = arg_8_0:_isAllColloctType(arg_8_2, var_8_0)

	if var_8_1 and arg_8_3 then
		GameFacade.showToast(RoomBlockGiftEnum.SubTypeInfo[arg_8_2].AllColloctToast)
	end

	return var_8_1
end

function var_0_0._isAllColloctType(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 then
		for iter_9_0, iter_9_1 in pairs(arg_9_2) do
			local var_9_0 = ItemModel.instance:getItemQuantity(arg_9_1, iter_9_1)
			local var_9_1 = 1

			if arg_9_1 == RoomBlockGiftEnum.SubType[2] then
				var_9_1 = RoomConfig.instance:getBuildingConfig(iter_9_1).numLimit
			end

			if var_9_0 < var_9_1 then
				return false
			end
		end
	end

	return true
end

function var_0_0.getListModelInstance(arg_10_0, arg_10_1)
	arg_10_1 = arg_10_1 or RoomBlockGiftEnum.SubType[1]

	return RoomBlockGiftEnum.SubTypeInfo[arg_10_1].ListModel.instance
end

function var_0_0.setSelectSubType(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._selectSubType = arg_11_2

	arg_11_0:setThemeList()
	arg_11_0:getListModelInstance(arg_11_2):onModelUpdate()
	arg_11_0:isAllColloctBySubType(arg_11_1, arg_11_2, true)
end

function var_0_0.getSelectSubType(arg_12_0)
	return arg_12_0._selectSubType or RoomBlockGiftEnum.SubType[1]
end

function var_0_0.clickSortBlockRare(arg_13_0)
	arg_13_0._sortNumType = RoomBlockGiftEnum.SortType.None

	if not arg_13_0._sortRareType then
		arg_13_0._sortRareType = RoomBlockGiftEnum.SortType.Order

		return arg_13_0._sortRareType
	end

	if arg_13_0._sortRareType == RoomBlockGiftEnum.SortType.Order then
		arg_13_0._sortRareType = RoomBlockGiftEnum.SortType.Reverse
	else
		arg_13_0._sortRareType = RoomBlockGiftEnum.SortType.Order
	end

	return arg_13_0._sortRareType
end

function var_0_0.getSortBlockRare(arg_14_0)
	return arg_14_0._sortRareType
end

function var_0_0.clickSortBlockNum(arg_15_0)
	arg_15_0._sortRareType = RoomBlockGiftEnum.SortType.None

	if not arg_15_0._sortNumType then
		arg_15_0._sortNumType = RoomBlockGiftEnum.SortType.Order

		return arg_15_0._sortNumType
	end

	if arg_15_0._sortNumType == RoomBlockGiftEnum.SortType.Order then
		arg_15_0._sortNumType = RoomBlockGiftEnum.SortType.Reverse
	else
		arg_15_0._sortNumType = RoomBlockGiftEnum.SortType.Order
	end

	return arg_15_0._sortNumType
end

function var_0_0.getSortBlockNum(arg_16_0)
	return arg_16_0._sortNumType
end

function var_0_0.onOpenView(arg_17_0, arg_17_1)
	arg_17_0._sortNumType = RoomBlockGiftEnum.SortType.None
	arg_17_0._sortRareType = RoomBlockGiftEnum.SortType.Order

	arg_17_0:initSelect()
	arg_17_0:setThemeList()
	arg_17_0:isAllColloctBySubType(arg_17_1, arg_17_0._selectSubType, true)
end

function var_0_0.onCloseView(arg_18_0)
	arg_18_0:saveThemeFilter()
end

function var_0_0.initBlockBuilding(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in pairs(RoomBlockGiftEnum.SubType) do
		arg_19_0:getListModelInstance(iter_19_1):setMoList(arg_19_1)
	end

	arg_19_0._itemId = arg_19_1
end

function var_0_0.initSelect(arg_20_0)
	arg_20_0._selectMo = {}

	for iter_20_0, iter_20_1 in pairs(RoomBlockGiftEnum.SubType) do
		arg_20_0:getListModelInstance(iter_20_1):initSelect()
	end
end

function var_0_0.saveThemeFilter(arg_21_0)
	arg_21_0._themeFilterList = RoomThemeFilterListModel.instance:getSelectIdList()
end

function var_0_0.setThemeList(arg_22_0)
	arg_22_0:saveThemeFilter()

	local var_22_0 = arg_22_0:getListModelInstance(arg_22_0._selectSubType)

	var_22_0:setThemeList()

	if arg_22_0._themeFilterList then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0._themeFilterList) do
			if var_22_0:isHasTheme(iter_22_1) then
				RoomThemeFilterListModel.instance:setSelectById(iter_22_1, true)
			end
		end
	end
end

function var_0_0.onSort(arg_23_0)
	arg_23_0:getListModelInstance(arg_23_0._selectSubType):onSort()
end

function var_0_0.getThemeColloctCount(arg_24_0, arg_24_1)
	local var_24_0 = 0

	if arg_24_1 then
		for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
			if iter_24_1:isCollect() then
				var_24_0 = var_24_0 + 1
			end
		end
	end

	return var_24_0
end

function var_0_0.onSelect(arg_25_0, arg_25_1)
	if not arg_25_0._selectMo then
		arg_25_0._selectMo = {}
	end

	local var_25_0 = arg_25_1.subType
	local var_25_1 = arg_25_1.id
	local var_25_2 = false
	local var_25_3 = arg_25_0:getListModelInstance(arg_25_0._selectSubType)

	if not arg_25_0:isSelect(arg_25_1) then
		arg_25_0._selectMo.subType = var_25_0
		arg_25_0._selectMo.id = var_25_1
		var_25_2 = true
	else
		if arg_25_0._selectMo then
			local var_25_4 = var_25_3:getById(arg_25_0._selectMo.id)

			var_25_3:onSelect(var_25_4, false)
		end

		arg_25_0._selectMo = {}
	end

	var_25_3:onSelect(arg_25_1, var_25_2)

	return var_25_2
end

function var_0_0.isSelect(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1.subType
	local var_26_1 = arg_26_1.id

	if not arg_26_0._selectMo then
		return
	end

	return arg_26_0._selectMo.subType == var_26_0 and arg_26_0._selectMo.id == var_26_1
end

function var_0_0.getSelectCount(arg_27_0)
	return arg_27_0._selectMo and arg_27_0._selectMo.id and 1 or 0
end

function var_0_0.getSelectByType(arg_28_0, arg_28_1)
	return arg_28_0._selectMo and arg_28_0._selectMo[arg_28_1]
end

function var_0_0.clearSelect(arg_29_0)
	arg_29_0._selectMo = {}
end

function var_0_0.getMaxSelectCount(arg_30_0)
	return 1
end

function var_0_0.getSelectGoodsData(arg_31_0, arg_31_1)
	local var_31_0 = {}

	if arg_31_0._selectMo then
		local var_31_1 = arg_31_0._selectMo.subType
		local var_31_2 = arg_31_0._selectMo.id

		if var_31_1 and var_31_2 then
			local var_31_3 = var_31_2 * 10 + (RoomBlockGiftEnum.SubTypeInfo[var_31_1].SubType - 1)

			if var_31_3 then
				local var_31_4 = {
					quantity = 1,
					materialId = arg_31_1
				}

				table.insert(var_31_0, {
					data = {
						var_31_4
					},
					goodsId = var_31_3
				})
			end
		end
	end

	return var_31_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
