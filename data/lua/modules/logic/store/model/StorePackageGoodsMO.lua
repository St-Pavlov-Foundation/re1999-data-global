module("modules.logic.store.model.StorePackageGoodsMO", package.seeall)

local var_0_0 = pureTable("StorePackageGoodsMO")

function var_0_0.initCharge(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.isChargeGoods = true
	arg_1_0.belongStoreId = arg_1_1
	arg_1_0.goodsId = arg_1_2.id
	arg_1_0.id = arg_1_0.goodsId
	arg_1_0.buyCount = arg_1_2.buyCount
	arg_1_0.config = StoreConfig.instance:getChargeGoodsConfig(arg_1_0.goodsId)
	arg_1_0.buyLevel = 0

	if arg_1_0.id == StoreEnum.LittleMonthCardGoodsId then
		local var_1_0 = StoreConfig.instance:getMonthCardAddConfig(arg_1_0.id)

		arg_1_0.refreshTime = StoreEnum.ChargeRefreshTime.None
		arg_1_0.maxBuyCount = var_1_0.limit
	else
		local var_1_1 = GameUtil.splitString2(arg_1_0.config.limit, true)
		local var_1_2 = var_1_1[1]

		arg_1_0.refreshTime = var_1_2[1]

		if var_1_2[1] == StoreEnum.ChargeRefreshTime.None then
			arg_1_0.maxBuyCount = 0
		else
			arg_1_0.maxBuyCount = var_1_2[2]
		end

		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			if iter_1_1[1] == StoreEnum.ChargeRefreshTime.Level then
				arg_1_0.buyLevel = iter_1_1[2]
			end
		end
	end

	arg_1_0.cost = StoreConfig.instance:getChargeGoodsPrice(arg_1_0.id)

	if string.nilorempty(arg_1_0.config.offlineTime) then
		arg_1_0.offlineTime = 0
	else
		arg_1_0.offlineTime = TimeUtil.stringToTimestamp(arg_1_0.config.offlineTime)
	end

	arg_1_0._offInfos = string.split(arg_1_0.config.offTag, "#")

	arg_1_0:initRedDotTime()
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.isChargeGoods = false
	arg_2_0.belongStoreId = arg_2_1
	arg_2_0.goodsId = arg_2_2
	arg_2_0.id = arg_2_0.goodsId
	arg_2_0.buyCount = arg_2_3
	arg_2_0.offlineTime = arg_2_4
	arg_2_0.config = StoreConfig.instance:getGoodsConfig(arg_2_0.goodsId)
	arg_2_0.maxBuyCount = arg_2_0.config.maxBuyCount
	arg_2_0.refreshTime = arg_2_0.config.refreshTime
	arg_2_0.cost = arg_2_0.config.cost
	arg_2_0.buyLevel = arg_2_0.config.buyLevel
	arg_2_0._offInfos = string.split(arg_2_0.config.offTag, "#")

	if arg_2_4 == nil then
		arg_2_0.offlineTime = TimeUtil.stringToTimestamp(arg_2_0.config.offlineTime)
	end

	arg_2_0:initRedDotTime()
end

function var_0_0.initRedDotTime(arg_3_0)
	if string.nilorempty(arg_3_0.config.newStartTime) then
		arg_3_0.newStartTime = 0
	else
		arg_3_0.newStartTime = TimeUtil.stringToTimestamp(arg_3_0.config.newStartTime)
	end

	if string.nilorempty(arg_3_0.config.newEndTime) then
		arg_3_0.newEndTime = 0
	else
		arg_3_0.newEndTime = TimeUtil.stringToTimestamp(arg_3_0.config.newEndTime)
	end
end

function var_0_0.alreadyHas(arg_4_0)
	local var_4_0 = arg_4_0.config.product
	local var_4_1 = string.split(var_4_0, "#")
	local var_4_2 = tonumber(var_4_1[1])
	local var_4_3 = tonumber(var_4_1[2])

	if var_4_2 == MaterialEnum.MaterialType.PlayerCloth then
		return PlayerClothModel.instance:hasCloth(var_4_3)
	else
		return false
	end
end

function var_0_0.isSoldOut(arg_5_0)
	if arg_5_0.maxBuyCount > 0 and arg_5_0.maxBuyCount <= arg_5_0.buyCount then
		return true
	end

	return false
end

function var_0_0.isLevelOpen(arg_6_0)
	return arg_6_0.buyLevel <= PlayerModel.instance:getPlayerLevel()
end

function var_0_0.checkPreGoodsSoldOut(arg_7_0)
	if arg_7_0.config.preGoodsId == 0 then
		return true
	end

	local var_7_0 = StoreModel.instance:getGoodsMO(arg_7_0.config.preGoodsId)

	return (var_7_0 and var_7_0:isSoldOut()) == true
end

function var_0_0.getDiscount(arg_8_0)
	if arg_8_0._offInfos[1] == StoreEnum.Discount.Discount then
		return arg_8_0._offInfos[2] or 0
	end

	return 0
end

function var_0_0.needShowNew(arg_9_0)
	if arg_9_0:isSoldOut() then
		return false
	else
		local var_9_0 = ServerTime.now()
		local var_9_1 = var_9_0 >= arg_9_0.newStartTime and var_9_0 <= arg_9_0.newEndTime

		return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.StoreChargeGoodsRead, arg_9_0.goodsId) and var_9_1
	end
end

return var_0_0
