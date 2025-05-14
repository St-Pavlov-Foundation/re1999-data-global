module("modules.logic.fight.system.work.FightWorkCardRemove2", package.seeall)

local var_0_0 = class("FightWorkCardRemove2", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0._actEffectMO) then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local var_1_0 = string.splitToNumber(arg_1_0._actEffectMO.reserveStr, "#")

	if #var_1_0 > 0 then
		local var_1_1 = tabletool.copy(FightCardModel.instance:getHandCards())

		table.sort(var_1_0, var_0_0.sort)

		local var_1_2 = FightCardDataHelper.calcRemoveCardTime(var_1_1, var_1_0)

		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			table.remove(var_1_1, iter_1_1)
		end

		FightCardModel.instance:coverCard(var_1_1)

		if FightModel.instance:getVersion() >= 4 then
			arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, var_1_2 / FightModel.instance:getUISpeed())
			FightController.instance:dispatchEvent(FightEvent.CardRemove2, var_1_0)
		else
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			arg_1_0:onDone(true)
		end

		return
	end

	arg_1_0:onDone(true)
end

function var_0_0.sort(arg_2_0, arg_2_1)
	return arg_2_1 < arg_2_0
end

function var_0_0._delayAfterPerformance(arg_3_0)
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return var_0_0
