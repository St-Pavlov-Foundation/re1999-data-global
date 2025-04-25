module("modules.logic.room.model.trade.RoomTradeModel", package.seeall)

slot0 = class("RoomTradeModel", BaseModel)
slot1 = "RoomTrade_Barrage_FirstEnter"
slot2 = "RoomTrade_BarrageBatch"
slot3 = "RoomTrade_PlayTradeEnterBtnAnim"

function slot0.onInit(slot0)
	slot0:clearData()
end

function slot0.reInit(slot0)
	slot0:clearData()
end

function slot0.clearData(slot0)
	slot0._traceItemDict = {}
	slot0._traceChildItemDict = {}
	slot0._isGetOrderInfo = false
end

function slot0.onGetOrderInfo(slot0, slot1)
	slot0.purchaseOrderFinishCount = slot1.purchaseOrderFinishCount
	slot3 = slot1.wholesaleOrderInfos
	slot0._remainRefreshCount = slot1.remainRefreshCount
	slot0.weeklyWholesaleRevenue = slot1.weeklyWholesaleRevenue or 0
	slot0._dailyOrderMos = {}

	if slot1.purchaseOrderInfos then
		for slot7 = 1, #slot2 do
			slot9 = RoomDailyOrderMo.New()

			slot9:initMo(slot2[slot7], false)
			table.insert(slot0._dailyOrderMos, slot9)
		end
	end

	slot0:calTracedItemDict()

	slot0._wholesaleOrderMos = {}

	if slot3 then
		for slot7 = 1, #slot3 do
			slot9 = RoomWholesaleOrderMo.New()

			slot9:initMo(slot3[slot7])
			table.insert(slot0._wholesaleOrderMos, slot9)
		end
	end

	slot0._isGetOrderInfo = true
end

function slot0.getDailyOrderFinishCount(slot0)
	return slot0.purchaseOrderFinishCount or 0, slot0:getCurLevelOrderConfig().finishLimitDaily or 0
end

function slot0.onFinishDailyOrder(slot0, slot1, slot2, slot3)
	slot0._remainRefreshCount = slot3
	slot0.purchaseOrderFinishCount = slot0.purchaseOrderFinishCount + 1
	slot4 = slot0:getDailyOrderById(slot1)

	if slot2 and #slot2.goodsInfo > 0 then
		if slot4 then
			slot4:initMo(slot2, true)
		end
	else
		slot4:setFinish()
	end

	slot0:calTracedItemDict()
end

function slot0.onRefeshDailyOrder(slot0, slot1, slot2)
	slot0._remainRefreshCount = slot2

	if slot0:getDailyOrders() then
		for slot7, slot8 in ipairs(slot3) do
			if slot8:isWaitRefresh() then
				slot8:initMo(slot1, true)

				return
			end
		end
	end

	slot0:calTracedItemDict()
end

function slot0.getRefreshCount(slot0)
	return slot0._remainRefreshCount or 0, RoomTradeConfig.instance:getConstValue(RoomTradeEnum.ConstId.DailyOrderFinishMaxCount, true) or 0
end

function slot0.isCanRefreshDailyOrder(slot0)
	return slot0._remainRefreshCount ~= 0
end

function slot0.onTracedDailyOrder(slot0, slot1, slot2)
	if slot0:getDailyOrderById(slot1) then
		slot3:setTraced(slot2)
	end

	slot0:calTracedItemDict()
end

function slot0.calTracedItemDict(slot0)
	slot0._traceItemDict = {}
	slot0._traceChildItemDict = {}

	for slot5, slot6 in ipairs(slot0:getDailyOrders()) do
		if slot6.isTraced then
			for slot10, slot11 in ipairs(slot6:getGoodsInfo()) do
				slot0._traceItemDict[slot12] = (slot0._traceItemDict[ManufactureConfig.instance:getItemId(slot11.productionId)] or 0) + slot11.quantity
				slot13, slot14 = ManufactureModel.instance:getManufactureItemCount(slot11.productionId, true, true)

				slot0:_addMatTracedCount(slot11.productionId, slot11.quantity - (slot13 + slot14))
			end
		end
	end
