module("modules.logic.store.model.StoreCritterGoodsItemListModel", package.seeall)

local var_0_0 = class("StoreCritterGoodsItemListModel", ListScrollModel)

function var_0_0.setMOList(arg_1_0, arg_1_1)
	local var_1_0 = StoreModel.instance:getStoreMO(arg_1_1)

	if var_1_0 then
		arg_1_0._moList = var_1_0:getGoodsList()

		if #arg_1_0._moList > 1 then
			table.sort(arg_1_0._moList, arg_1_0._sortFunction)
		end

		arg_1_0:setList(arg_1_0._moList)
	end
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

	local var_2_11 = var_0_0.needWeekWalkLayerUnlock(arg_2_0.goodsId)

	if var_2_11 ~= var_0_0.needWeekWalkLayerUnlock(arg_2_1.goodsId) then
		if var_2_11 then
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

var_0_0.instance = var_0_0.New()

return var_0_0
