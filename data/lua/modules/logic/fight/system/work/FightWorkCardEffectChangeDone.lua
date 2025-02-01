module("modules.logic.fight.system.work.FightWorkCardEffectChangeDone", package.seeall)

slot0 = class("FightWorkCardEffectChangeDone", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0)
	FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, slot0._onCardMagicEffectChangeDone, slot0)
	FightController.instance:dispatchEvent(FightEvent.PlayCardMagicEffectChange)
end

function slot0._onCardMagicEffectChangeDone(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onCardMagicEffectChangeDone, slot0)
	slot0:_onDone()
end

function slot0._onDone(slot0)
	slot0:clearWork()
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
