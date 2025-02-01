module("modules.logic.fight.system.work.FightWorkRoundEnd", package.seeall)

slot0 = class("FightWorkRoundEnd", BaseWork)

function slot0.onStart(slot0, slot1)
	FightPlayCardModel.instance:onEndRound()
	FightCardModel.instance:onEndRound()

	for slot6, slot7 in ipairs(FightHelper.getAllEntitys()) do
		slot7:resetEntity()
	end

	FightController.instance:registerCallback(FightEvent.NeedWaitEnemyOPEnd, slot0._needWaitEnemyOPEnd, slot0)
	TaskDispatcher.runDelay(slot0._dontNeedWaitEnemyOPEnd, slot0, 0.01)
	FightController.instance:dispatchEvent(FightEvent.FightRoundEnd)
end

function slot0._needWaitEnemyOPEnd(slot0)
	FightController.instance:unregisterCallback(FightEvent.NeedWaitEnemyOPEnd, slot0._needWaitEnemyOPEnd, slot0)
	TaskDispatcher.cancelTask(slot0._dontNeedWaitEnemyOPEnd, slot0)
	TaskDispatcher.runDelay(slot0._playCardExpand, slot0, 0.5 / FightModel.instance:getUISpeed())
end

function slot0._dontNeedWaitEnemyOPEnd(slot0)
	FightController.instance:unregisterCallback(FightEvent.NeedWaitEnemyOPEnd, slot0._needWaitEnemyOPEnd, slot0)
	TaskDispatcher.cancelTask(slot0._dontNeedWaitEnemyOPEnd, slot0)
	slot0:_playCardExpand()
end

function slot0._playCardExpand(slot0)
	slot1 = FightViewHandCard.handCardContainer

	if not FightModel.instance:isFinish() and not gohelper.isNil(slot1) then
		slot3 = FightCardModel.instance:getHandCardContainerScale()
		slot0._tweenId = ZProj.TweenHelper.DOScale(slot1.transform, slot3, slot3, slot3, FightWorkEffectDistributeCard.getHandCardScaleTime(), slot0._onHandCardsExpand, slot0)
	else
		slot0:_onHandCardsExpand()
	end
end

function slot0._onHandCardsExpand(slot0)
	logNormal("回合结束")
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.NeedWaitEnemyOPEnd, slot0._needWaitEnemyOPEnd, slot0)
	TaskDispatcher.cancelTask(slot0._dontNeedWaitEnemyOPEnd, slot0)
	TaskDispatcher.cancelTask(slot0._playCardExpand, slot0)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

return slot0
