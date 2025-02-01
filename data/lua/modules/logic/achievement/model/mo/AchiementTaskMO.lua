module("modules.logic.achievement.model.mo.AchiementTaskMO", package.seeall)

slot0 = pureTable("AchiementTaskMO")

function slot0.init(slot0, slot1)
	slot0.cfg = slot1
	slot0.id = slot1.id
end

function slot0.updateByServerData(slot0, slot1)
	slot0.progress = slot1.progress
	slot0.hasFinished = slot1.hasFinish
	slot0.isNew = slot1.new
	slot0.finishTime = slot1.finishTime
end

return slot0
