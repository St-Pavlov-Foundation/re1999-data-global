module("modules.logic.fight.system.work.FightWorkCardDisappearDone", package.seeall)

slot0 = class("FightWorkCardDisappearDone", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 10)
	FightController.instance:registerCallback(FightEvent.CardDisappearFinish, slot0._onCardDisappearFinish, slot0)
end

function slot0._onCardDisappearFinish(slot0)
	FightController.instance:unregisterCallback(FightEvent.CardDisappearFinish, slot0._onCardDisappearFinish, slot0)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	logError("卡牌消失超时，isChanging=false")
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.CardDisappearFinish, slot0._onCardDisappearFinish, slot0)
end

return slot0
