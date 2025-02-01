module("modules.logic.fight.view.cardeffect.FigthCardDistributeCorrectScale", package.seeall)

slot0 = class("FigthCardDistributeCorrectScale", BaseWork)

function slot0.onStart(slot0, slot1)
	if (slot1.oldScale or FightCardModel.instance:getHandCardContainerScale()) ~= (slot1.newScale or FightCardModel.instance:getHandCardContainerScale(nil, slot1.cards)) then
		slot0:_releaseTween()
		FightController.instance:dispatchEvent(FightEvent.CancelVisibleViewScaleTween)

		slot4 = 0.2 / FightModel.instance:getUISpeed()
		slot0._tweenId = ZProj.TweenHelper.DOScale(slot1.handCardContainer.transform, slot3, slot3, slot3, slot4)

		TaskDispatcher.runDelay(slot0._delayDone, slot0, slot4)
	else
		slot0:onDone(true)
	end
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0._releaseTween(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	slot0:_releaseTween()
end

return slot0
