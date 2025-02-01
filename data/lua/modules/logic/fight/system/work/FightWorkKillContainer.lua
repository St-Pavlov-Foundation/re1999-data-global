module("modules.logic.fight.system.work.FightWorkKillContainer", package.seeall)

slot0 = class("FightWorkKillContainer", FightStepEffectFlow)

function slot0.onStart(slot0)
	slot0:playAdjacentParallelEffect(nil, true)
end

function slot0.clearWork(slot0)
end

return slot0
