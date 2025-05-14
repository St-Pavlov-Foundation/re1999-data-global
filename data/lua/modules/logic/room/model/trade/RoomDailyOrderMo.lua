module("modules.logic.room.model.trade.RoomDailyOrderMo", package.seeall)

local var_0_0 = class("RoomDailyOrderMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.orderId = nil
	arg_1_0.lastRefreshTime = nil
	arg_1_0.buyerId = nil
	arg_1_0.goodsInfo = nil
	arg_1_0.isAdvanced = nil
	arg_1_0.isTraced = nil
	arg_1_0.waitRefresh = nil
	arg_1_0.refreshType = nil
	arg_1_0.isLocked = nil
	arg_1_0.isFinish = nil
end

function var_0_0.initMo(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.orderId = arg_2_1.orderId
	arg_2_0.lastRefreshTime = arg_2_1.lastRefreshTime
	arg_2_0.buyerId = arg_2_1.buyerId
	arg_2_0.isAdvanced = arg_2_1.isAdvanced
	arg_2_0.isTraced = arg_2_1.isTraced
	arg_2_0.refreshType = arg_2_1.refreshType
	arg_2_0.isLocked = arg_2_1.isLocked
	arg_2_0.goodsInfo = {}
	arg_2_0._orderPrice = 0

	for iter_2_0 = 1, #arg_2_1.goodsInfo do
		local var_2_0 = RoomProductionMo.New()

		var_2_0:initMo(arg_2_1.goodsInfo[iter_2_0])
		table.insert(arg_2_0.goodsInfo, var_2_0)

		arg_2_0._orderPrice = arg_2_0._orderPrice + var_2_0:getOrderPrice()
	end

	local var_2_1 = arg_2_0:getAdvancedRate()

	if arg_2_0.isAdvanced then
		arg_2_0._orderPrice = arg_2_0._orderPrice * var_2_1
	end

	arg_2_0.isNewRefresh = arg_2_2
	arg_2_0.waitRefresh = nil
	arg_2_0._orderCo = RoomTradeConfig.instance:getOrderQualityInfo(arg_2_0.orderId)
	arg_2_0.isFinish = false
end

function var_0_0.getAdvancedRate(arg_3_0)
	return 1 + (RoomTradeConfig.instance:getConstValue(RoomTradeEnum.ConstId.DailyHighOrderAddRate, true) or 0) * 0.0001
end

function var_0_0.setFinish(arg_4_0)
	arg_4_0.isFinish = true
end

function var_0_0.getPrice(arg_5_0)
	return arg_5_0._orderCo.co.price
end

function var_0_0.getPriceCount(arg_6_0)
	return GameUtil.numberDisplay(arg_6_0._orderPrice)
end

function var_0_0.setWaitRefresh(arg_7_0, arg_7_1)
	arg_7_0.waitRefresh = arg_7_1
end

function var_0_0.isWaitRefresh(arg_8_0)
	return arg_8_0.waitRefresh
end

function var_0_0.cancelNewRefresh(arg_9_0)
	arg_9_0.isNewRefresh = false
end

function var_0_0.setTraced(arg_10_0, arg_10_1)
	arg_10_0.isTraced = arg_10_1
end

function var_0_0.setLocked(arg_11_0, arg_11_1)
	arg_11_0.isLocked = arg_11_1
end

function var_0_0.getLocked(arg_12_0)
	return arg_12_0.isLocked
end

function var_0_0.checkGoodsCanProduct(arg_13_0)
	local var_13_0
	local var_13_1

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.goodsInfo) do
		if iter_13_1:isPlacedProduceBuilding() then
			if string.nilorempty(var_13_0) or not var_13_1 then
				local var_13_2, var_13_3 = iter_13_1:checkProduceBuildingLevel()

				if var_13_2 then
					var_13_0 = luaLang("room_produce_building_need_upgrade")
					var_13_1 = var_13_3
				end
			end
		else
			var_13_0 = luaLang("room_no_produce_building")
			var_13_1 = nil

			break
		end
	end

	return var_13_0, var_13_1
end

function var_0_0.isCanConfirm(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.goodsInfo) do
		if not iter_14_1:isEnoughCount() then
			return false
		end
	end

	return true
end

function var_0_0.getRefreshTime(arg_15_0)
	local var_15_0 = 0

	if arg_15_0.lastRefreshTime and arg_15_0.refreshType == RoomTradeEnum.RefreshType.ActiveRefresh then
		local var_15_1 = ServerTime.now() - arg_15_0.lastRefreshTime

		var_15_0 = RoomTradeConfig.instance:getConstValue(RoomTradeEnum.ConstId.DailyOrderRefreshTime, true) - var_15_1
	end

	return var_15_0
end

function var_0_0.getGoodsInfo(arg_16_0)
	return arg_16_0.goodsInfo
end

return var_0_0
