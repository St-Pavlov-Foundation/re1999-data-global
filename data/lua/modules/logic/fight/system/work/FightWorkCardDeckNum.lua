module("modules.logic.fight.system.work.FightWorkCardDeckNum", package.seeall)

slot0 = class("FightWorkCardDeckNum", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0.afterDeckNum = FightDataHelper.fieldMgr.deckNum
end

function slot0.onStart(slot0)
	slot0:com_sendFightEvent(FightEvent.CardBoxNumChange, slot0.afterDeckNum, FightDataHelper.fieldMgr.deckNum)
	slot0:onDone(true)
end

return slot0
