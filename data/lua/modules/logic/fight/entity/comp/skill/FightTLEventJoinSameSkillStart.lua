module("modules.logic.fight.entity.comp.skill.FightTLEventJoinSameSkillStart", package.seeall)

slot0 = class("FightTLEventJoinSameSkillStart")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	if not FightModel.instance:canParallelSkill(slot1) then
		return
	end

	slot0._attacker = FightHelper.getEntity(slot1.fromId)

	if slot0._attacker and slot0._attacker.skill then
		slot0._attacker.skill:recordSameSkillStartParam(slot3)
	end
end

function slot0.reset(slot0)
end

function slot0.dispose(slot0)
end

return slot0
