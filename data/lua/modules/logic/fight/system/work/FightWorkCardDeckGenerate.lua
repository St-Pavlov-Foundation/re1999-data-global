module("modules.logic.fight.system.work.FightWorkCardDeckGenerate", package.seeall)

slot0 = class("FightWorkCardDeckGenerate", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0.beforeNum = FightDataHelper.fieldMgr.deckNum
end

function slot0.onStart(slot0)
	slot0:com_sendFightEvent(FightEvent.CardBoxNumChange, slot0.beforeNum, FightDataHelper.fieldMgr.deckNum)
	slot0:com_registFightEvent(FightEvent.CardDeckGenerateDone, slot0._delayDone)
	slot0:com_sendFightEvent(FightEvent.CardDeckGenerate, slot0._actEffectMO.cardInfoList)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
