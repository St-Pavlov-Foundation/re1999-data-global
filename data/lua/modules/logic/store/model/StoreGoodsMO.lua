module("modules.logic.store.model.StoreGoodsMO", package.seeall)

local var_0_0 = pureTable("StoreGoodsMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.belongStoreId = arg_1_1
	arg_1_0.goodsId = arg_1_2.goodsId
	arg_1_0.buyCount = arg_1_2.buyCount
	arg_1_0.offlineTime = tonumber(arg_1_2.offlineTime) / 1000
	arg_1_0.config = StoreConfig.instance:getGoodsConfig(arg_1_0.goodsId)

	if string.nilorempty(arg_1_0.config.reduction) == false then
		arg_1_0.reductionInfo = string.splitToNumber(arg_1_0.config.reduction, "#")
	end

	arg_1_0:initRedDotTime()
end

function var_0_0.initRedDotTime(arg_2_0)
	if string.nilorempty(arg_2_0.config.newStartTime) then
		arg_2_0.newStartTime = 0
	else
		arg_2_0.newStartTime = TimeUtil.stringToTimestamp(arg_2_0.config.newStartTime) - ServerTime.clientToServerOffset()
	end

	if string.nilorempty(arg_2_0.config.newEndTime) then
		arg_2_0.newEndTime = 0
	else
		arg_2_0.newEndTime = TimeUtil.stringToTimestamp(arg_2_0.config.newEndTime) - ServerTime.clientToServerOffset()
	end
end

function var_0_0.getOffTab(arg_3_0)
	return arg_3_0.config.offTag
end

function var_0_0.getOfflineTime(arg_4_0)
	if arg_4_0.config.activityId > 0 then
		return ActivityModel.instance:getActEndTime(arg_4_0.config.activityId) / 1000
	else
		return arg_4_0.offlineTime
	end
end

function var_0_0.getCost(arg_5_0, arg_5_1)
	if arg_5_1 <= 0 then
		return 0
	end

	local var_5_0 = arg_5_0.config.cost

	if string.nilorempty(var_5_0) then
		return 0
	end

	local var_5_1 = 0
	local var_5_2 = string.split(var_5_0, "|")

	for iter_5_0 = arg_5_0.buyCount + 1, arg_5_0.buyCount + arg_5_1 do
		local var_5_3 = var_5_2[iter_5_0] or var_5_2[#var_5_2]
		local var_5_4 = string.splitToNumber(var_5_3, "#")[3]

		if iter_5_0 >= #var_5_2 then
			var_5_1 = var_5_1 + var_5_4 * (arg_5_0.buyCount + arg_5_1 - iter_5_0 + 1)

			break
		else
			var_5_1 = var_5_1 + var_5_4
		end
	end

	return var_5_1
end

function var_0_0.getAllCostInfo(arg_6_0)
	local var_6_0 = GameUtil.splitString2(arg_6_0.config.cost, true)
	local var_6_1 = GameUtil.splitString2(arg_6_0.config.cost2, true)

	return var_6_0, var_6_1
end

function var_0_0.getBuyMaxQuantity(arg_7_0)
	local var_7_0 = -1
	local var_7_1 = StoreEnum.LimitType.Default
	local var_7_2 = 0

	if arg_7_0.config.maxBuyCount > 0 then
		var_7_2 = math.max(arg_7_0.config.maxBuyCount - arg_7_0.buyCount, 0)
	else
		var_7_2 = -1
	end

	local var_7_3 = false
	local var_7_4 = 0

	if arg_7_0.config.cost and arg_7_0.config.cost ~= "" then
		local var_7_5 = {}
		local var_7_6 = string.split(arg_7_0.config.cost, "|")

		if #var_7_6 > 1 then
			var_7_3 = true
		end

		local var_7_7 = CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount)

		while var_7_4 < var_7_7 do
			local var_7_8 = var_7_6[arg_7_0.buyCount + var_7_4 + 1] or var_7_6[#var_7_6]
			local var_7_9 = string.splitToNumber(var_7_8, "#")
			local var_7_10 = var_7_9[1]
			local var_7_11 = var_7_9[2]
			local var_7_12 = var_7_9[3]

			if arg_7_0.buyCount + var_7_4 + 1 >= #var_7_6 then
				if var_7_12 == 0 then
					var_7_4 = -1

					break
				end

				local var_7_13 = ItemModel.instance:getItemQuantity(var_7_10, var_7_11)

				for iter_7_0, iter_7_1 in pairs(var_7_5) do
					if iter_7_1.type == var_7_10 and iter_7_1.id == var_7_11 then
						var_7_13 = var_7_13 - iter_7_1.quantity
					end
				end

				var_7_4 = var_7_4 + math.floor(var_7_13 / var_7_12)

				break
			else
				table.insert(var_7_5, {
					type = var_7_10,
					id = var_7_11,
					quantity = var_7_12
				})

				local var_7_14, var_7_15, var_7_16 = ItemModel.instance:hasEnoughItems(var_7_5)

				if not var_7_15 then
					break
				end

				var_7_4 = var_7_4 + 1
			end
		end
	else
		var_7_4 = -1
	end

	if var_7_3 then
		var_7_0 = math.min(var_7_2, 1)
		var_7_0 = math.min(var_7_0, var_7_4)
		var_7_1 = StoreEnum.LimitType.CurrencyChanged

		if var_7_2 < 1 and var_7_2 >= 0 then
			var_7_1 = StoreEnum.LimitType.BuyLimit
		elseif var_7_4 < 1 and var_7_4 >= 0 then
			var_7_1 = StoreEnum.LimitType.Currency
		end
	elseif var_7_2 < 0 and var_7_4 < 0 then
		logError("商品购买数量计算错误: " .. arg_7_0.goodsId)

		var_7_0 = -1
		var_7_1 = StoreEnum.LimitType.Default
	elseif var_7_2 < 0 then
		var_7_0 = var_7_4
		var_7_1 = StoreEnum.LimitType.Currency
	elseif var_7_4 < 0 then
		var_7_0 = var_7_2
		var_7_1 = StoreEnum.LimitType.BuyLimit
	else
		var_7_0 = math.min(var_7_2, var_7_4)
		var_7_1 = var_7_2 <= var_7_4 and StoreEnum.LimitType.BuyLimit or StoreEnum.LimitType.Currency
	end

	return var_7_0, var_7_1
end

function var_0_0.canAffordQuantity(arg_8_0)
	if not string.nilorempty(arg_8_0.config.cost) then
		local var_8_0 = 0
		local var_8_1 = {}
		local var_8_2 = string.split(arg_8_0.config.cost, "|")
		local var_8_3 = CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount)

		while var_8_0 < var_8_3 do
			local var_8_4 = var_8_2[arg_8_0.buyCount + var_8_0 + 1] or var_8_2[#var_8_2]
			local var_8_5 = string.splitToNumber(var_8_4, "#")
			local var_8_6 = var_8_5[1]
			local var_8_7 = var_8_5[2]
			local var_8_8 = var_8_5[3]

			if arg_8_0.buyCount + var_8_0 + 1 >= #var_8_2 then
				if var_8_8 == 0 then
					return -1
				end

				local var_8_9 = ItemModel.instance:getItemQuantity(var_8_6, var_8_7)

				for iter_8_0, iter_8_1 in pairs(var_8_1) do
					if iter_8_1.type == var_8_6 and iter_8_1.id == var_8_7 then
						var_8_9 = var_8_9 - iter_8_1.quantity
					end
				end

				var_8_0 = var_8_0 + math.floor(var_8_9 / var_8_8)

				break
			else
				table.insert(var_8_1, {
					type = var_8_6,
					id = var_8_7,
					quantity = var_8_8
				})

				local var_8_10, var_8_11, var_8_12 = ItemModel.instance:hasEnoughItems(var_8_1)

				if not var_8_11 then
					break
				end

				var_8_0 = var_8_0 + 1
			end
		end

		return var_8_0
	else
		return -1
	end
end

function var_0_0.getLimitSoldNum(arg_9_0)
	local var_9_0 = arg_9_0.config.product
	local var_9_1 = GameUtil.splitString2(var_9_0, true)
	local var_9_2 = var_9_1[1][1]
	local var_9_3 = var_9_1[1][2]

	if var_9_2 == MaterialEnum.MaterialType.Equip then
		return ItemModel.instance:getItemConfig(var_9_2, var_9_3).upperLimit
	end
end

function var_0_0.alreadyHas(arg_10_0)
	local var_10_0 = arg_10_0.config.product
	local var_10_1 = GameUtil.splitString2(var_10_0, true)
	local var_10_2 = var_10_1[1][1]
	local var_10_3 = var_10_1[1][2]
	local var_10_4 = false

	if arg_10_0.belongStoreId == StoreEnum.StoreId.NewRoomStore or arg_10_0.belongStoreId == StoreEnum.StoreId.OldRoomStore then
		var_10_4 = true

		for iter_10_0, iter_10_1 in ipairs(var_10_1) do
			var_10_2 = iter_10_1[1]
			var_10_3 = iter_10_1[2]

			local var_10_5 = ItemModel.instance:getItemQuantity(var_10_2, var_10_3)
			local var_10_6 = ItemModel.instance:getItemConfig(var_10_2, var_10_3)
			local var_10_7 = var_10_6 and var_10_6.numLimit or 1

			if var_10_7 == 0 or var_10_5 < var_10_7 then
				var_10_4 = false

				break
			end
		end
	elseif var_10_2 == MaterialEnum.MaterialType.PlayerCloth then
		var_10_4 = PlayerClothModel.instance:hasCloth(var_10_3)
	elseif var_10_2 == MaterialEnum.MaterialType.HeroSkin then
		var_10_4 = HeroModel.instance:checkHasSkin(var_10_3)
	end

	return var_10_4
end

function var_0_0.buyGoodsReply(arg_11_0, arg_11_1)
	arg_11_0.buyCount = arg_11_0.buyCount + arg_11_1
end

function var_0_0.hasProduct(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = false

	if arg_12_1 and arg_12_2 then
		local var_12_1 = arg_12_0.config.product
		local var_12_2 = GameUtil.splitString2(var_12_1, true)

		for iter_12_0, iter_12_1 in ipairs(var_12_2) do
			if arg_12_1 == iter_12_1[1] and arg_12_2 == iter_12_1[2] then
				var_12_0 = true

				break
			end
		end
	end

	return var_12_0
end

function var_0_0.intiActGoods(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0.belongStoreId = arg_13_1
	arg_13_0.goodsId = nil
	arg_13_0.actGoodsId = arg_13_2
	arg_13_0.actPoolId = arg_13_3
	arg_13_0.isActGoods = true
end

function var_0_0.isSoldOut(arg_14_0)
	if arg_14_0:getIsActGoods() then
		return false
	end

	if arg_14_0.config.maxBuyCount > 0 and arg_14_0.config.maxBuyCount <= arg_14_0.buyCount then
		return true
	end

	return false
end

function var_0_0.needShowNew(arg_15_0)
	if arg_15_0:getIsActGoods() then
		return false
	end

	if arg_15_0:isSoldOut() then
		return false
	else
		local var_15_0 = ServerTime.now()

		return var_15_0 >= arg_15_0.newStartTime and var_15_0 <= arg_15_0.newEndTime
	end
end

function var_0_0.getBelongStoreId(arg_16_0)
	return arg_16_0.belongStoreId
end

function var_0_0.getActGoodsId(arg_17_0)
	return arg_17_0.actGoodsId
end

function var_0_0.getIsGreatActGoods(arg_18_0)
	local var_18_0 = false

	if arg_18_0:getIsActGoods() then
		var_18_0 = arg_18_0.actPoolId == FurnaceTreasureEnum.ActGoodsPool.Great
	end

	return var_18_0
end

function var_0_0.getIsActGoods(arg_19_0)
	return arg_19_0.isActGoods or false
end

function var_0_0.getIsJumpGoods(arg_20_0)
	return arg_20_0.config.jumpId ~= 0
end

function var_0_0.getIsPackageGoods(arg_21_0)
	return arg_21_0.config.bindgoodid ~= 0
end

function var_0_0.getIsActivityGoods(arg_22_0)
	return arg_22_0.config.activityId ~= 0
end

function var_0_0.checkJumpGoodCanOpen(arg_23_0)
	if not arg_23_0:getIsJumpGoods() then
		return true
	elseif arg_23_0:getIsPackageGoods() then
		local var_23_0 = StoreModel.instance:getGoodsMO(arg_23_0.config.bindgoodid)

		if var_23_0 then
			local var_23_1 = ServerTime.now()
			local var_23_2 = TimeUtil.stringToTimestamp(var_23_0.config.onlineTime)
			local var_23_3 = TimeUtil.stringToTimestamp(var_23_0.config.offlineTime)

			return var_23_2 <= var_23_1 and var_23_1 <= var_23_3
		else
			return false
		end
	elseif arg_23_0:getIsActivityGoods() and ActivityHelper.getActivityStatus(arg_23_0.config.activityId) ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	return true
end

function var_0_0.setNewRedDotKey(arg_24_0)
	local var_24_0 = PlayerPrefsKey.StoreRoomTreeItemShowNew .. arg_24_0.goodsId

	GameUtil.playerPrefsSetStringByUserId(var_24_0, arg_24_0.goodsId)
end

function var_0_0.checkShowNewRedDot(arg_25_0)
	local var_25_0 = PlayerPrefsKey.StoreRoomTreeItemShowNew .. arg_25_0.goodsId
	local var_25_1 = GameUtil.playerPrefsGetStringByUserId(var_25_0, nil)

	if arg_25_0.belongStoreId ~= StoreEnum.StoreId.NewRoomStore then
		return false
	end

	if var_25_1 then
		return false
	end

	return true
end

return var_0_0
