module("modules.logic.fight.system.work.FightWorkEffectExtraMoveAct", package.seeall)

slot0 = class("FightWorkEffectExtraMoveAct", FightEffectBase)

function slot0.onStart(slot0)
	FightCardModel.instance:getCardMO():setExtraMoveAct(slot0._actEffectMO.effectNum)
	FightController.instance:dispatchEvent(FightEvent.OnEffectExtraMoveAct)
	slot0:onDone(true)
end

return slot0
