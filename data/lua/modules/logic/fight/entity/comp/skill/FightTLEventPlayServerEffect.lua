module("modules.logic.fight.entity.comp.skill.FightTLEventPlayServerEffect", package.seeall)

slot0 = class("FightTLEventPlayServerEffect")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0._list = {}
	slot0._fightStepMO = slot1

	if slot3[1] == "1" then
		slot0:_playEffect(FightEnum.EffectType.SUMMONEDDELETE)
	end

	if slot3[2] == "1" then
		slot0:_playEffect(FightEnum.EffectType.MAGICCIRCLEDELETE)
	end

	if slot3[3] == "1" then
		slot0:_playEffect(FightEnum.EffectType.MAGICCIRCLEADD)
	end

	if slot3[4] == "1" then
		slot0:_playEffect(FightEnum.EffectType.MOVE)
	end

	if slot3[5] == "1" then
		slot0:_playEffect(FightEnum.EffectType.MOVEFRONT)
	end

	if slot3[6] == "1" then
		slot0:_playEffect(FightEnum.EffectType.MOVEBACK)
	end
end

function slot0._playEffect(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._fightStepMO.actEffectMOs) do
		if slot6.effectType == slot1 then
			slot7 = FightWork2Work.New(FightStepBuilder.ActEffectWorkCls[slot1], slot0._fightStepMO, slot6)

			slot7:onStart()
			slot6:setDone()
			table.insert(slot0._list, slot7)
		end
	end
end

function slot0.onSkillEnd(slot0)
	if slot0._list then
		for slot4, slot5 in ipairs(slot0._list) do
			slot5:onStop()
		end

		slot0._list = nil
	end
end

function slot0.handleSkillEventEnd(slot0)
end

function slot0.reset(slot0)
end

function slot0.dispose(slot0)
	slot0:onSkillEnd()
end

return slot0
