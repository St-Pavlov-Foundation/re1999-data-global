module("modules.logic.versionactivity1_2.trade.model.Activity117MO", package.seeall)

slot0 = pureTable("Activity117MO")

function slot0.init(slot0, slot1)
	slot0._actId = slot1
	slot0._durationDay = Activity117Config.instance:getTotalActivityDays(slot1)

	slot0:initRewardDict()
	slot0:resetData()
end

function slot0.resetData(slot0)
	slot0._orderDataDict = {}
	slot0._score = 0
	slot0._inQuote = nil

	slot0:setSelectOrder()
end

function slot0.onNegotiateResult(slot0, slot1)
	slot0:setInQuote(false)
	slot0:updateOrder(slot1.order)
end

function slot0.onDealSuccess(slot0, slot1)
	slot0:setInQuote(false)
	slot0:setSelectOrder()

	if slot0:updateOrder(slot1.order) then
		if slot2:checkPrice(slot2:getLastRound() or 0) == Activity117Enum.PriceType.Bad then
			slot3 = slot2:getMinPrice()
		end

		slot0._score = slot0._score + slot3

		Activity117Controller.instance:openTradeSuccessView({
			score = slot3,
			curScore = slot0._score,
			nextScore = slot0:getNextScore(slot0._score)
		})
	end
end

function slot0.onOrderPush(slot0, slot1)
	slot4 = slot0:updateOrder(slot1.order)

	if not (slot0:getOrderData(slot1.order.id) and slot2:isProgressEnough()) and slot4 and slot4:isProgressEnough() and Activity117Config.instance:getOrderConfig(slot0._actId, slot4.id) then
		GameFacade.showToast(ToastEnum.TradeSuccess, string.match(slot5.name, "<.->(.-)<.->") or slot5.name)
	end
end

function slot0.onInitServerData(slot0, slot1)
	slot0:resetData()
	slot0:updateOrders(slot1.orders)

	slot0._score = slot1.score

	slot0:updateHasGetBonusIds(slot1.hasGetBonusIds)
end

function slot0.updateHasGetBonusIds(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5 = 1, #slot1 do
		if slot0:getRewardData(slot1[slot5]) then
			slot6:updateServerData(true)
		end
	end
end

function slot0.updateOrders(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5 = 1, #slot1 do
		slot0:updateOrder(slot1[slot5])
	end
end

function slot0.updateOrder(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0:getOrderData(slot1.id) then
		slot2:updateServerData(slot1)
	end

	return slot2
end

function slot0.getOrderData(slot0, slot1, slot2)
	slot3 = slot0._orderDataDict
	slot4 = slot3[slot1]

	if not slot3[slot1] and not slot2 then
		slot4 = Activity117OrderMO.New()

		slot4:init(slot0._actId, slot1)

		slot3[slot1] = slot4
	end

	return slot4
end

function slot0.getOrderList(slot0, slot1)
	slot3 = {}

	if slot0._orderDataDict then
		for slot7, slot8 in pairs(slot2) do
			table.insert(slot3, slot8)
		end

		if not slot1 then
			table.sort(slot3, Activity117OrderMO.sortOrderFunc)
		end
	end

	return slot3
end

function slot0.setInQuote(slot0, slot1)
	slot0._inQuote = slot1
end

function slot0.isInQuote(slot0)
	return slot0._inQuote
end

function slot0.getRemainDay(slot0)
	return TimeUtil.secondsToDDHHMMSS((ActivityModel.instance:getActMO(slot0._actId) and slot1.endTime or 0) / 1000 - ServerTime.nowInLocal())
end

function slot0.getCurrentScore(slot0)
	return slot0._score or 0
end

function slot0.getActId(slot0)
	return slot0._actId
end

function slot0.setSelectOrder(slot0, slot1)
	if slot1 == slot0._selectOrder then
		return
	end

	slot0._selectOrder = slot1

	if not slot1 then
		Activity117Controller.instance:dispatchEvent(Activity117Event.PlayTalk, slot0._actId)
	end

	Activity117Controller.instance:dispatchEvent(Activity117Event.BargainStatusChange, slot0._actId)
end

function slot0.getSelectOrder(slot0)
	return slot0._selectOrder
end

function slot0.initRewardDict(slot0)
	slot0.rewardDict = {}

	if Activity117Config.instance:getAllBonusConfig(slot0._actId) then
		for slot5, slot6 in ipairs(slot1) do
			slot0:getRewardData(slot6.id, true):updateServerData(false)
		end
	end
end

function slot0.getRewardData(slot0, slot1, slot2)
	if not slot0.rewardDict[slot1] and slot2 and Activity117Config.instance:getBonusConfig(slot0._actId, slot1) then
		slot3 = Activity117RewardMO.New()

		slot3:init(slot4)

		slot0.rewardDict[slot1] = slot3
	end

	return slot3
end

function slot0.getRewardList(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(slot0.rewardDict) do
		if slot7:getStatus() == Activity117Enum.Status.CanGet then
			slot2 = 0 + 1
		end

		table.insert(slot1, slot7)
	end

	table.sort(slot1, Activity117RewardMO.sortFunc)

	return slot1, slot2
end

function slot0.getFinishOrderCount(slot0)
	slot1 = CommonConfig.instance:getConstNum(ConstEnum.ActivityTradeMaxTimes)

	for slot7, slot8 in pairs(slot0:getOrderList(true)) do
		if slot8.hasGetBonus then
			slot3 = 0 + 1
		end
	end

	return slot3, slot1
end

function slot0.getNextScore(slot0, slot1)
	slot3 = 0

	if Activity117Config.instance:getAllBonusConfig(slot0._actId) then
		slot4 = {}

		for slot8, slot9 in pairs(slot2) do
			table.insert(slot4, slot9)
		end

		function slot8(slot0, slot1)
			return slot0.needScore < slot1.needScore
		end

		table.sort(slot4, slot8)

		for slot8, slot9 in ipairs(slot4) do
			if slot1 < slot9.needScore then
				slot3 = slot9.needScore

				break
			end
		end
	end

	return slot3
end

return slot0
