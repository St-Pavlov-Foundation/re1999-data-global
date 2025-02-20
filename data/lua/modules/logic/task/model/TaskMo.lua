module("modules.logic.task.model.TaskMo", package.seeall)

slot0 = pureTable("TaskMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.progress = 0
	slot0.hasFinished = false
	slot0.finishCount = 0
	slot0.config = nil
	slot0.type = 0
	slot0.expiryTime = 0
end

function slot0.init(slot0, slot1, slot2)
	slot0.config = slot2

	slot0:update(slot1)
end

function slot0.update(slot0, slot1)
	slot0.id = slot1.id
	slot0.progress = slot1.progress
	slot0.hasFinished = slot1.hasFinished
	slot0.finishCount = slot1.finishCount
	slot0.type = slot1.type
	slot0.expiryTime = slot1.expiryTime
end

function slot0.finishTask(slot0, slot1, slot2)
	if slot1 == slot0.id then
		slot0.finishCount = slot2
		slot0.hasFinished = true
	end
end

function slot0.getMaxFinishCount(slot0)
	return slot0.config and slot0.config.maxFinishCount or 1
end

function slot0.isClaimed(slot0)
	return slot0:getMaxFinishCount() <= slot0.finishCount
end

function slot0.isClaimable(slot0)
	return not slot0:isClaimed() and slot0.hasFinished
end

function slot0.isFinished(slot0)
	return slot0.hasFinished or slot0:isClaimed()
end

function slot0.isUnfinished(slot0)
	return not slot0:isClaimed() and not slot0:isClaimable()
end

return slot0
