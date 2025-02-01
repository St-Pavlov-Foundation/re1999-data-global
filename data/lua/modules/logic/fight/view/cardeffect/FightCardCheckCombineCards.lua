module("modules.logic.fight.view.cardeffect.FightCardCheckCombineCards", package.seeall)

slot0 = class("FightCardCheckCombineCards", BaseWork)

function slot0.onStart(slot0, slot1)
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, true)
	FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, slot0._onCombineDone, slot0)
	FightController.instance:dispatchEvent(FightEvent.PlayCombineCards, slot0.context.cards)
end

function slot0._onCombineDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onCombineDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.PlayDiscardEffect, slot0._onPlayDiscardEffect, slot0)
end

return slot0
