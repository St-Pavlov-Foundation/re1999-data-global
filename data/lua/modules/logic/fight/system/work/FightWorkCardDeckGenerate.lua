module("modules.logic.fight.system.work.FightWorkCardDeckGenerate", package.seeall)

slot0 = class("FightWorkCardDeckGenerate", FightEffectBase)

function slot0.onStart(slot0)
	slot0:com_sendFightEvent(FightEvent.CardDeckGenerate)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
