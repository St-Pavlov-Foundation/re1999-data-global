module("modules.logic.fight.system.work.FightWorkCardsPush", package.seeall)

slot0 = class("FightWorkCardsPush", FightEffectBase)

function slot0.onStart(slot0)
	FightCardModel.instance:getCardMO():setCards(FightHelper.buildInfoMOs(slot0._actEffectMO.cardInfoList, FightCardInfoMO))
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
