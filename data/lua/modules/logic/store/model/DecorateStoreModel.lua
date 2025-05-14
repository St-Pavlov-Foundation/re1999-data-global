module("modules.logic.store.model.DecorateStoreModel", package.seeall)

local var_0_0 = class("DecorateStoreModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._curGoodId = 0
	arg_1_0._curViewType = 0
	arg_1_0._curDecorateType = 0
	arg_1_0._curCostIndex = 1
	arg_1_0._readGoodList = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.setCurGood(arg_3_0, arg_3_1)
	arg_3_0._curGoodId = arg_3_1
end

function var_0_0.getCurGood(arg_4_0, arg_4_1)
	if arg_4_0._curGoodId == 0 then
		arg_4_0._curGoodId = arg_4_0:getDecorateGoodList(arg_4_1)[1].goodsId
	elseif tonumber(StoreConfig.instance:getGoodsConfig(arg_4_0._curGoodId).storeId) ~= arg_4_1 then
		arg_4_0._curGoodId = arg_4_0:getDecorateGoodList(arg_4_1)[1].goodsId
	end

	return arg_4_0._curGoodId
end

function var_0_0.getDecorateGoodList(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = StoreModel.instance:getStoreMO(arg_5_1)

	if var_5_1 then
		local var_5_2 = var_5_1:getGoodsList()

		for iter_5_0, iter_5_1 in pairs(var_5_2) do
			table.insert(var_5_0, iter_5_1)
		end
	end

	table.sort(var_5_0, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_5_0:isDecorateGoodItemHas(arg_6_0.goodsId)
		local var_6_1 = arg_5_0:isDecorateGoodItemHas(arg_6_1.goodsId)
		local var_6_2 = arg_6_0.config.maxBuyCount > 0 and arg_6_0.buyCount >= arg_6_0.config.maxBuyCount and 1 or 0

		if var_6_0 then
			var_6_2 = 1
		end

		local var_6_3 = arg_6_1.config.maxBuyCount > 0 and arg_6_1.buyCount >= arg_6_1.config.maxBuyCount and 1 or 0

		if var_6_1 then
			var_6_3 = 1
		end

		if var_6_2 ~= var_6_3 then
			return var_6_2 < var_6_3
		else
			return arg_6_0.config.order < arg_6_1.config.order
		end
	end)

	return var_5_0
end

function var_0_0.getDecorateGoodIndex(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:getDecorateGoodList(arg_7_1)

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1.goodsId == arg_7_2 then
			return iter_7_0
		end
	end

	return 0
end

function var_0_0.setCurViewType(arg_8_0, arg_8_1)
	arg_8_0._curViewType = arg_8_1
end

function var_0_0.getCurViewType(arg_9_0)
	if arg_9_0._curViewType == 0 then
		arg_9_0._curViewType = DecorateStoreEnum.DecorateViewType.Fold
	end

	return arg_9_0._curViewType
end

function var_0_0.setCurDecorateType(arg_10_0, arg_10_1)
	arg_10_0._curDecorateType = arg_10_1
end

function var_0_0.getCurDecorateType(arg_11_0)
	if arg_11_0._curDecorateType == 0 then
		arg_11_0._curDecorateType = DecorateStoreEnum.DecorateType.New
	end

	return arg_11_0._curDecorateType
end

function var_0_0.isGoodRead(arg_12_0, arg_12_1)
	return arg_12_0._readGoodList[arg_12_1]
end

function var_0_0.initDecorateReadState(arg_13_0)
	local var_13_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DecorateStoreReadGoods), "")
	local var_13_1 = string.splitToNumber(var_13_0, "#")

	for iter_13_0, iter_13_1 in pairs(var_13_1) do
		arg_13_0._readGoodList[iter_13_1] = true
	end
end

function var_0_0.setGoodRead(arg_14_0, arg_14_1)
	arg_14_0._readGoodList[arg_14_1] = true

	local var_14_0 = ""

	for iter_14_0, iter_14_1 in pairs(arg_14_0._readGoodList) do
		var_14_0 = var_14_0 == "" and iter_14_0 or string.format("%s#%s", var_14_0, iter_14_0)
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DecorateStoreReadGoods), var_14_0)
end

