module("modules.logic.versionactivity.model.mo.VersionActivity112TaskMO", package.seeall)

slot0 = pureTable("VersionActivity112TaskMO")

function slot0.init(slot0, slot1, slot2)
	slot0.actId = slot1.activityId
	slot0.id = slot1.taskId
	slot0.config = slot1
	slot0.progress = 0
	slot0.hasGetBonus = false
end

function slot0.update(slot0, slot1)
	slot0.progress = slot1.progress
	slot0.hasGetBonus = slot1.hasGetBonus
end

function slot0.canGetBonus(slot0)
	return slot0.hasGetBonus == false and slot0.config.maxProgress <= slot0.progress
end

return slot0
