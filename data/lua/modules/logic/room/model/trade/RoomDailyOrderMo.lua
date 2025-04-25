module("modules.logic.room.model.trade.RoomDailyOrderMo", package.seeall)

slot0 = class("RoomDailyOrderMo")

function slot0.ctor(slot0)
	slot0.orderId = nil
	slot0.lastRefreshTime = nil
	slot0.buyerId = nil
	slot0.goodsInfo = nil
	slot0.isAdvanced = nil
	slot0.isTraced = nil
	slot0.waitRefresh = nil
	slot0.refreshType = nil
	slot0.isLocked = nil
	slot0.isFinish = nil
end

function slot0.initMo(slot0, slot1, slot2)
	slot0.orderId = slot1.orderId
	slot0.lastRefreshTime = slot1.lastRefreshTime
	slot0.buyerId = slot1.buyerId
	slot0.isAdvanced = slot1.isAdvanced
	slot0.isTraced = slot1.isTraced
	slot0.refreshType = slot1.refreshType
	slot0.isLocked = slot1.isLocked
	slot0.goodsInfo = {}
	slot0._orderPrice = 0

	for slot6 = 1, #slot1.goodsInfo do
		slot7 = RoomProductionMo.New()

		slot7:initMo(slot1.goodsInfo[slot6])
		table.insert(slot0.goodsInfo, slot7)

		slot0._orderPrice = slot0._orderPrice + slot7:getOrderPrice()
	end

	if slot0.isAdvanced then
		slot0._orderPrice = slot0._orderPrice * slot0:getAdvancedRate()
	end

	slot0.isNewRefresh = slot2
	slot0.waitRefresh = nil
	slot0._orderCo = RoomTradeConfig.instance:getOrderQualityInfo(slot0.orderId)
	slot0.isFinish = false
end

function slot0.getAdvancedRate(slot0)
	return 1 + (RoomTradeConfig.instance:getConstValue(RoomTradeEnum.ConstId.DailyHighOrderAddRate, true) or 0) * 0.0001
end

function slot0.setFinish(slot0)
	slot0.isFinish = true
end

function slot0.getPrice(slot0)
	return slot0._orderCo.co.price
end

function slot0.getPriceCount(slot0)
	return GameUtil.numberDisplay(slot0._orderPrice)
end

function slot0.setWaitRefresh(slot0, slot1)
	slot0.waitRefresh = slot1
end

function slot0.isWaitRefresh(slot0)
	return slot0.waitRefresh
end

function slot0.cancelNewRefresh(slot0)
	slot0.isNewRefresh = false
end

function slot0.setTraced(slot0, slot1)
	slot0.isTraced = slot1
end

function slot0.setLocked(slot0, slot1)
	slot0.isLocked = slot1
end

function slot0.getLocked(slot0)
	return slot0.isLocked
end

function slot0.checkGoodsCanProduct(slot0)
	for slot6, slot7 in ipairs(slot0.goodsInfo) do
		if slot7:isPlacedProduceBuilding() then
			if string.nilorempty(nil) or not nil then
				slot9, slot2 = slot7:checkProduceBuildingLevel()

				if slot9 then
					slot1 = luaLang("room_produce_building_need_upgrade")
				end
			end
		else
			slot1 = luaLang("room_no_produce_building")
			slot2 = nil

			break
		end
	end

	return slot1, slot2
end

function slot0.isCanConfirm(slot0)
	for slot4, slot5 in ipairs(slot0.goodsInfo) do
		if not slot5:isEnoughCount() then
			return false
		end
	end

	return true
end

function slot0.getRefreshTime(slot0)
	slot1 = 0

	if slot0.lastRefreshTime and slot0.refreshType == RoomTradeEnum.RefreshType.ActiveRefresh then
		slot1 = RoomTradeConfig.instance:getConstValue(RoomTradeEnum.ConstId.DailyOrderRefreshTime, true) - (ServerTime.now() - slot0.lastRefreshTime)
	end

	return slot1
end

function slot0.getGoodsInfo(slot0)
	return slot0.goodsInfo
end

return slot0
