module("modules.logic.fight.system.work.FightWorkAct174UseCard", package.seeall)

local var_0_0 = class("FightWorkAct174UseCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightCardModel.instance:getHandCards()
	local var_1_1 = arg_1_0._actEffectMO.effectNum

	if var_1_0[var_1_1] then
		table.remove(var_1_0, var_1_1)

		arg_1_0._finalCards = FightCardDataHelper.combineCardListForPerformance(FightDataHelper.coverData(var_1_0))

		arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, 5)
		arg_1_0:com_registFightEvent(FightEvent.PlayCardOver, arg_1_0._onPlayCardOver)
		FightViewPartVisible.set(false, true, true, false, false)
		arg_1_0:com_sendFightEvent(FightEvent.PlayHandCard, var_1_1)
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onPlayCardOver(arg_2_0)
	FightCardModel.instance:coverCard(arg_2_0._finalCards)
	FightCardModel.instance:clearCardOps()
	arg_2_0:com_sendFightEvent(FightEvent.RefreshHandCard)
	arg_2_0:onDone(true)
end

return var_0_0
