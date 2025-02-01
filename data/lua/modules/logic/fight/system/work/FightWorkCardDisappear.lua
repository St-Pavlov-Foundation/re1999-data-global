module("modules.logic.fight.system.work.FightWorkCardDisappear", package.seeall)

slot0 = class("FightWorkCardDisappear", FightEffectBase)

function slot0.onStart(slot0, slot1)
	FightController.instance:dispatchEvent(FightEvent.CardDisappear)
	slot0:onDone(true)
end

return slot0
