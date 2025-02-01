module("modules.logic.fight.system.work.FightWorkCardLevelChangeDone", package.seeall)

slot0 = class("FightWorkCardLevelChangeDone", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0)
	if FightCardModel.instance:isChanging() then
		TaskDispatcher.runDelay(slot0._delayDone, slot0, 10)
		FightController.instance:registerCallback(FightEvent.OnChangeCardEffectDone, slot0._onChangeCardEffectDone, slot0)
	else
		slot0:onDone(true)
	end
end

function slot0._onChangeCardEffectDone(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnChangeCardEffectDone, slot0._onChangeCardEffectDone, slot0)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	if FightCardModel.instance:isChanging() then
		logError("卡牌升降星超时，isChanging=true")
	else
		logError("卡牌升降星超时，isChanging=false")
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnChangeCardEffectDone, slot0._onChangeCardEffectDone, slot0)
end

return slot0
