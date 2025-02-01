module("modules.logic.fight.system.work.FightWorkEffectSummonContainer", package.seeall)

slot0 = class("FightWorkEffectSummonContainer", FightStepEffectFlow)

function slot0.onStart(slot0)
	slot0:playAdjacentParallelEffect(nil, true)
end

function slot0.clearWork(slot0)
end

return slot0
