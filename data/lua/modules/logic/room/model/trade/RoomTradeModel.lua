module("modules.logic.room.model.trade.RoomTradeModel", package.seeall)

local var_0_0 = class("RoomTradeModel", BaseModel)
local var_0_1 = "RoomTrade_Barrage_FirstEnter"
local var_0_2 = "RoomTrade_BarrageBatch"
local var_0_3 = "RoomTrade_PlayTradeEnterBtnAnim"

function var_0_0.onInit(arg_1_0)
	arg_1_0:clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearData()
end

function var_0_0.clearData(arg_3_0)
	arg_3_0._traceItemDict = {}
	arg_3_0._traceChildItemDict = {}
	arg_3_0._isGetOrderInfo = false
end

function var_0_0.onGetOrderInfo(arg_4_0, arg_4_1)
	arg_4_0.purchaseOrderFinishCount = arg_4_1.purchaseOrderFinishCount

	local var_4_0 = arg_4_1.purchaseOrderInfos
	local var_4_1 = arg_4_1.wholesaleOrderInfos

	arg_4_0._remainRefreshCount = arg_4_1.remainRefreshCount
	arg_4_0.weeklyWholesaleRevenue = arg_4_1.weeklyWholesaleRevenue or 0
	arg_4_0._dailyOrderMos = {}

	if var_4_0 then
		for iter_4_0 = 1, #var_4_0 do
			local var_4_2 = var_4_0[iter_4_0]
			local var_4_3 = RoomDailyOrderMo.New()

			var_4_3:initMo(var_4_2, false)
			table.insert(arg_4_0._dailyOrderMos, var_4_3)
		end
	end

	arg_4_0:calTracedItemDict()

	arg_4_0._wholesaleOrderMos = {}

	if var_4_1 then
		for iter_4_1 = 1, #var_4_1 do
			local var_4_4 = var_4_1[iter_4_1]
			local var_4_5 = RoomWholesaleOrderMo.New()

			var_4_5:initMo(var_4_4)
			table.insert(arg_4_0._wholesaleOrderMos, var_4_5)
		end
	end

	arg_4_0._isGetOrderInfo = true
end

function var_0_0.getDailyOrderFinishCount(arg_5_0)
	local var_5_0 = arg_5_0:getCurLevelOrderConfig().finishLimitDaily or 0

	return arg_5_0.purchaseOrderFinishCount or 0, var_5_0
end

