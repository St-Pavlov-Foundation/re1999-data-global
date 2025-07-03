module("modules.logic.fight.system.work.FightWorkRoundEnd", package.seeall)

local var_0_0 = class("FightWorkRoundEnd", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	FightPlayCardModel.instance:onEndRound()

	local var_1_0 = FightHelper.getAllEntitys()

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		iter_1_1:resetEntity()
	end

	FightController.instance:registerCallback(FightEvent.NeedWaitEnemyOPEnd, arg_1_0._needWaitEnemyOPEnd, arg_1_0)
	TaskDispatcher.runDelay(arg_1_0._dontNeedWaitEnemyOPEnd, arg_1_0, 0.01)
	FightController.instance:dispatchEvent(FightEvent.FightRoundEnd)
end

function var_0_0._needWaitEnemyOPEnd(arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.NeedWaitEnemyOPEnd, arg_2_0._needWaitEnemyOPEnd, arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._dontNeedWaitEnemyOPEnd, arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._playCardExpand, arg_2_0, 0.5 / FightModel.instance:getUISpeed())
end

function var_0_0._dontNeedWaitEnemyOPEnd(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.NeedWaitEnemyOPEnd, arg_3_0._needWaitEnemyOPEnd, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._dontNeedWaitEnemyOPEnd, arg_3_0)
	arg_3_0:_playCardExpand()
end

function var_0_0._playCardExpand(arg_4_0)
	local var_4_0 = FightViewHandCard.handCardContainer

	if not FightModel.instance:isFinish() and not gohelper.isNil(var_4_0) then
		local var_4_1 = FightWorkEffectDistributeCard.getHandCardScaleTime()
		local var_4_2 = FightCardDataHelper.getHandCardContainerScale()

		arg_4_0._tweenId = ZProj.TweenHelper.DOScale(var_4_0.transform, var_4_2, var_4_2, var_4_2, var_4_1, arg_4_0._onHandCardsExpand, arg_4_0)
	else
		arg_4_0:_onHandCardsExpand()
	end
end

function var_0_0._onHandCardsExpand(arg_5_0)
	logNormal("回合结束")
	arg_5_0:onDone(true)
end

function var_0_0.clearWork(arg_6_0)
	FightController.instance:unregisterCallback(FightEvent.NeedWaitEnemyOPEnd, arg_6_0._needWaitEnemyOPEnd, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._dontNeedWaitEnemyOPEnd, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._playCardExpand, arg_6_0)

	if arg_6_0._tweenId then
		ZProj.TweenHelper.KillById(arg_6_0._tweenId)

		arg_6_0._tweenId = nil
	end
end

return var_0_0
