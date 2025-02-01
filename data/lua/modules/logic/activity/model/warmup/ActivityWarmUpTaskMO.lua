module("modules.logic.activity.model.warmup.ActivityWarmUpTaskMO", package.seeall)

slot0 = pureTable("ActivityWarmUpTaskMO")

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot2.id
	slot0.config = slot2
	slot0.taskMO = slot1
end

function slot0.updateMO(slot0, slot1)
	slot0.taskMO = slot1
end

function slot0.isLock(slot0)
	return slot0.taskMO == nil
end

function slot0.isFinished(slot0)
	if slot0.taskMO then
		return slot0.taskMO.hasFinished
	end

	return false
end

function slot0.getProgress(slot0)
	if slot0.taskMO then
		return slot0.taskMO.progress
	end

	return 0
end

function slot0.alreadyGotReward(slot0)
	if slot0.taskMO then
		return slot0.taskMO.finishCount > 0
	end

	return false
end

return slot0