function var_0_0.onFinishDailyOrder(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._remainRefreshCount = arg_6_3
	arg_6_0.purchaseOrderFinishCount = arg_6_0.purchaseOrderFinishCount + 1

	local var_6_0 = arg_6_0:getDailyOrderById(arg_6_1)

	if arg_6_2 and #arg_6_2.goodsInfo > 0 then
		if var_6_0 then
			var_6_0:initMo(arg_6_2, true)
		end
	else
		var_6_0:setFinish()
	end

	arg_6_0:calTracedItemDict()
end

function var_0_0.onRefeshDailyOrder(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._remainRefreshCount = arg_7_2

	local var_7_0 = arg_7_0:getDailyOrders()

	if var_7_0 then
		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			if iter_7_1:isWaitRefresh() then
				iter_7_1:initMo(arg_7_1, true)

				return
			end
		end
	end

	arg_7_0:calTracedItemDict()
end

function var_0_0.getRefreshCount(arg_8_0)
	local var_8_0 = RoomTradeConfig.instance:getConstValue(RoomTradeEnum.ConstId.DailyOrderFinishMaxCount, true)

	return arg_8_0._remainRefreshCount or 0, var_8_0 or 0
end

function var_0_0.isCanRefreshDailyOrder(arg_9_0)
	return arg_9_0._remainRefreshCount ~= 0
end

function var_0_0.onTracedDailyOrder(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getDailyOrderById(arg_10_1)

	if var_10_0 then
		var_10_0:setTraced(arg_10_2)
	end

	arg_10_0:calTracedItemDict()
end

function var_0_0.calTracedItemDict(arg_11_0)
	arg_11_0._traceItemDict = {}
	arg_11_0._traceChildItemDict = {}

	local var_11_0 = arg_11_0:getDailyOrders()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if iter_11_1.isTraced then
			for iter_11_2, iter_11_3 in ipairs(iter_11_1:getGoodsInfo()) do
				local var_11_1 = ManufactureConfig.instance:getItemId(iter_11_3.productionId)

				arg_11_0._traceItemDict[var_11_1] = (arg_11_0._traceItemDict[var_11_1] or 0) + iter_11_3.quantity

				local var_11_2, var_11_3 = ManufactureModel.instance:getManufactureItemCount(iter_11_3.productionId, true, true)
				local var_11_4 = var_11_2 + var_11_3
				local var_11_5 = iter_11_3.quantity - var_11_4

				arg_11_0:_addMatTracedCount(iter_11_3.productionId, var_11_5)
			end
		end
	end
end

function var_0_0._addMatTracedCount(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1 and ManufactureConfig.instance:getNeedMatItemList(arg_12_1)

	if not var_12_0 or #var_12_0 <= 0 then
		return
	end

	arg_12_2 = math.max(0, arg_12_2)

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1 = ManufactureConfig.instance:getItemId(iter_12_1.id)
		local var_12_2 = iter_12_1.quantity * arg_12_2

		arg_12_0._traceChildItemDict[var_12_1] = (arg_12_0._traceChildItemDict[var_12_1] or 0) + var_12_2

		local var_12_3, var_12_4 = ManufactureModel.instance:getManufactureItemCount(iter_12_1.id, true, true)
		local var_12_5 = var_12_2 - (var_12_3 + var_12_4)

		arg_12_0:_addMatTracedCount(iter_12_1.id, var_12_5)
	end
end

function var_0_0.isTracedGoods(arg_13_0, arg_13_1)
	local var_13_0 = false
	local var_13_1, var_13_2 = arg_13_0:getDailyOrderFinishCount()

	if var_13_1 < var_13_2 then
		local var_13_3 = ManufactureConfig.instance:getItemId(arg_13_1)
		local var_13_4 = arg_13_0._traceItemDict and arg_13_0._traceItemDict[var_13_3]
		local var_13_5 = arg_13_0._traceChildItemDict and arg_13_0._traceChildItemDict[var_13_3]

		var_13_0 = var_13_4 or var_13_5
	end

	return var_13_0
end

function var_0_0.getTracedGoodsCount(arg_14_0, arg_14_1)
	local var_14_0 = 0
	local var_14_1 = 0

	if not arg_14_0:isTracedGoods(arg_14_1) then
		return var_14_0, var_14_1
	end

	local var_14_2 = ManufactureConfig.instance:getItemId(arg_14_1)
	local var_14_3 = arg_14_0._traceItemDict and arg_14_0._traceItemDict[var_14_2] or 0
	local var_14_4 = arg_14_0._traceChildItemDict and arg_14_0._traceChildItemDict[var_14_2] or 0

	return var_14_3, var_14_4
end

function var_0_0.setIsLockedOrder(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getDailyOrderById(arg_15_1)

	if var_15_0 then
		var_15_0:setLocked(arg_15_2)
	end
end

function var_0_0.isLockedOrder(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getDailyOrderById(arg_16_1)

	if var_16_0 then
		return var_16_0:getLocked()
	end
end

function var_0_0.getDailyOrders(arg_17_0)
	if not arg_17_0._dailyOrderMos then
		arg_17_0._dailyOrderMos = {}
	end

	return arg_17_0._dailyOrderMos
end

function var_0_0.getDailyOrderById(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getDailyOrders()

	if var_18_0 then
		for iter_18_0, iter_18_1 in ipairs(var_18_0) do
			if iter_18_1.orderId == arg_18_1 then
				return iter_18_1, iter_18_0
			end
		end
	end
end

function var_0_0.getCurrencyType(arg_19_0)
	return CurrencyEnum.CurrencyType.RoomTrade
end

function var_0_0.onFinishWholesaleGoods(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_0:getWholesaleGoodsById(arg_20_1)

	if var_20_0 then
		var_20_0:refreshTodaySoldCount(arg_20_2)
	end

	arg_20_0.weeklyWholesaleRevenue = arg_20_3
end

var_0_0.WholesaleGoodPageCount = 4

function var_0_0.getWholesaleGoods(arg_21_0)
	if not arg_21_0._wholesaleOrderMos then
		arg_21_0._wholesaleOrderMos = {}
	end

	return arg_21_0._wholesaleOrderMos
end

function var_0_0.getWholesaleGoodsCount(arg_22_0)
	return tabletool.len(arg_22_0:getWholesaleGoods())
end

function var_0_0.getWholesaleGoodsById(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getWholesaleGoods()

	if var_23_0 then
		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			if iter_23_1.orderId == arg_23_1 then
				return iter_23_1, iter_23_0
			end
		end
	end
end

function var_0_0.getWholesaleGoodsPageMaxCount(arg_24_0)
	local var_24_0 = arg_24_0:getWholesaleGoodsCount()

	return math.ceil(var_24_0 / var_0_0.WholesaleGoodPageCount)
end

function var_0_0.getWholesaleGoodsByPageIndex(arg_25_0, arg_25_1)
	if arg_25_1 > arg_25_0:getWholesaleGoodsPageMaxCount() then
		return
	end

	local var_25_0 = arg_25_1 * var_0_0.WholesaleGoodPageCount
	local var_25_1 = arg_25_0:getWholesaleGoodsCount()

	if var_25_1 < var_25_0 then
		logError("超出订单数量")

		return
	end

	local var_25_2 = arg_25_0:getWholesaleGoods()
	local var_25_3 = {}
	local var_25_4 = math.min(var_25_0 + var_0_0.WholesaleGoodPageCount, var_25_1)

	for iter_25_0 = var_25_0 + 1, var_25_4 do
		local var_25_5 = var_25_2[iter_25_0]

		if var_25_5 then
			table.insert(var_25_3, var_25_5)
		end
	end

	return var_25_3
end

function var_0_0.getWeeklyWholesaleRevenue(arg_26_0)
	local var_26_0 = arg_26_0:getWholesaleRevenueWeeklyLimit()
	local var_26_1 = luaLang("room_wholesale_weekly_revenue")
	local var_26_2 = math.min(arg_26_0.weeklyWholesaleRevenue, var_26_0)

	return GameUtil.getSubPlaceholderLuaLangTwoParam(var_26_1, var_26_2, var_26_0)
end

function var_0_0.getWholesaleRevenueWeeklyLimit(arg_27_0)
	return arg_27_0:getCurLevelOrderConfig().wholesaleRevenueWeeklyLimit
end

function var_0_0.isMaxWeelyOrder(arg_28_0)
	return arg_28_0.weeklyWholesaleRevenue >= arg_28_0:getWholesaleRevenueWeeklyLimit()
end

function var_0_0.getCurLevelOrderConfig(arg_29_0)
	local var_29_0 = ManufactureModel.instance:getTradeLevel()

	return RoomTradeConfig.instance:getOrderRefreshInfo(var_29_0).co
end

function var_0_0._isFirstEnterToday(arg_30_0)
	return TimeUtil.getDayFirstLoginRed(var_0_1)
end

function var_0_0._saveEnterToday(arg_31_0)
	TimeUtil.setDayFirstLoginRed(var_0_1)
end

function var_0_0._getPrefBarrageBatch(arg_32_0, arg_32_1)
	return GameUtil.playerPrefsGetNumberByUserId(var_0_2 .. arg_32_1, 0)
end

function var_0_0._setPrefBarrageBatch(arg_33_0, arg_33_1, arg_33_2)
	GameUtil.playerPrefsSetNumberByUserId(var_0_2 .. arg_33_1, arg_33_2)
end

function var_0_0.initBarrage(arg_34_0)
	arg_34_0._barrageList = {}

	if arg_34_0:_isFirstEnterToday() then
		for iter_34_0, iter_34_1 in pairs(RoomTradeEnum.BarrageType) do
			if iter_34_1 == RoomTradeEnum.BarrageType.Dialogue then
				local var_34_0 = RoomTradeConfig.instance:getConstValue(RoomTradeEnum.ConstId.DialogueBarrageOdds, true)
				local var_34_1

				var_34_1 = var_34_0 and var_34_0 * 100 or 0

				if var_34_1 >= math.random(1, 100) then
					arg_34_0:_setBarrage(iter_34_1)
				else
					arg_34_0._barrageList[iter_34_1] = 0

					arg_34_0:_setPrefBarrageBatch(iter_34_1, 0)
				end
			else
				arg_34_0:_setBarrage(iter_34_1)
			end
		end

		arg_34_0:_saveEnterToday()
	else
		for iter_34_2, iter_34_3 in pairs(RoomTradeEnum.BarrageType) do
			local var_34_2 = arg_34_0:_getPrefBarrageBatch(iter_34_3)

			arg_34_0._barrageList[iter_34_3] = var_34_2
		end
	end
end

function var_0_0._setBarrage(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:_randomBarrage(arg_35_1)

	arg_35_0._barrageList[arg_35_1] = var_35_0

	arg_35_0:_setPrefBarrageBatch(arg_35_1, var_35_0)
end

function var_0_0._getBarrageIndex(arg_36_0, arg_36_1)
	return arg_36_0._barrageList[arg_36_1]
end

function var_0_0.getBarrageCo(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:_getBarrageIndex(arg_37_1)

	if var_37_0 and var_37_0 > 0 then
		return RoomTradeConfig.instance:getBarrageCoByTypeIndex(arg_37_1, var_37_0)
	end
end

function var_0_0._randomBarrage(arg_38_0, arg_38_1)
	local var_38_0 = RoomTradeConfig.instance:getBarrageTypeCount(arg_38_1)

	if var_38_0 > 0 then
		return (math.random(1, var_38_0))
	end

	return 0
end

function var_0_0.isCanPlayTradeEnterBtnUnlockAnim(arg_39_0)
	return GameUtil.playerPrefsGetNumberByUserId(var_0_3, 0) == 0
end

function var_0_0.setPlayTradeEnterBtnUnlockAnim(arg_40_0)
	GameUtil.playerPrefsSetNumberByUserId(var_0_3, 1)
end

function var_0_0.isGetOrderInfo(arg_41_0)
	return arg_41_0._isGetOrderInfo
end

var_0_0.instance = var_0_0.New()

return var_0_0
