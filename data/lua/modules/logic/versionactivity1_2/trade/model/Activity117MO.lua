module("modules.logic.versionactivity1_2.trade.model.Activity117MO", package.seeall)

local var_0_0 = pureTable("Activity117MO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._actId = arg_1_1
	arg_1_0._durationDay = Activity117Config.instance:getTotalActivityDays(arg_1_1)

	arg_1_0:initRewardDict()
	arg_1_0:resetData()
end

function var_0_0.resetData(arg_2_0)
	arg_2_0._orderDataDict = {}
	arg_2_0._score = 0
	arg_2_0._inQuote = nil

	arg_2_0:setSelectOrder()
end

function var_0_0.onNegotiateResult(arg_3_0, arg_3_1)
	arg_3_0:setInQuote(false)
	arg_3_0:updateOrder(arg_3_1.order)
end

function var_0_0.onDealSuccess(arg_4_0, arg_4_1)
	arg_4_0:setInQuote(false)
	arg_4_0:setSelectOrder()

	local var_4_0 = arg_4_0:updateOrder(arg_4_1.order)

	if var_4_0 then
		local var_4_1 = var_4_0:getLastRound() or 0

		if var_4_0:checkPrice(var_4_1) == Activity117Enum.PriceType.Bad then
			var_4_1 = var_4_0:getMinPrice()
		end

		local var_4_2 = {
			score = var_4_1,
			curScore = arg_4_0._score,
			nextScore = arg_4_0:getNextScore(arg_4_0._score)
		}

		arg_4_0._score = arg_4_0._score + var_4_1

		Activity117Controller.instance:openTradeSuccessView(var_4_2)
	end
end

function var_0_0.onOrderPush(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getOrderData(arg_5_1.order.id)
	local var_5_1 = var_5_0 and var_5_0:isProgressEnough()
	local var_5_2 = arg_5_0:updateOrder(arg_5_1.order)

	if not var_5_1 and var_5_2 and var_5_2:isProgressEnough() then
		local var_5_3 = Activity117Config.instance:getOrderConfig(arg_5_0._actId, var_5_2.id)

		if var_5_3 then
			local var_5_4 = string.match(var_5_3.name, "<.->(.-)<.->") or var_5_3.name

			GameFacade.showToast(ToastEnum.TradeSuccess, var_5_4)
		end
	end
end

function var_0_0.onInitServerData(arg_6_0, arg_6_1)
	arg_6_0:resetData()
	arg_6_0:updateOrders(arg_6_1.orders)

	arg_6_0._score = arg_6_1.score

	arg_6_0:updateHasGetBonusIds(arg_6_1.hasGetBonusIds)
end

function var_0_0.updateHasGetBonusIds(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	for iter_7_0 = 1, #arg_7_1 do
		local var_7_0 = arg_7_0:getRewardData(arg_7_1[iter_7_0])

		if var_7_0 then
			var_7_0:updateServerData(true)
		end
	end
end

function var_0_0.updateOrders(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return
	end

	for iter_8_0 = 1, #arg_8_1 do
		arg_8_0:updateOrder(arg_8_1[iter_8_0])
	end
end

function var_0_0.updateOrder(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	local var_9_0 = arg_9_0:getOrderData(arg_9_1.id)

	if var_9_0 then
		var_9_0:updateServerData(arg_9_1)
	end

	return var_9_0
end

function var_0_0.getOrderData(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0._orderDataDict
	local var_10_1 = var_10_0[arg_10_1]

	if not var_10_0[arg_10_1] and not arg_10_2 then
		var_10_1 = Activity117OrderMO.New()

		var_10_1:init(arg_10_0._actId, arg_10_1)

		var_10_0[arg_10_1] = var_10_1
	end

	return var_10_1
end

function var_0_0.getOrderList(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._orderDataDict
	local var_11_1 = {}

	if var_11_0 then
		for iter_11_0, iter_11_1 in pairs(var_11_0) do
			table.insert(var_11_1, iter_11_1)
		end

		if not arg_11_1 then
			table.sort(var_11_1, Activity117OrderMO.sortOrderFunc)
		end
	end

	return var_11_1
end

function var_0_0.setInQuote(arg_12_0, arg_12_1)
	arg_12_0._inQuote = arg_12_1
end

function var_0_0.isInQuote(arg_13_0)
	return arg_13_0._inQuote
end

function var_0_0.getRemainDay(arg_14_0)
	local var_14_0 = ActivityModel.instance:getActMO(arg_14_0._actId)
	local var_14_1 = (var_14_0 and var_14_0.endTime or 0) / 1000
	local var_14_2 = ServerTime.nowInLocal()

	return TimeUtil.secondsToDDHHMMSS(var_14_1 - var_14_2)
end

function var_0_0.getCurrentScore(arg_15_0)
	return arg_15_0._score or 0
end

function var_0_0.getActId(arg_16_0)
	return arg_16_0._actId
end

function var_0_0.setSelectOrder(arg_17_0, arg_17_1)
	if arg_17_1 == arg_17_0._selectOrder then
		return
	end

	arg_17_0._selectOrder = arg_17_1

	if not arg_17_1 then
		Activity117Controller.instance:dispatchEvent(Activity117Event.PlayTalk, arg_17_0._actId)
	end

	Activity117Controller.instance:dispatchEvent(Activity117Event.BargainStatusChange, arg_17_0._actId)
end

function var_0_0.getSelectOrder(arg_18_0)
	return arg_18_0._selectOrder
end

function var_0_0.initRewardDict(arg_19_0)
	local var_19_0 = Activity117Config.instance:getAllBonusConfig(arg_19_0._actId)

	arg_19_0.rewardDict = {}

	if var_19_0 then
		for iter_19_0, iter_19_1 in ipairs(var_19_0) do
			arg_19_0:getRewardData(iter_19_1.id, true):updateServerData(false)
		end
	end
end

function var_0_0.getRewardData(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.rewardDict[arg_20_1]

	if not var_20_0 and arg_20_2 then
		local var_20_1 = Activity117Config.instance:getBonusConfig(arg_20_0._actId, arg_20_1)

		if var_20_1 then
			var_20_0 = Activity117RewardMO.New()

			var_20_0:init(var_20_1)

			arg_20_0.rewardDict[arg_20_1] = var_20_0
		end
	end

	return var_20_0
end

function var_0_0.getRewardList(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = 0

	for iter_21_0, iter_21_1 in pairs(arg_21_0.rewardDict) do
		if iter_21_1:getStatus() == Activity117Enum.Status.CanGet then
			var_21_1 = var_21_1 + 1
		end

		table.insert(var_21_0, iter_21_1)
	end

	table.sort(var_21_0, Activity117RewardMO.sortFunc)

	return var_21_0, var_21_1
end

function var_0_0.getFinishOrderCount(arg_22_0)
	local var_22_0 = CommonConfig.instance:getConstNum(ConstEnum.ActivityTradeMaxTimes)
	local var_22_1 = arg_22_0:getOrderList(true)
	local var_22_2 = 0

	for iter_22_0, iter_22_1 in pairs(var_22_1) do
		if iter_22_1.hasGetBonus then
			var_22_2 = var_22_2 + 1
		end
	end

	return var_22_2, var_22_0
end

function var_0_0.getNextScore(arg_23_0, arg_23_1)
	local var_23_0 = Activity117Config.instance:getAllBonusConfig(arg_23_0._actId)
	local var_23_1 = 0

	if var_23_0 then
		local var_23_2 = {}

		for iter_23_0, iter_23_1 in pairs(var_23_0) do
			table.insert(var_23_2, iter_23_1)
		end

		table.sort(var_23_2, function(arg_24_0, arg_24_1)
			return arg_24_0.needScore < arg_24_1.needScore
		end)

		for iter_23_2, iter_23_3 in ipairs(var_23_2) do
			if arg_23_1 < iter_23_3.needScore then
				var_23_1 = iter_23_3.needScore

				break
			end
		end
	end

	return var_23_1
end

return var_0_0
