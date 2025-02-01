module("modules.logic.fight.system.work.FightWorkCardDeckDelete", package.seeall)

slot0 = class("FightWorkCardDeckDelete", FightEffectBase)

function slot0.onStart(slot0)
	slot0:com_sendFightEvent(FightEvent.CardDeckDelete)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
