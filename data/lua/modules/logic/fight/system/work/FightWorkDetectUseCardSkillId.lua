module("modules.logic.fight.system.work.FightWorkDetectUseCardSkillId", package.seeall)

slot0 = class("FightWorkDetectUseCardSkillId", FightWorkItem)

function slot0.onStart(slot0)
	slot1 = slot0:com_registWorkDoneFlowSequence()

	slot1:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.DetectHaveCardAfterEndOperation))
	slot1:start()
end

function slot0.clearWork(slot0)
end

return slot0
