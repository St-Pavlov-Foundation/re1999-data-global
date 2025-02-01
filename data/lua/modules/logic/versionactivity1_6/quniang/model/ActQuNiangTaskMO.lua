module("modules.logic.versionactivity1_6.quniang.model.ActQuNiangTaskMO", package.seeall)

slot0 = pureTable("ActQuNiangTaskMO")

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot1.id
	slot0.activityId = slot1.activityId
	slot0.config = slot1
	slot0.taskMO = slot2
	slot0.preFinish = false
end

function slot0.updateMO(slot0, slot1)
	slot0.taskMO = slot1
end

function slot0.isLock(slot0)
	return slot0.taskMO == nil
end

function slot0.isFinished(slot0)
	if slot0.preFinish then
		return true
	end

	if slot0.taskMO then
		return slot0.taskMO.finishCount > 0
	end

	return false
end

function slot0.getMaxProgress(slot0)
	return slot0.config and slot0.config.maxProgress or 0
end

function slot0.getFinishProgress(slot0)
	return slot0.taskMO and slot0.taskMO.progress or 0
end

function slot0.alreadyGotReward(slot0)
	if slot0:getMaxProgress() > 0 and slot0.taskMO then
		return slot1 <= slot0.taskMO.progress and slot0.taskMO.finishCount == 0
	end

	return false
end

return slot0
