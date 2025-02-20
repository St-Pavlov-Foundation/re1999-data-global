module("modules.logic.fight.system.work.FightWorkZXQRemoveCardContainer", package.seeall)

slot0 = class("FightWorkZXQRemoveCardContainer", FightStepEffectFlow)

function slot0.onStart(slot0)
	slot0:playAdjacentSequenceEffect(nil, true)
end

function slot0.clearWork(slot0)
end

return slot0
