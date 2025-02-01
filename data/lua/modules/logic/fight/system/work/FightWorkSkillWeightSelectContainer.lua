module("modules.logic.fight.system.work.FightWorkSkillWeightSelectContainer", package.seeall)

slot0 = class("FightWorkSkillWeightSelectContainer", FightStepEffectFlow)

function slot0.onStart(slot0)
	slot0:playAdjacentParallelEffect(nil, true)
end

function slot0.clearWork(slot0)
end

return slot0
