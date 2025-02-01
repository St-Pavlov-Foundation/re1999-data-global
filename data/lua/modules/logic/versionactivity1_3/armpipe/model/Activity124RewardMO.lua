module("modules.logic.versionactivity1_3.armpipe.model.Activity124RewardMO", package.seeall)

slot0 = pureTable("Activity124RewardMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.episodeId
	slot0.config = slot1
end

function slot0.isLock(slot0)
	return false
end

function slot0.isReceived(slot0)
	return Activity124Model.instance:isReceived(slot0.config.activityId, slot0.config.episodeId)
end

function slot0.isHasReard(slot0)
	return Activity124Model.instance:isHasReard(slot0.config.activityId, slot0.config.episodeId)
end

return slot0
