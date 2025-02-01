module("modules.logic.guide.controller.action.impl.WaitGuideActionFightSkillPlayFinish", package.seeall)

slot0 = class("WaitGuideActionFightSkillPlayFinish", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)

	slot2 = string.splitToNumber(slot0.actionParam, "#")
	slot0._attackId = slot2[1]
	slot0._skillId = slot2[2]
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2)
	if (not slot0._attackId or slot0._attackId == slot1:getMO().modelId) and (not slot0._skillId or slot0._skillId == slot2) then
		FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
		slot0:onDone(true)
	end
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
end

return slot0
