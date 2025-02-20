module("modules.logic.fight.system.work.FightWorkUseCards", package.seeall)

slot0 = class("FightWorkUseCards", FightEffectBase)

function slot0.onStart(slot0)
	FightPlayCardModel.instance:setUsedCard(slot0._actEffectMO.cardInfoList)
	FightController.instance:dispatchEvent(FightEvent.SetUseCards)
	FightViewPartVisible.set(false, false, false, false, true)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
