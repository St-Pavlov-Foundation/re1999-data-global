module("modules.logic.fight.system.work.FightWorkPlayChangeRankFailContainer", package.seeall)

slot0 = class("FightWorkPlayChangeRankFailContainer", FightStepEffectFlow)
slot1 = {
	[FightEnum.EffectType.PLAYAROUNDUPRANK] = true,
	[FightEnum.EffectType.PLAYAROUNDDOWNRANK] = true,
	[FightEnum.EffectType.PLAYCHANGERANKFAIL] = true
}

function slot0.onStart(slot0)
	slot0:playAdjacentParallelEffect(uv0, true)
end

function slot0.clearWork(slot0)
end

return slot0
