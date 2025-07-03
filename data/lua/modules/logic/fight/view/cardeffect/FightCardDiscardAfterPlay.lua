module("modules.logic.fight.view.cardeffect.FightCardDiscardAfterPlay", package.seeall)

local var_0_0 = class("FightCardDiscardAfterPlay", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, true)

	local var_1_0 = arg_1_1.param2

	if var_1_0 then
		if var_1_0 ~= 0 then
			arg_1_0:_playDiscard(var_1_0)

			return
		end
	elseif arg_1_1.needDiscard then
		local var_1_1 = FightDataHelper.handCardMgr.handCard
		local var_1_2 = false

		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			if FightDataHelper.entityMgr:getById(iter_1_1.uid) then
				if not FightCardDataHelper.isBigSkill(iter_1_1.skillId) then
					var_1_2 = true

					break
				end
			else
				var_1_2 = true

				break
			end
		end

		if var_1_2 then
			FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, false)
			FightController.instance:registerCallback(FightEvent.PlayDiscardEffect, arg_1_0._onPlayDiscardEffect, arg_1_0)
			FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.Discard)

			return
		end
	end

	arg_1_0:onDone(true)
end

function var_0_0._onPlayDiscardEffect(arg_2_0, arg_2_1)
	arg_2_0:_playDiscard(arg_2_1)
end

function var_0_0._playDiscard(arg_3_0, arg_3_1)
	arg_3_0.context.view:cancelAbandonState()
	FightDataHelper.stageMgr:enterOperateState(FightStageMgr.OperateStateType.DiscardEffect)
	FightController.instance:dispatchEvent(FightEvent.StartPlayDiscardEffect)

	local var_3_0 = arg_3_0.context.cards

	arg_3_0.context.view:_updateHandCards(var_3_0)

	arg_3_0.context.fightBeginRoundOp.param2 = arg_3_1

	local var_3_1 = {
		arg_3_1
	}

	table.sort(var_3_1, FightWorkCardRemove2.sort)

	local var_3_2 = FightCardDataHelper.calcRemoveCardTime2(var_3_0, var_3_1)

	table.remove(var_3_0, arg_3_1)
	FightController.instance:dispatchEvent(FightEvent.CancelAutoPlayCardFinishEvent)
	TaskDispatcher.cancelTask(arg_3_0._afterRemoveCard, arg_3_0)
	TaskDispatcher.runDelay(arg_3_0._afterRemoveCard, arg_3_0, var_3_2 / FightModel.instance:getUISpeed())
	FightController.instance:dispatchEvent(FightEvent.CardRemove, var_3_1, var_3_2)
end

function var_0_0._afterRemoveCard(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._afterRemoveCard, arg_4_0)
	FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, arg_4_0._onCombineDone, arg_4_0)
	FightController.instance:dispatchEvent(FightEvent.PlayCombineCards, arg_4_0.context.cards)
end

function var_0_0._onCombineDone(arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_5_0._onCombineDone, arg_5_0)
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.OperateStateType.DiscardEffect)
	FightController.instance:dispatchEvent(FightEvent.RevertAutoPlayCardFinishEvent)
	arg_5_0:onDone(true)
end

function var_0_0.clearWork(arg_6_0)
	FightController.instance:dispatchEvent(FightEvent.DiscardAfterPlayCardFinish)
	TaskDispatcher.cancelTask(arg_6_0._afterRemoveCard, arg_6_0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_6_0._onCombineDone, arg_6_0)
	FightController.instance:unregisterCallback(FightEvent.PlayDiscardEffect, arg_6_0._onPlayDiscardEffect, arg_6_0)
end

return var_0_0
