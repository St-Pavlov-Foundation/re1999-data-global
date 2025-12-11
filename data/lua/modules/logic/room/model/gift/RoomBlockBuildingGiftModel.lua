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

	local var_4_1 = ItemConfig.instance:getItemCo(arg_4_1).rare
	local var_4_2 = {}
	local var_4_3 = RoomBuildingGiftListModel.instance:getRareMoList(var_4_1)

	table.sort(var_4_3, arg_4_0._sortBuilding)

	for iter_4_0, iter_4_1 in pairs(var_4_3) do
		local var_4_4 = {
			iter_4_1.subType,
			iter_4_1.id,
			1
		}

		table.insert(var_4_2, var_4_4)
	end

	local var_4_5 = RoomBlockGiftListModel.instance:getRareMoList(var_4_1)

	table.sort(var_4_5, arg_4_0._sortBlock)

	for iter_4_2, iter_4_3 in pairs(var_4_5) do
		local var_4_6 = {
			iter_4_3.subType,
			iter_4_3.id,
			1
		}

		table.insert(var_4_2, var_4_6)
	end

	return var_4_2
end

function var_0_0.getSubTypeListModelInstance(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_1 or arg_5_0:getSelectSubType()

	return RoomBlockGiftEnum.SubTypeInfo[arg_5_1].ListModel.instance
end

function var_0_0._sortBlock(arg_6_0, arg_6_1)
	if arg_6_0.rare ~= arg_6_1.rare then
		return arg_6_0.rare > arg_6_1.rare
	end

	local var_6_0 = RoomConfig.instance:getBlockListByPackageId(arg_6_0.id)
	local var_6_1 = var_6_0 and #var_6_0 or 0
	local var_6_2 = RoomConfig.instance:getBlockListByPackageId(arg_6_1.id)
	local var_6_3 = var_6_2 and #var_6_2 or 0

	if var_6_1 ~= var_6_3 then
		return var_6_3 < var_6_1
	end

	return arg_6_0.id > arg_6_1.id
end

function var_0_0._sortBuilding(arg_7_0, arg_7_1)
	if arg_7_0.rare ~= arg_7_1.rare then
		return arg_7_0.rare > arg_7_1.rare
	end

	local var_7_0 = RoomConfig.instance:getBuildingConfig(arg_7_0.id)
	local var_7_1 = RoomConfig.instance:getBuildingConfig(arg_7_1.id)
	local var_7_2 = RoomConfig.instance:getBuildingAreaConfig(var_7_0.areaId)
	local var_7_3 = RoomConfig.instance:getBuildingAreaConfig(var_7_1.areaId)

	if var_7_2.occupy ~= var_7_3.occupy then
		return var_7_2.occupy > var_7_3.occupy
	end

	return arg_7_0.id > arg_7_1.id
end

function var_0_0.isAllColloct(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(RoomBlockGiftEnum.SubTypeInfo) do
		if not iter_8_1.ListModel.instance:isAllColloct(arg_8_1) then
			return false
		end
	end

	return true
end

function var_0_0.getSelectSubType(arg_9_0)
	return arg_9_0._selectSubType or MaterialEnum.MaterialType.BlockPackage
end

function var_0_0.clickSortBlockRare(arg_10_0)
	arg_10_0._sortNumType = RoomBlockGiftEnum.SortType.None

	if not arg_10_0._sortRareType then
		arg_10_0._sortRareType = RoomBlockGiftEnum.SortType.Order

		return arg_10_0._sortRareType
	end

	if arg_10_0._sortRareType == RoomBlockGiftEnum.SortType.Order then
		arg_10_0._sortRareType = RoomBlockGiftEnum.SortType.Reverse
	else
		arg_10_0._sortRareType = RoomBlockGiftEnum.SortType.Order
	end

	return arg_10_0._sortRareType
end

function var_0_0.getSortBlockRare(arg_11_0)
	return arg_11_0._sortRareType
end

function var_0_0.clickSortBlockNum(arg_12_0)
	arg_12_0._sortRareType = RoomBlockGiftEnum.SortType.None

	if not arg_12_0._sortNumType then
		arg_12_0._sortNumType = RoomBlockGiftEnum.SortType.Order

		return arg_12_0._sortNumType
	end

	if arg_12_0._sortNumType == RoomBlockGiftEnum.SortType.Order then
		arg_12_0._sortNumType = RoomBlockGiftEnum.SortType.Reverse
	else
		arg_12_0._sortNumType = RoomBlockGiftEnum.SortType.Order
	end

	return arg_12_0._sortNumType
end

function var_0_0.getSortBlockNum(arg_13_0)
	return arg_13_0._sortNumType
end

function var_0_0.onOpenView(arg_14_0, arg_14_1)
	arg_14_0._sortNumType = RoomBlockGiftEnum.SortType.None
	arg_14_0._sortRareType = RoomBlockGiftEnum.SortType.Order

	arg_14_0:clearSelect()
	arg_14_0:initSelect()
	arg_14_0:setThemeList()

	arg_14_0._rare = arg_14_1

	arg_14_0:openSubType(MaterialEnum.MaterialType.BlockPackage)
end

function var_0_0.openSubType(arg_15_0, arg_15_1)
	var_0_0.instance:setThemeList()
	arg_15_0:getSubTypeListModelInstance(arg_15_1):openSubType(arg_15_0._rare)

	arg_15_0._selectSubType = arg_15_1
end

function var_0_0.onCloseView(arg_16_0)
	arg_16_0:saveThemeFilter()
end

function var_0_0.initBlockBuilding(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in pairs(RoomBlockGiftEnum.SubTypeInfo) do
		iter_17_1.ListModel.instance:setMoList(arg_17_1)
	end
end

function var_0_0.initSelect(arg_18_0)
	return
end

function var_0_0.saveThemeFilter(arg_19_0)
	arg_19_0._themeFilterList = RoomThemeFilterListModel.instance:getSelectIdList()
end

function var_0_0.setThemeList(arg_20_0)
	arg_20_0:saveThemeFilter()

	local var_20_0 = arg_20_0:getSubTypeListModelInstance(arg_20_0:getSelectSubType())

	var_20_0:setThemeList()

	if arg_20_0._themeFilterList then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0._themeFilterList) do
			if var_20_0:isHasTheme(iter_20_1) then
				RoomThemeFilterListModel.instance:setSelectById(iter_20_1, true)
			end
		end
	end
end

function var_0_0.onSort(arg_21_0)
	arg_21_0:getSubTypeListModelInstance(arg_21_0:getSelectSubType()):onSort()
end

function var_0_0.getThemeColloctCount(arg_22_0, arg_22_1)
	local var_22_0 = 0

	if arg_22_1 then
		for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
			if iter_22_1:isCollect() then
				var_22_0 = var_22_0 + 1
			end
		end
	end

	return var_22_0
end

function var_0_0.onSelect(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.subType
	local var_23_1 = arg_23_0:getSubTypeListModelInstance(var_23_0)

	if arg_23_1.isSelect then
		var_23_1:onSelect(arg_23_1, false)

		arg_23_0._selectMo = nil
	else
		if arg_23_0._selectMo then
			arg_23_0:getSubTypeListModelInstance(arg_23_0._selectMo.subType):onSelect(arg_23_0._selectMo, false)
		end

		var_23_1:onSelect(arg_23_1, true)

		arg_23_0._selectMo = arg_23_1
	end
end

function var_0_0.clearSelect(arg_24_0)
	if arg_24_0._selectMo then
		local var_24_0 = arg_24_0._selectMo.subType

		arg_24_0:getSubTypeListModelInstance(var_24_0):onSelect(arg_24_0._selectMo, false)

		arg_24_0._selectMo = nil
	end
end

function var_0_0.getSelectCount(arg_25_0)
	return arg_25_0._selectMo and 1 or 0
end

function var_0_0.getMaxSelectCount(arg_26_0)
	return 1
end

function var_0_0.getSelectGoodsData(arg_27_0, arg_27_1)
	if arg_27_0._selectMo then
		local var_27_0 = arg_27_0._selectMo.subType
		local var_27_1 = arg_27_0._selectMo.id

		if var_27_0 and var_27_1 then
			local var_27_2 = var_27_1 * 10 + (arg_27_0._selectMo.subTypeIndex - 1)

			if var_27_2 then
				local var_27_3 = {
					quantity = 1,
					materialId = arg_27_1
				}

				return {
					data = {
						var_27_3
					},
					goodsId = var_27_2
				}
			end
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
