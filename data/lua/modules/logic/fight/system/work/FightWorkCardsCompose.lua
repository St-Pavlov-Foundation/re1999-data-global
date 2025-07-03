module("modules.logic.fight.system.work.FightWorkCardsCompose", package.seeall)

local var_0_0 = class("FightWorkCardsCompose", FightEffectBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.skipAutoPlayData = true
end

function var_0_0.onStart(arg_2_0)
	arg_2_0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local var_2_0 = FightDataHelper.handCardMgr.handCard

	if FightCardDataHelper.canCombineCardListForPerformance(var_2_0) then
		arg_2_0:com_registTimer(arg_2_0._delayDone, 10)
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, arg_2_0._onCombineDone, arg_2_0)
		FightController.instance:dispatchEvent(FightEvent.CardsCompose)
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0._onCombineDone(arg_3_0)
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	arg_3_0:onDone(true)
end

function var_0_0._delayDone(arg_4_0)
	FightController.instance:dispatchEvent(FightEvent.CardsComposeTimeOut)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	if arg_5_0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end

	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_5_0._onCombineDone, arg_5_0)
end

return var_0_0
