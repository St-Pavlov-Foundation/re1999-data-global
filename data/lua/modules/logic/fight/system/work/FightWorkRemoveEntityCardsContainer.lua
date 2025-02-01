module("modules.logic.fight.system.work.FightWorkRemoveEntityCardsContainer", package.seeall)

slot0 = class("FightWorkRemoveEntityCardsContainer", FightStepEffectFlow)
slot1 = {
	[FightEnum.EffectType.DEAD] = true,
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.POWERCHANGE] = true
}

function slot0.onStart(slot0)
	slot0:playAdjacentParallelEffect(uv0, true)
end

function slot0.clearWork(slot0)
end

return slot0
