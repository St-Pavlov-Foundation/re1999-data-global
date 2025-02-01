module("modules.logic.backpack.model.ItemInsightModel", package.seeall)

slot0 = class("ItemInsightModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._insightItemList = {}
	slot0._latestPushItemUids = {}
end

function slot0.getInsightItem(slot0, slot1)
	return slot0._insightItemList[tonumber(slot1)]
end

function slot0.getInsightItemList(slot0)
	return slot0._insightItemList
end

function slot0.setInsightItemList(slot0, slot1)
	slot0._insightItemList = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = ItemInsightMo.New()

		slot7:init(slot6)

		slot0._insightItemList[tonumber(slot6.uid)] = slot7
	end
end

function slot0.changeInsightItemList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot7 = tonumber(slot6.uid)

		table.insert(slot0._latestPushItemUids, {
			itemid = slot6.itemId,
			uid = slot7
		})

		if not slot0._insightItemList[slot7] then
			slot9 = ItemInsightMo.New()

			slot9:init(slot6)

			slot0._insightItemList[slot7] = slot9
		else
			slot0._insightItemList[slot7]:reset(slot6)
		end
	end
end

function slot0.getLatestInsightChange(slot0)
	return slot0._latestPushItemUids
end

function slot0.getInsightItemCount(slot0, slot1)
	if not slot0._insightItemList[slot1] then
		return 0
	end

	if slot0._insightItemList[slot1].expireTime <= ServerTime.now() then
		return 0
	end

	return slot0._insightItemList[slot1].quantity
end

function slot0.getInsightItemCountById(slot0, slot1)
	slot3 = ServerTime.now()

	for slot7, slot8 in pairs(slot0._insightItemList) do
		if slot8.insightId == slot1 and ServerTime.now() < slot0._insightItemList[slot8.uid].expireTime then
			slot2 = 0 + slot8.quantity
		end
	end

	return slot2
end

function slot0.getInsightItemDeadline(slot0, slot1)
	return slot0._insightItemList[slot1] and tonumber(slot0._insightItemList[slot1].expireTime) or 0
end

function slot0.getInsightItemCoByUid(slot0, slot1)
	return slot0._insightItemList[slot1] and ItemConfig.instance:getInsightItemCo(slot0._insightItemList[slot1].id) or nil
end

function slot0.getEarliestExpireInsight(slot0, slot1)
	slot2 = nil

	for slot7, slot8 in pairs(slot0._insightItemList) do
		if slot8.insightId == slot1 and slot8.quantity > 0 and slot8.expireTime ~= 0 and ServerTime.now() < slot8.expireTime then
			if slot2 then
				if slot8.expireTime < slot2.expireTime then
					slot2 = slot8
				end
			else
				slot2 = slot8
			end
		end
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
