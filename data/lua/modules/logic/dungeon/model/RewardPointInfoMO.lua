module("modules.logic.dungeon.model.RewardPointInfoMO", package.seeall)

slot0 = pureTable("RewardPointInfoMO")

function slot0.init(slot0, slot1)
	slot0.chapterId = slot1.chapterId
	slot0.rewardPoint = slot1.rewardPoint
	slot0.hasGetPointRewardIds = slot1.hasGetPointRewardIds or {}
end

function slot0.setRewardPoint(slot0, slot1)
	slot0.rewardPoint = slot1
end

return slot0
