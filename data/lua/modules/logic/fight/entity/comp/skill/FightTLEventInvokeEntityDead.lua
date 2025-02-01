module("modules.logic.fight.entity.comp.skill.FightTLEventInvokeEntityDead", package.seeall)

slot0 = class("FightTLEventInvokeEntityDead")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(slot1.actEffectMOs) do
		if slot8.effectType == FightEnum.EffectType.DEAD then
			FightController.instance:dispatchEvent(FightEvent.InvokeEntityDeadImmediately, slot8.targetId, slot1)
		end
	end
end

function slot0.handleSkillEventEnd(slot0)
end

function slot0.reset(slot0)
end

function slot0.dispose(slot0)
end

return slot0
