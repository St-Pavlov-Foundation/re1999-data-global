module("modules.logic.fight.system.work.FightWorkEffectGuardBreakContainer", package.seeall)

slot0 = class("FightWorkEffectGuardBreakContainer", FightStepEffectFlow)

function slot0.onStart(slot0)
	slot0:playAdjacentParallelEffect({
		[FightEnum.EffectType.GUARDBREAK] = true
	}, true)
end

function slot0.clearWork(slot0)
end

return slot0
