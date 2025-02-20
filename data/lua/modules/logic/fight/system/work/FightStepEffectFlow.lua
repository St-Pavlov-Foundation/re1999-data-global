module("modules.logic.fight.system.work.FightStepEffectFlow", package.seeall)

slot0 = class("FightStepEffectFlow", FightEffectBase)

function slot0.playEffectData(slot0)
end

function slot0.playAdjacentSequenceEffect(slot0, slot1, slot2)
	slot4 = slot0:com_registWorkDoneFlowSequence()

	for slot8, slot9 in ipairs(slot0:getAdjacentSameEffectList(slot1, slot2)) do
		slot4:registWork(FightStepBuilder.ActEffectWorkCls[slot9.effect.effectType], slot9.stepMO, slot9.effect)
	end

	return slot4:start()
end

function slot0.playAdjacentParallelEffect(slot0, slot1, slot2)
	slot4 = slot0:com_registWorkDoneFlowParallel()

	for slot8, slot9 in ipairs(slot0:getAdjacentSameEffectList(slot1, slot2)) do
		slot4:registWork(FightStepBuilder.ActEffectWorkCls[slot9.effect.effectType], slot9.stepMO, slot9.effect)
	end

	return slot4:start()
end

return slot0
