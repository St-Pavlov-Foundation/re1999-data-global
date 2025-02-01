module("modules.logic.fight.system.work.FightWorkAddHandCardContainer", package.seeall)

slot0 = class("FightWorkAddHandCardContainer", FightStepEffectFlow)
slot1 = {
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.POWERCHANGE] = true
}

function slot0.onStart(slot0)
	slot2 = slot0:com_registWorkDoneFlowParallel()

	for slot7, slot8 in ipairs(slot0:getAdjacentSameEffectList(uv0, true)) do
		slot11 = slot2:registWork(FightWorkFlowSequence)

		slot11:registWork(FightWorkDelayTimer, 0.05 * (0 + 1))
		slot11:registWork(FightStepBuilder.ActEffectWorkCls[slot8.effect.effectType], slot8.stepMO, slot8.effect)
	end

	slot2:start()
end

function slot0.clearWork(slot0)
end

return slot0
