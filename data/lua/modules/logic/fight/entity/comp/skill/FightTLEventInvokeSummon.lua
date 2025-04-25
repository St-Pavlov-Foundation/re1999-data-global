module("modules.logic.fight.entity.comp.skill.FightTLEventInvokeSummon", package.seeall)

slot0 = class("FightTLEventInvokeSummon")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0.summonList = {}

	slot0:getStepMoSummon(slot1)

	if #slot0.summonList < 1 then
		return
	end

	slot0._flow = FlowParallel.New()

	for slot8, slot9 in ipairs(slot0.summonList) do
		slot0._flow:addWork(FightWork2Work.New(FightStepBuilder.ActEffectWorkCls[FightEnum.EffectType.SUMMON], slot9[1], slot9[2]))
	end

	slot0._flow:start()
end

function slot0.getStepMoSummon(slot0, slot1)
	if not (slot1 and slot1.actEffectMOs) then
		return
	end

	for slot6, slot7 in ipairs(slot2) do
		if slot7.effectType == FightEnum.EffectType.SUMMON then
			table.insert(slot0.summonList, {
				slot1,
				slot7
			})
		elseif slot7.effectType == FightEnum.EffectType.FIGHTSTEP then
			slot0:getStepMoSummon(slot7.cus_stepMO)
		end
	end
end

function slot0.handleSkillEventEnd(slot0)
end

function slot0.onSkillEnd(slot0)
end

function slot0.clear(slot0)
end

function slot0.dispose(slot0)
end

return slot0
