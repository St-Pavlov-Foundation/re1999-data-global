module("modules.logic.fight.entity.comp.skill.FightTLEventRemoveSummoned", package.seeall)

slot0 = class("FightTLEventRemoveSummoned")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	if slot3[1] == "1" then
		for slot7, slot8 in ipairs(slot1.actEffectMOs) do
			if slot8.effectType == FightEnum.EffectType.SUMMONEDDELETE then
				FightWork2Work.New(FightWorkSummonedDelete, slot1, slot8):onStart()
			end
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
