module("modules.logic.fight.view.cardeffect.FightCardDissolveCardsAfterPlay", package.seeall)

local var_0_0 = class("FightCardDissolveCardsAfterPlay", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, true)

	local var_1_0 = arg_1_1.dissolveCardIndexsAfterPlay

	if var_1_0 and #var_1_0 > 0 then
		TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, 10)
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, arg_1_0._onCombineDone, arg_1_0)

		local var_1_1 = arg_1_0.context.beforeDissolveCards
		local var_1_2 = FightCardDataHelper.calcRemoveCardTime2(var_1_1, var_1_0)

		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			FightController.instance:dispatchEvent(FightEvent.CardRemove, {
				iter_1_1
			}, var_1_2, true)
		end

		return
	end

	arg_1_0:onDone(true)
end

function var_0_0._onCombineDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_4_0._onCombineDone, arg_4_0)
end

return var_0_0
