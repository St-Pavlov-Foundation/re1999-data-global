module("modules.logic.fight.system.work.FightWorkEffectRoundEnd", package.seeall)

slot0 = class("FightWorkEffectRoundEnd", FightEffectBase)

function slot0.onStart(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnMySideRoundEnd)
	slot0:onDone(true)
end

return slot0