end

function slot0._addMatTracedCount(slot0, slot1, slot2)
	if not slot1 or not ManufactureConfig.instance:getNeedMatItemList(slot1) or #slot3 <= 0 then
		return
	end

	for slot7, slot8 in ipairs(slot3) do
		slot10 = slot8.quantity * math.max(0, slot2)
		slot0._traceChildItemDict[slot9] = (slot0._traceChildItemDict[ManufactureConfig.instance:getItemId(slot8.id)] or 0) + slot10
		slot11, slot12 = ManufactureModel.instance:getManufactureItemCount(slot8.id, true, true)

		slot0:_addMatTracedCount(slot8.id, slot10 - (slot11 + slot12))
	end
end

function slot0.isTracedGoods(slot0, slot1)
	slot2 = false
	slot3, slot4 = slot0:getDailyOrderFinishCount()

	if slot3 < slot4 then
		slot5 = ManufactureConfig.instance:getItemId(slot1)
		slot2 = slot0._traceItemDict and slot0._traceItemDict[slot5] or slot0._traceChildItemDict and slot0._traceChildItemDict[slot5]
	end

	return slot2
end

function slot0.getTracedGoodsCount(slot0, slot1)
	if not slot0:isTracedGoods(slot1) then
		return 0, 0
	end

	slot5 = ManufactureConfig.instance:getItemId(slot1)

	return slot0._traceItemDict and slot0._traceItemDict[slot5] or 0, slot0._traceChildItemDict and slot0._traceChildItemDict[slot5] or 0
end

function slot0.setIsLockedOrder(slot0, slot1, slot2)
	if slot0:getDailyOrderById(slot1) then
		slot3:setLocked(slot2)
	end
end

function slot0.isLockedOrder(slot0, slot1)
	if slot0:getDailyOrderById(slot1) then
		return slot2:getLocked()
	end
end

function slot0.getDailyOrders(slot0)
	if not slot0._dailyOrderMos then
		slot0._dailyOrderMos = {}
	end

	return slot0._dailyOrderMos
end

function slot0.getDailyOrderById(slot0, slot1)
	if slot0:getDailyOrders() then
		for slot6, slot7 in ipairs(slot2) do
			if slot7.orderId == slot1 then
				return slot7, slot6
			end
		end
	end
end

function slot0.getCurrencyType(slot0)
	return CurrencyEnum.CurrencyType.RoomTrade
end

function slot0.onFinishWholesaleGoods(slot0, slot1, slot2, slot3)
	if slot0:getWholesaleGoodsById(slot1) then
		slot4:refreshTodaySoldCount(slot2)
	end

	slot0.weeklyWholesaleRevenue = slot3
end

slot0.WholesaleGoodPageCount = 4

function slot0.getWholesaleGoods(slot0)
	if not slot0._wholesaleOrderMos then
		slot0._wholesaleOrderMos = {}
	end

	return slot0._wholesaleOrderMos
end

function slot0.getWholesaleGoodsCount(slot0)
	return tabletool.len(slot0:getWholesaleGoods())
end

function slot0.getWholesaleGoodsById(slot0, slot1)
	if slot0:getWholesaleGoods() then
		for slot6, slot7 in ipairs(slot2) do
			if slot7.orderId == slot1 then
				return slot7, slot6
			end
		end
	end
end

function slot0.getWholesaleGoodsPageMaxCount(slot0)
	return math.ceil(slot0:getWholesaleGoodsCount() / uv0.WholesaleGoodPageCount)
end

