module("modules.logic.versionactivity1_2.trade.model.Activity117RewardMO", package.seeall)

slot0 = pureTable("Activity117RewardMO")

function slot0.init(slot0, slot1)
	slot0.actId = slot1.activityId
	slot0.id = slot1.id
	slot0.needScore = slot1.needScore
	slot0.co = slot1
	slot0.rewardItems = slot0:getRewardItems()

	slot0:resetData()
end

function slot0.resetData(slot0)
	slot0.alreadyGot = false
end

function slot0.updateServerData(slot0, slot1)
	slot0.alreadyGot = slot1
end

function slot0.getRewardItems(slot0)
	for slot6, slot7 in ipairs(string.split(slot0.co.bonus, "|")) do
		-- Nothing
	end

	return {
		[slot6] = string.splitToNumber(slot7, "#")
	}
end

function slot0.getStatus(slot0)
	if slot0.alreadyGot then
		return Activity117Enum.Status.AlreadyGot
	end

	if slot0.needScore <= Activity117Model.instance:getCurrentScore(slot0.actId) then
		return Activity117Enum.Status.CanGet
	end

	return Activity117Enum.Status.NotEnough
end

function slot0.sortFunc(slot0, slot1)
	if slot0:getStatus() ~= slot1:getStatus() then
		return slot2 < slot3
	end

	return slot0.id < slot1.id
end

return slot0
