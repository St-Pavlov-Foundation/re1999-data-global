module("modules.logic.versionactivity1_2.trade.model.Activity117Model", package.seeall)

slot0 = class("Activity117Model", BaseModel)

function slot0.onInit(slot0)
	slot0._actDict = {}
end

function slot0.reInit(slot0)
	slot0._actDict = {}
end

function slot0.release(slot0)
	slot0._actDict = {}
end

function slot0.initAct(slot0, slot1)
	slot0:getActData(slot1, true)
end

function slot0.getActData(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if not slot0._actDict[slot1] and slot2 then
		slot3 = Activity117MO.New()

		slot3:init(slot1)

		slot0._actDict[slot1] = slot3
	end

	return slot3
end

function slot0.onReceiveInfos(slot0, slot1)
	if not slot0:getActData(slot1.activityId) then
		return
	end

	slot2:onInitServerData(slot1)
end

function slot0.onNegotiateResult(slot0, slot1)
	if not slot0:getActData(slot1.activityId) then
		return
	end

	slot2:onNegotiateResult(slot1)
end

function slot0.onDealSuccess(slot0, slot1)
	if not slot0:getActData(slot1.activityId) then
		return
	end

	slot2:onDealSuccess(slot1)
end

function slot0.onOrderPush(slot0, slot1)
	if not slot0:getActData(slot1.activityId) then
		return
	end

	slot2:onOrderPush(slot1)
end

function slot0.updateRewardDatas(slot0, slot1)
	if not slot0:getActData(slot1.activityId) then
		return
	end

	slot2:updateHasGetBonusIds(slot1.bonusIds)
end

function slot0.getOrderDataById(slot0, slot1, slot2)
	if not slot0:getActData(slot1) then
		return
	end

	return slot3:getOrderData(slot2)
end

function slot0.getOrderList(slot0, slot1, slot2)
	if not slot0:getActData(slot1) then
		return
	end

	return slot3:getOrderList(slot2)
end

function slot0.getRewardList(slot0, slot1)
	if not slot0:getActData(slot1) then
		return
	end

	return slot2:getRewardList()
end

function slot0.getRemainDay(slot0, slot1)
	if not slot0:getActData(slot1) then
		return 0
	end

	return slot2:getRemainDay()
end

function slot0.getCurrentScore(slot0, slot1)
	if not slot0:getActData(slot1) then
		return 0
	end

	return slot2:getCurrentScore()
end

function slot0.getNextScore(slot0, slot1, slot2)
	if not slot0:getActData(slot1) then
		return 0
	end

	return slot3:getNextScore(slot2)
end

function slot0.setSelectOrder(slot0, slot1, slot2)
	if not slot0:getActData(slot1) then
		return
	end

	slot3:setSelectOrder(slot2)
end

function slot0.getSelectOrder(slot0, slot1)
	if not slot0:getActData(slot1) then
		return
	end

	return slot2:getSelectOrder()
end

function slot0.isSelectOrder(slot0, slot1)
	return slot0:getSelectOrder(slot1) ~= nil
end

function slot0.setInQuote(slot0, slot1, slot2)
	if not slot0:getActData(slot1) then
		return
	end

	slot3:setInQuote(slot2)
end

function slot0.isInQuote(slot0, slot1)
	if not slot0:getActData(slot1) then
		return
	end

	return slot2:isInQuote()
end

function slot0.getFinishOrderCount(slot0, slot1)
	if not slot0:getActData(slot1) then
		return
	end

	return slot2:getFinishOrderCount()
end

function slot0.clear(slot0)
end

slot0.instance = slot0.New()

return slot0