function slot0.getWholesaleGoodsByPageIndex(slot0, slot1)
	if slot0:getWholesaleGoodsPageMaxCount() < slot1 then
		return
	end

	if slot0:getWholesaleGoodsCount() < slot1 * uv0.WholesaleGoodPageCount then
		logError("超出订单数量")

		return
	end

	slot5 = {}

	for slot10 = slot2 + 1, math.min(slot2 + uv0.WholesaleGoodPageCount, slot3) do
		if slot0:getWholesaleGoods()[slot10] then
			table.insert(slot5, slot11)
		end
	end

	return slot5
end

function slot0.getWeeklyWholesaleRevenue(slot0)
	slot1 = slot0:getWholesaleRevenueWeeklyLimit()

	return GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_wholesale_weekly_revenue"), math.min(slot0.weeklyWholesaleRevenue, slot1), slot1)
end

function slot0.getWholesaleRevenueWeeklyLimit(slot0)
	return slot0:getCurLevelOrderConfig().wholesaleRevenueWeeklyLimit
end

function slot0.isMaxWeelyOrder(slot0)
	return slot0:getWholesaleRevenueWeeklyLimit() <= slot0.weeklyWholesaleRevenue
end

function slot0.getCurLevelOrderConfig(slot0)
	return RoomTradeConfig.instance:getOrderRefreshInfo(ManufactureModel.instance:getTradeLevel()).co
end

function slot0._isFirstEnterToday(slot0)
	return TimeUtil.getDayFirstLoginRed(uv0)
end

function slot0._saveEnterToday(slot0)
	TimeUtil.setDayFirstLoginRed(uv0)
end

function slot0._getPrefBarrageBatch(slot0, slot1)
	return GameUtil.playerPrefsGetNumberByUserId(uv0 .. slot1, 0)
end

function slot0._setPrefBarrageBatch(slot0, slot1, slot2)
	GameUtil.playerPrefsSetNumberByUserId(uv0 .. slot1, slot2)
end

function slot0.initBarrage(slot0)
	slot0._barrageList = {}

	if slot0:_isFirstEnterToday() then
		for slot4, slot5 in pairs(RoomTradeEnum.BarrageType) do
			if slot5 == RoomTradeEnum.BarrageType.Dialogue then
				if math.random(1, 100) <= (RoomTradeConfig.instance:getConstValue(RoomTradeEnum.ConstId.DialogueBarrageOdds, true) and slot6 * 100 or 0) then
					slot0:_setBarrage(slot5)
				else
					slot0._barrageList[slot5] = 0

					slot0:_setPrefBarrageBatch(slot5, 0)
				end
			else
				slot0:_setBarrage(slot5)
			end
		end

		slot0:_saveEnterToday()
	else
		for slot4, slot5 in pairs(RoomTradeEnum.BarrageType) do
			slot0._barrageList[slot5] = slot0:_getPrefBarrageBatch(slot5)
		end
	end
end

function slot0._setBarrage(slot0, slot1)
	slot2 = slot0:_randomBarrage(slot1)
	slot0._barrageList[slot1] = slot2

	slot0:_setPrefBarrageBatch(slot1, slot2)
end

function slot0._getBarrageIndex(slot0, slot1)
	return slot0._barrageList[slot1]
end

function slot0.getBarrageCo(slot0, slot1)
	if slot0:_getBarrageIndex(slot1) and slot2 > 0 then
		return RoomTradeConfig.instance:getBarrageCoByTypeIndex(slot1, slot2)
	end
end

function slot0._randomBarrage(slot0, slot1)
	if RoomTradeConfig.instance:getBarrageTypeCount(slot1) > 0 then
		return math.random(1, slot2)
	end

	return 0
end

function slot0.isCanPlayTradeEnterBtnUnlockAnim(slot0)
	return GameUtil.playerPrefsGetNumberByUserId(uv0, 0) == 0
end

function slot0.setPlayTradeEnterBtnUnlockAnim(slot0)
	GameUtil.playerPrefsSetNumberByUserId(uv0, 1)
end

function slot0.isGetOrderInfo(slot0)
	return slot0._isGetOrderInfo
end

slot0.instance = slot0.New()

return slot0
