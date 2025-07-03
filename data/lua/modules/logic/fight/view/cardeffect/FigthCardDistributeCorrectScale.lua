module("modules.logic.fight.view.cardeffect.FigthCardDistributeCorrectScale", package.seeall)

local var_0_0 = class("FigthCardDistributeCorrectScale", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.oldScale or FightCardDataHelper.getHandCardContainerScale()
	local var_1_1 = arg_1_1.newScale or FightCardDataHelper.getHandCardContainerScale(nil, arg_1_1.cards)

	if var_1_0 ~= var_1_1 then
		arg_1_0:_releaseTween()
		FightController.instance:dispatchEvent(FightEvent.CancelVisibleViewScaleTween)

		local var_1_2 = 0.2 / FightModel.instance:getUISpeed()

		arg_1_0._tweenId = ZProj.TweenHelper.DOScale(arg_1_1.handCardContainer.transform, var_1_1, var_1_1, var_1_1, var_1_2)

		TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, var_1_2)
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0._releaseTween(arg_3_0)
	if arg_3_0._tweenId then
		ZProj.TweenHelper.KillById(arg_3_0._tweenId)

		arg_3_0._tweenId = nil
	end
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
	arg_4_0:_releaseTween()
end

return var_0_0
