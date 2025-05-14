module("modules.logic.fight.system.work.FightWorkAddUseCard", package.seeall)

local var_0_0 = class("FightWorkAddUseCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0._actEffectMO) then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = arg_1_0._actEffectMO.effectNum
	local var_1_1 = FightPlayCardModel.instance:getUsedCards()

	if var_1_0 - 1 > #var_1_1 then
		var_1_0 = #var_1_1 + 1
	end

	FightViewPartVisible.set(false, false, false, false, true)
	FightPlayCardModel.instance:addUseCard(var_1_0, arg_1_0._actEffectMO.cardInfo)
	FightController.instance:dispatchEvent(FightEvent.AddUseCard, var_1_0)
	arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, 0.5 / FightModel.instance:getUISpeed())
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
