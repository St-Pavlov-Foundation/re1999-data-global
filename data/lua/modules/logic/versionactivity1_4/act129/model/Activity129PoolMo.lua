module("modules.logic.versionactivity1_4.act129.model.Activity129PoolMo", package.seeall)

slot0 = class("Activity129PoolMo")

function slot0.ctor(slot0, slot1)
	slot0.activityId = slot1.activityId
	slot0.poolId = slot1.poolId
	slot0.poolType = slot1.type
	slot0.count = 0
	slot0.rewardDict = {}
end

function slot0.init(slot0, slot1)
	slot0.count = slot1.count
	slot0.rewardDict = {}

	for slot5 = 1, #slot1.rewards do
		slot6 = slot1.rewards[slot5]
		slot7 = slot0:getRewardItem(slot6.rare, slot6.rewardType, slot6.rewardId)
		slot7.num = slot7.num + slot6.num
	end
end

function slot0.onLotterySuccess(slot0, slot1)
	slot0.count = slot0.count + slot1.num

	for slot5 = 1, #slot1.rewards do
		slot6 = slot1.rewards[slot5]
		slot7 = slot0:getRewardItem(slot6.rare, slot6.rewardType, slot6.rewardId)
		slot7.num = slot7.num + slot6.num
	end
end

function slot0.getRewardItem(slot0, slot1, slot2, slot3)
	if not slot0.rewardDict[slot1] then
		slot0.rewardDict[slot1] = {}
	end

	if not slot0.rewardDict[slot1][slot2] then
		slot0.rewardDict[slot1][slot2] = {}
	end

	if not slot0.rewardDict[slot1][slot2][slot3] then
		slot0.rewardDict[slot1][slot2][slot3] = {
			num = 0,
			rare = slot1,
			rewardType = slot2,
			rewardId = slot3
		}
	end

	return slot0.rewardDict[slot1][slot2][slot3]
end

function slot0.getGoodsGetNum(slot0, slot1, slot2, slot3)
	return slot0:getRewardItem(slot1, slot2, slot3).num
end

function slot0.checkPoolIsEmpty(slot0)
	slot1, slot2 = slot0:getPoolDrawCount()

	return slot2 ~= 0 and slot2 <= slot1
end

function slot0.getPoolDrawCount(slot0)
	slot1 = 0
	slot2 = 0

	for slot7, slot8 in pairs(Activity129Config.instance:getGoodsDict(slot0.poolId)) do
		if GameUtil.splitString2(slot8.goodsId, true) then
			for slot13, slot14 in ipairs(slot9) do
				if slot14[4] > 0 then
					slot1 = slot1 + slot14[4]
					slot2 = slot2 + slot0:getGoodsGetNum(slot7, slot14[1], slot14[2])
				end
			end
		end
	end

	return slot2, slot1
end

return slot0
