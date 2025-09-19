module("modules.logic.store.model.StoreNormalGoodsItemListModel", package.seeall)

local var_0_0 = class("StoreNormalGoodsItemListModel", ListScrollModel)

function var_0_0.setMOList(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._moList = {}

	if arg_1_2 then
		local var_1_0 = FurnaceTreasureModel.instance:getGoodsListByStoreId(arg_1_2)

		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			local var_1_1 = FurnaceTreasureModel.instance:getGoodsRemainCount(arg_1_2, iter_1_1)

			if var_1_1 and var_1_1 > 0 then
				local var_1_2 = FurnaceTreasureModel.instance:getGoodsPoolId(arg_1_2, iter_1_1)
				local var_1_3 = StoreGoodsMO.New()

				var_1_3:intiActGoods(arg_1_2, iter_1_1, var_1_2)

				arg_1_0._moList[#arg_1_0._moList + 1] = var_1_3
			end
		end
	end

	if arg_1_1 then
		for iter_1_2, iter_1_3 in pairs(arg_1_1) do
			table.insert(arg_1_0._moList, iter_1_3)
		end
	end

	var_0_0.StoreId = arg_1_2

	arg_1_0:allHeroRecommendEquip()

	if #arg_1_0._moList > 1 then
		table.sort(arg_1_0._moList, arg_1_0._sortFunction)
	end

	arg_1_0:setList(arg_1_0._moList)
end

function var_0_0._sortFunction(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getIsActGoods()

	if var_2_0 ~= arg_2_1:getIsActGoods() then
		return var_2_0
	end

	if var_2_0 then
		return arg_2_0:getActGoodsId() < arg_2_1:getActGoodsId()
	end

	local var_2_1 = StoreConfig.instance:getGoodsConfig(arg_2_0.goodsId)
	local var_2_2 = StoreConfig.instance:getGoodsConfig(arg_2_1.goodsId)
	local var_2_3 = var_0_0._isStoreItemCountLimit(arg_2_0)
	local var_2_4 = var_0_0._isStoreItemCountLimit(arg_2_1)

	if var_2_3 and not var_2_4 then
		return false
	elseif not var_2_3 and var_2_4 then
		return true
	end

	local var_2_5 = var_0_0._isStoreItemSoldOut(arg_2_0.goodsId)
	local var_2_6 = var_0_0._isStoreItemSoldOut(arg_2_1.goodsId)
	local var_2_7 = var_0_0._isStoreItemUnlock(arg_2_0.goodsId)
	local var_2_8 = var_0_0._isStoreItemUnlock(arg_2_1.goodsId)

	if not var_2_5 and var_2_6 then
		return true
	elseif var_2_5 and not var_2_6 then
		return false
	end

	local var_2_9 = arg_2_0:alreadyHas()
	local var_2_10 = arg_2_1:alreadyHas()

	if var_2_9 ~= var_2_10 then
		return var_2_10
	end

	if var_2_7 and not var_2_8 then
		return true
	elseif not var_2_7 and var_2_8 then
		return false
	end

	if var_0_0.IsEquipSort and var_0_0.StoreId == StoreEnum.StoreId.SummonEquipExchange and not var_2_9 and not var_2_10 and not var_2_5 and not var_2_6 then
		local var_2_11 = string.splitToNumber(var_2_1.product, "#")
		local var_2_12 = string.splitToNumber(var_2_2.product, "#")
		local var_2_13 = false
		local var_2_14 = false

		if var_2_11[1] == MaterialEnum.MaterialType.Equip then
			if var_2_11[2] == 1000 then
				return true
			end

			var_2_13 = LuaUtil.tableContains(var_0_0._recommendEquips, var_2_11[2])
		end

		if var_2_12[1] == MaterialEnum.MaterialType.Equip then
			if var_2_12[2] == 1000 then
				return false
			end

			var_2_14 = LuaUtil.tableContains(var_0_0._recommendEquips, var_2_12[2])
		end

		if var_2_13 ~= var_2_14 then
			local var_2_15 = ItemModel.instance:getItemConfig(var_2_11[1], var_2_11[2])
			local var_2_16 = ItemModel.instance:getItemConfig(var_2_12[1], var_2_12[2])

			if var_2_15.rare ~= var_2_16.rare then
				return var_2_1.order < var_2_2.order
			else
				return var_2_13
			end
		elseif var_2_13 == true and var_2_14 == true then
			return var_2_11[2] > var_2_12[2]
		end
	end

	local var_2_17 = var_0_0.needWeekWalkLayerUnlock(arg_2_0.goodsId)

	if var_2_17 ~= var_0_0.needWeekWalkLayerUnlock(arg_2_1.goodsId) then
		if var_2_17 then
			return false
		end

		return true
	end

	if var_2_1.order < var_2_2.order then
		return true
	elseif var_2_1.order > var_2_2.order then
		return false
	end

	if var_2_1.id < var_2_2.id then
		return true
	elseif var_2_1.id > var_2_2.id then
		return false
	end
end

function var_0_0._isStoreItemUnlock(arg_3_0)
	local var_3_0 = StoreConfig.instance:getGoodsConfig(arg_3_0).needEpisodeId

	if not var_3_0 or var_3_0 == 0 then
		return true
	end

	return DungeonModel.instance:hasPassLevelAndStory(var_3_0)
end

function var_0_0.needWeekWalkLayerUnlock(arg_4_0)
	local var_4_0 = StoreConfig.instance:getGoodsConfig(arg_4_0).needWeekwalkLayer

	if var_4_0 <= 0 then
		return false
	end

	if not WeekWalkModel.instance:getInfo() then
		return true
	end

	return var_4_0 > WeekWalkModel.instance:getMaxLayerId()
end

function var_0_0._isStoreItemSoldOut(arg_5_0)
	return StoreModel.instance:getGoodsMO(arg_5_0):isSoldOut()
end

function var_0_0._isStoreItemCountLimit(arg_6_0)
	local var_6_0 = arg_6_0:getLimitSoldNum()

	if not var_6_0 or var_6_0 == 0 then
		return false
	end

	local var_6_1 = arg_6_0.config.product
	local var_6_2 = GameUtil.splitString2(var_6_1, true)
	local var_6_3 = var_6_2[1][1]
	local var_6_4 = var_6_2[1][2]

	if var_6_3 == MaterialEnum.MaterialType.Equip then
		return var_6_0 <= EquipModel.instance:getEquipQuantity(var_6_4)
	end
end

function var_0_0.initSortEquip(arg_7_0)
	var_0_0.IsEquipSort = false

	arg_7_0:_sortEquip()

	return var_0_0.IsEquipSort
end

function var_0_0.setSortEquip(arg_8_0)
	var_0_0.IsEquipSort = not var_0_0.IsEquipSort

	arg_8_0:_sortEquip()

	return var_0_0.IsEquipSort
end

function var_0_0._sortEquip(arg_9_0)
	if arg_9_0._moList and #arg_9_0._moList > 1 then
		table.sort(arg_9_0._moList, arg_9_0._sortFunction)
	end

	arg_9_0:setList(arg_9_0._moList)
end

function var_0_0.allHeroRecommendEquip(arg_10_0)
	if not var_0_0._recommendEquips then
		var_0_0._recommendEquips = {}
	end

	local var_10_0 = HeroModel.instance:getAllHero()

	if var_10_0 then
		for iter_10_0, iter_10_1 in pairs(var_10_0) do
			if iter_10_1.config.rare == 5 then
				local var_10_1 = iter_10_1:getRecommendEquip()

				if var_10_1 then
					for iter_10_2, iter_10_3 in ipairs(var_10_1) do
						if not LuaUtil.tableContains(var_0_0._recommendEquips, iter_10_3) then
							table.insert(var_0_0._recommendEquips, iter_10_3)
						end
					end
				end
			end
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