function var_0_0.getItemType(arg_15_0)
	local var_15_0 = var_0_0.instance:getCurGood(arg_15_0)
	local var_15_1 = DecorateStoreConfig.instance:getDecorateConfig(var_15_0)

	if var_15_1.productType == MaterialEnum.MaterialType.Item then
		if var_15_1.subType == MaterialEnum.ItemSubType.Icon then
			return DecorateStoreEnum.DecorateItemType.Icon
		elseif var_15_1.subType == MaterialEnum.ItemSubType.SelfCard then
			return DecorateStoreEnum.DecorateItemType.SelfCard
		elseif var_15_1.subType == MaterialEnum.ItemSubType.MainScene then
			return DecorateStoreEnum.DecorateItemType.MainScene
		end
	elseif var_15_1.productType == MaterialEnum.MaterialType.HeroSkin then
		return DecorateStoreEnum.DecorateItemType.Skin
	elseif var_15_1.productType == MaterialEnum.MaterialType.Building and var_15_1.subType == 7 then
		return DecorateStoreEnum.DecorateItemType.BuildingVideo
	end

	return DecorateStoreEnum.DecorateItemType.Default
end

function var_0_0.setCurCostIndex(arg_16_0, arg_16_1)
	arg_16_0._curCostIndex = arg_16_1
end

function var_0_0.getCurCostIndex(arg_17_0)
	return arg_17_0._curCostIndex
end

function var_0_0.getGoodDiscount(arg_18_0, arg_18_1)
	local var_18_0 = StoreConfig.instance:getGoodsConfig(arg_18_1)

	if var_18_0.discountItem == "" then
		return 0
	end

	local var_18_1 = string.split(var_18_0.discountItem, "|")

	if #var_18_1 ~= 2 then
		return 0
	end

	local var_18_2 = string.splitToNumber(var_18_1[1], "#")

	if ItemModel.instance:getItemCount(var_18_2[2]) < var_18_2[3] then
		return 0
	end

	local var_18_3 = ItemModel.instance:getItemConfig(var_18_2[1], var_18_2[2])
	local var_18_4 = TimeUtil.stringToTimestamp(var_18_3.expireTime)

	if math.floor(var_18_4 - ServerTime.now()) <= 0 then
		return 0
	end

	return math.floor(tonumber(var_18_1[2]) / 10)
end

function var_0_0.getGoodItemLimitTime(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getGoodDiscount(arg_19_1)

	if var_19_0 > 0 and var_19_0 < 100 then
		local var_19_1 = StoreConfig.instance:getGoodsConfig(arg_19_1)

		if var_19_1.discountItem == "" then
			return 0
		end

		local var_19_2 = string.split(var_19_1.discountItem, "|")

		if #var_19_2 ~= 2 then
			return 0
		end

		local var_19_3 = string.splitToNumber(var_19_2[1], "#")

		if ItemModel.instance:getItemCount(var_19_3[2]) < var_19_3[3] then
			return 0
		end

		local var_19_4 = ItemModel.instance:getItemConfig(var_19_3[1], var_19_3[2])
		local var_19_5 = TimeUtil.stringToTimestamp(var_19_4.expireTime)

		return (math.floor(var_19_5 - ServerTime.now()))
	end

	return 0
end

function var_0_0.isDecorateGoodItemHas(arg_20_0, arg_20_1)
	if DecorateStoreConfig.instance:getDecorateConfig(arg_20_1).maxbuycountType ~= DecorateStoreEnum.MaxBuyTipType.Owned then
		return false
	end

	local var_20_0 = StoreConfig.instance:getGoodsConfig(arg_20_1)
	local var_20_1 = string.splitToNumber(var_20_0.product, "#")

	return ItemModel.instance:getItemQuantity(var_20_1[1], var_20_1[2]) > 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
