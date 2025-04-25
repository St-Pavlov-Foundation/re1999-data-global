module("modules.logic.fight.system.work.LY.FightWorkToCardAreaRedOrBlue", package.seeall)

slot0 = class("FightWorkToCardAreaRedOrBlue", FightEffectBase)

function slot0.onStart(slot0)
	FightPlayCardModel.instance:setUsedCard(slot0._actEffectMO.cardInfoList)
	FightController.instance:dispatchEvent(FightEvent.SetUseCards)
	FightViewPartVisible.set(false, false, false, false, true)
	slot0:onDone(true)
end

return slot0
