module("modules.logic.fight.system.work.FightWorkDialogueBeforeRoundStart", package.seeall)

slot0 = class("FightWorkDialogueBeforeRoundStart", FightWorkItem)

function slot0.onStart(slot0)
	slot1 = slot0:com_registWorkDoneFlowSequence()

	slot1:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.HaveBuffAndHaveDamageSkill_onlyCheckOnce))
	slot1:start()
end

function slot0.clearWork(slot0)
end

return slot0
