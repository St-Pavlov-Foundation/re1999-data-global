module("modules.logic.fight.system.work.FightWorkEffectCardLevelChangeContainer", package.seeall)

slot0 = class("FightWorkEffectCardLevelChangeContainer", FightStepEffectFlow)
slot1 = {
	[FightEnum.EffectType.EXPOINTCHANGE] = true,
	[FightEnum.EffectType.POWERCHANGE] = true
}

function slot0.onStart(slot0)
	slot0:playAdjacentParallelEffect(uv0, true)
end

function slot0.clearWork(slot0)
end

return slot0
