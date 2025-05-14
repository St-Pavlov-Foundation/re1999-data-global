module("modules.logic.room.controller.RoomTradeController", package.seeall)

local var_0_0 = class("RoomTradeController", BaseController)

function var_0_0.finishDailyOrder(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	RoomRpc.instance:sendFinishOrderRequest(arg_1_1, arg_1_2, arg_1_3)

	local var_1_0 = {}

	if arg_1_1 == RoomTradeEnum.Mode.DailyOrder then
		local var_1_1 = RoomTradeModel.instance:getDailyOrderById(arg_1_2)
		local var_1_2 = var_1_1:getPrice()

		if not string.nilorempty(var_1_2) then
			local var_1_3 = GameUtil.splitString2(var_1_2, true)

			for iter_1_0, iter_1_1 in ipairs(var_1_3) do
				local var_1_4 = {
					materilType = iter_1_1[1],
					materilId = iter_1_1[2],
					quantity = var_1_1:getPriceCount()
				}

				table.insert(var_1_0, var_1_4)
			end
		end
	else
		local var_1_5, var_1_6, var_1_7 = RoomTradeModel.instance:getWholesaleGoodsById(arg_1_2):getUnitPrice()
		local var_1_8 = {
			materilType = var_1_5,
			materilId = var_1_6,
			quantity = var_1_7 * arg_1_3
		}

		table.insert(var_1_0, var_1_8)
	end

	if LuaUtil.tableNotEmpty(var_1_0) then
		RoomController.instance:showInteractionRewardToast(var_1_0)
	end

	arg_1_0:dispatchEvent(RoomTradeEvent.OnFlyCurrency)
end

function var_0_0.onFinishOrderReply(arg_2_0, arg_2_1)
	local var_2_0 = {}

	if arg_2_1.orderType == RoomTradeEnum.Mode.DailyOrder then
		RoomTradeModel.instance:onFinishDailyOrder(arg_2_1.orderId, arg_2_1.newPurchaseOrderInfo, arg_2_1.remainRefreshCount)
	else
		RoomTradeModel.instance:onFinishWholesaleGoods(arg_2_1.orderId, arg_2_1.soldCount, arg_2_1.weeklyWholesaleRevenue)
	end

	arg_2_0:dispatchEvent(RoomTradeEvent.OnFinishOrder, arg_2_1.orderType)
end

function var_0_0.refreshDailyOrder(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	RoomRpc.instance:sendRefreshPurchaseOrderRequest(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
end

function var_0_0.onRefreshDailyOrderReply(arg_4_0, arg_4_1)
	RoomTradeModel.instance:onRefeshDailyOrder(arg_4_1.orderInfo, arg_4_1.remainRefreshCount)
	arg_4_0:dispatchEvent(RoomTradeEvent.OnRefreshDailyOrder)
end

function var_0_0.tracedDailyOrder(arg_5_0, arg_5_1, arg_5_2)
	RoomRpc.instance:sendChangePurchaseOrderTraceStateRequest(arg_5_1, arg_5_2)
end

function var_0_0.onTracedDailyOrderReply(arg_6_0, arg_6_1)
	RoomTradeModel.instance:onTracedDailyOrder(arg_6_1.orderId, arg_6_1.isTrace)
	arg_6_0:dispatchEvent(RoomTradeEvent.OnTracedDailyOrder, arg_6_1.orderId)
end

function var_0_0.lockedDailyOrder(arg_7_0, arg_7_1, arg_7_2)
	RoomRpc.instance:sendLockOrderRequest(arg_7_1, arg_7_2)
end

function var_0_0.onLockedDailyOrderReply(arg_8_0, arg_8_1)
	RoomTradeModel.instance:setIsLockedOrder(arg_8_1.orderId, arg_8_1.isLocked)
	arg_8_0:dispatchEvent(RoomTradeEvent.OnLockedDailyOrder, arg_8_1.orderId)
end

function var_0_0.openLevelUpTipView(arg_9_0, arg_9_1)
	local var_9_0 = {
		level = arg_9_1
	}

	ViewMgr.instance:openView(ViewName.RoomTradeLevelUpTipsView, var_9_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
