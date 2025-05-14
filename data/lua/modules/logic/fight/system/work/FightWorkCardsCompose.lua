module("modules.logic.fight.system.work.FightWorkCardsCompose", package.seeall)

local var_0_0 = class("FightWorkCardsCompose", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	arg_1_0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local var_1_0 = FightCardModel.instance:getHandCards()

	if FightCardModel.getCombineIndexOnce(var_1_0) then
		arg_1_0:com_registTimer(arg_1_0._delayDone, 10)

		arg_1_0._finalCards, arg_1_0._count = FightCardModel.calcCardsAfterCombine(var_1_0)

		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, arg_1_0._onCombineDone, arg_1_0)
		FightController.instance:dispatchEvent(FightEvent.CardsCompose)
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onCombineDone(arg_2_0)
	if arg_2_0._finalCards then
		FightCardModel.instance:coverCard(arg_2_0._finalCards)
	end

	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	arg_2_0:onDone(true)
end

function var_0_0._delayDone(arg_3_0)
	if arg_3_0._finalCards then
		FightCardModel.instance:coverCard(arg_3_0._finalCards)
	end

	FightController.instance:dispatchEvent(FightEvent.CardsComposeTimeOut)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end

	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_4_0._onCombineDone, arg_4_0)
end

return var_0_0
