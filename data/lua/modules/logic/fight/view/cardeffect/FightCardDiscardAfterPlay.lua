module("modules.logic.fight.view.cardeffect.FightCardDiscardAfterPlay", package.seeall)

slot0 = class("FightCardDiscardAfterPlay", BaseWork)

function slot0.onStart(slot0, slot1)
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, true)

	if slot1.param2 then
		if slot2 ~= 0 then
			slot0:_playDiscard(slot2)

			return
		end
	elseif slot1.needDiscard then
		slot5 = false

		for slot9, slot10 in ipairs(FightCardModel.instance:getHandCards()) do
			if FightDataHelper.entityMgr:getById(slot10.uid) then
				if not slot11:isUniqueSkill(slot10.skillId) then
					slot5 = true

					break
				end
			else
				slot5 = true

				break
			end
		end

		if slot5 then
			FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, false)
			FightController.instance:registerCallback(FightEvent.PlayDiscardEffect, slot0._onPlayDiscardEffect, slot0)
			FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.Discard)

			return
		end
	end

	slot0:onDone(true)
end

function slot0._onPlayDiscardEffect(slot0, slot1)
	slot0:_playDiscard(slot1)
end

function slot0._playDiscard(slot0, slot1)
	slot0.context.view:cancelAbandonState()
	FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.DiscardEffect)
	FightController.instance:dispatchEvent(FightEvent.StartPlayDiscardEffect)

	slot2 = slot0.context.cards

	slot0.context.view:_updateHandCards(slot2)

	slot0.context.fightBeginRoundOp.param2 = slot1
	slot3 = {
		slot1
	}

	table.sort(slot3, FightWorkCardRemove2.sort)

	slot4 = FightCardDataHelper.calcRemoveCardTime2(slot2, slot3)

	table.remove(slot2, slot1)
	FightController.instance:dispatchEvent(FightEvent.CancelAutoPlayCardFinishEvent)
	TaskDispatcher.cancelTask(slot0._afterRemoveCard, slot0)
	TaskDispatcher.runDelay(slot0._afterRemoveCard, slot0, slot4 / FightModel.instance:getUISpeed())
	FightController.instance:dispatchEvent(FightEvent.CardRemove, slot3, slot4)
end

function slot0._afterRemoveCard(slot0)
	TaskDispatcher.cancelTask(slot0._afterRemoveCard, slot0)
	FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, slot0._onCombineDone, slot0)
	FightController.instance:dispatchEvent(FightEvent.PlayCombineCards, slot0.context.cards)
end

function slot0._onCombineDone(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onCombineDone, slot0)
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.DiscardEffect)
	FightController.instance:dispatchEvent(FightEvent.RevertAutoPlayCardFinishEvent)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:dispatchEvent(FightEvent.DiscardAfterPlayCardFinish)
	TaskDispatcher.cancelTask(slot0._afterRemoveCard, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, slot0._onCombineDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.PlayDiscardEffect, slot0._onPlayDiscardEffect, slot0)
end

return slot0
