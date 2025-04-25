module("modules.logic.fight.entity.comp.skill.FightTLEventInvokeLookBack", package.seeall)

slot0 = class("FightTLEventInvokeLookBack")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	if not (slot1 and slot1.actEffectMOs) then
		return
	end

	slot5 = {}
	slot6 = false

	for slot10, slot11 in ipairs(slot4) do
		if slot11.effectType == FightEnum.EffectType.SAVEFIGHTRECORDSTART then
			slot6 = true
		elseif slot11.effectType == FightEnum.EffectType.SAVEFIGHTRECORDEND then
			break
		elseif slot6 then
			table.insert(slot5, slot11)
		end
	end

	if #slot5 < 1 then
		return
	end

	slot0._flow = FlowParallel.New()

	for slot10, slot11 in ipairs(slot5) do
		if FightStepBuilder.ActEffectWorkCls[slot11.effectType] then
			slot0._flow:addWork(FightWork2Work.New(slot12, slot1, slot11))
		end
	end

	slot0._flow:start()
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
