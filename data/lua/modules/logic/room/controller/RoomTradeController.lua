module("modules.logic.room.controller.RoomTradeController", package.seeall)

slot0 = class("RoomTradeController", BaseController)

function slot0.finishDailyOrder(slot0, slot1, slot2, slot3)
	RoomRpc.instance:sendFinishOrderRequest(slot1, slot2, slot3)

	slot4 = {}

	if slot1 == RoomTradeEnum.Mode.DailyOrder then
		if not string.nilorempty(RoomTradeModel.instance:getDailyOrderById(slot2):getPrice()) then
			for slot11, slot12 in ipairs(GameUtil.splitString2(slot6, true)) do
				table.insert(slot4, {
					materilType = slot12[1],
					materilId = slot12[2],
					quantity = slot5:getPriceCount()
				})
			end
		end
	else
		slot6, slot7, slot8 = RoomTradeModel.instance:getWholesaleGoodsById(slot2):getUnitPrice()

		table.insert(slot4, {
			materilType = slot6,
			materilId = slot7,
			quantity = slot8 * slot3
		})
	end

	if LuaUtil.tableNotEmpty(slot4) then
		RoomController.instance:showInteractionRewardToast(slot4)
	end

	slot0:dispatchEvent(RoomTradeEvent.OnFlyCurrency)
end

function slot0.onFinishOrderReply(slot0, slot1)
	slot2 = {}

	if slot1.orderType == RoomTradeEnum.Mode.DailyOrder then
		RoomTradeModel.instance:onFinishDailyOrder(slot1.orderId, slot1.newPurchaseOrderInfo, slot1.remainRefreshCount)
	else
		RoomTradeModel.instance:onFinishWholesaleGoods(slot1.orderId, slot1.soldCount, slot1.weeklyWholesaleRevenue)
	end

	slot0:dispatchEvent(RoomTradeEvent.OnFinishOrder, slot1.orderType)
end

function slot0.refreshDailyOrder(slot0, slot1, slot2, slot3, slot4, slot5)
	RoomRpc.instance:sendRefreshPurchaseOrderRequest(slot1, slot2, slot3, slot4, slot5)
end

function slot0.onRefreshDailyOrderReply(slot0, slot1)
	RoomTradeModel.instance:onRefeshDailyOrder(slot1.orderInfo, slot1.remainRefreshCount)
	slot0:dispatchEvent(RoomTradeEvent.OnRefreshDailyOrder)
end

function slot0.tracedDailyOrder(slot0, slot1, slot2)
	RoomRpc.instance:sendChangePurchaseOrderTraceStateRequest(slot1, slot2)
end

function slot0.onTracedDailyOrderReply(slot0, slot1)
	RoomTradeModel.instance:onTracedDailyOrder(slot1.orderId, slot1.isTrace)
	slot0:dispatchEvent(RoomTradeEvent.OnTracedDailyOrder, slot1.orderId)
end

function slot0.lockedDailyOrder(slot0, slot1, slot2)
	RoomRpc.instance:sendLockOrderRequest(slot1, slot2)
end

function slot0.onLockedDailyOrderReply(slot0, slot1)
	RoomTradeModel.instance:setIsLockedOrder(slot1.orderId, slot1.isLocked)
	slot0:dispatchEvent(RoomTradeEvent.OnLockedDailyOrder, slot1.orderId)
end

function slot0.openLevelUpTipView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.RoomTradeLevelUpTipsView, {
		level = slot1
	})
end

slot0.instance = slot0.New()

return slot0
