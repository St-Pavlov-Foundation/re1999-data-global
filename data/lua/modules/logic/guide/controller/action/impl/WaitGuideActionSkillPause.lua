module("modules.logic.guide.controller.action.impl.WaitGuideActionSkillPause", package.seeall)

slot0 = class("WaitGuideActionSkillPause", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	FightController.instance:registerCallback(FightEvent.OnGuideBeforeSkillPause, slot0._onGuideBeforeSkillPause, slot0)

	slot2 = string.splitToNumber(slot0.actionParam, "#")
	slot0._attackId = slot2[1]
	slot0._skillId = slot2[2]
end

function slot0._onGuideBeforeSkillPause(slot0, slot1, slot2, slot3)
	slot1.OnGuideBeforeSkillPause = slot2 == slot0._attackId and slot3 == slot0._skillId

	if slot1.OnGuideBeforeSkillPause then
		FightController.instance:unregisterCallback(FightEvent.OnGuideBeforeSkillPause, slot0._onGuideBeforeSkillPause, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnGuideBeforeSkillPause, slot0._onGuideBeforeSkillPause, slot0)
end

return slot0
