module("modules.logic.fight.system.work.FightWorkRemoveUnivesalCards", package.seeall)

local var_0_0 = class("FightWorkRemoveUnivesalCards", FightEffectBase)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0._actEffectMO) then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local var_1_0 = {}
	local var_1_1 = FightCardModel.instance:getHandCards()
	local var_1_2 = #var_1_1

	for iter_1_0 = #var_1_1, 1, -1 do
		local var_1_3 = var_1_1[iter_1_0]

		if FightEnum.UniversalCard[var_1_3.skillId] then
			table.insert(var_1_0, iter_1_0)
			table.remove(var_1_1, iter_1_0)
		end
	end

	if #var_1_0 > 0 then
		FightCardModel.instance:coverCard(var_1_1)

		local var_1_4 = 0.033
		local var_1_5 = 1.2 + var_1_4 * 7 + 3 * var_1_4 * (var_1_2 - #var_1_0)

		if FightModel.instance:getVersion() >= 4 then
			arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, var_1_5 / FightModel.instance:getUISpeed())
			FightController.instance:dispatchEvent(FightEvent.CardRemove, var_1_0)
		else
			FightCardModel.instance:coverCard(FightCardModel.calcCardsAfterCombine(var_1_1))
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			arg_1_0:onDone(true)
		end
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._delayAfterPerformance(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	if arg_3_0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return var_0_0
