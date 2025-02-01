module("modules.logic.versionactivity1_5.act142.model.Activity142TaskMO", package.seeall)

slot0 = pureTable("Activity142TaskMO")

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot1.id
	slot0.config = slot1
	slot0.taskMO = slot2
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
	return slot0.taskMO and slot0.taskMO.progress or 0
end

function slot0.getMaxProgress(slot0)
	return slot0.config and slot0.config.maxProgress or 0
end

function slot0.getFinishProgress(slot0)
	return slot0.taskMO and slot0.taskMO.finishCount or 0
end

function slot0.alreadyGotReward(slot0)
	return slot0:getFinishProgress() > 0
end

function slot0.haveRewardToGet(slot0)
	return slot0:getFinishProgress() == 0 and slot0:isFinished()
end

return slot0
