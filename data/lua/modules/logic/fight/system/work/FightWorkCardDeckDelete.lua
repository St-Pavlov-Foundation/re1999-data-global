module("modules.logic.fight.system.work.FightWorkCardDeckDelete", package.seeall)

slot0 = class("FightWorkCardDeckDelete", FightEffectBase)

function slot0.onConstructor(slot0)
	slot0.SAFETIME = 3
end

function slot0.beforePlayEffectData(slot0)
	slot0.beforeNum = FightDataHelper.fieldMgr.deckNum
end

function slot0.onStart(slot0)
	if slot0._actEffectMO.cardInfoList and #slot1 < 1 then
		return slot0:onDone(true)
	end

	slot0:com_sendFightEvent(FightEvent.CardBoxNumChange, slot0.beforeNum, FightDataHelper.fieldMgr.deckNum)
	slot0:com_registFightEvent(FightEvent.CardDeckDeleteDone, slot0._delayDone)
	slot0:com_sendFightEvent(FightEvent.CardDeckDelete, slot0._actEffectMO.cardInfoList)
end

return slot0
