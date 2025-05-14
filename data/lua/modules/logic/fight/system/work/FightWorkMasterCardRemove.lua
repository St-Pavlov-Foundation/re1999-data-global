module("modules.logic.fight.system.work.FightWorkMasterCardRemove", package.seeall)

local var_0_0 = class("FightWorkMasterCardRemove", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0._actEffectMO) then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local var_1_0 = string.splitToNumber(arg_1_0._actEffectMO.reserveStr, "#")

	if #var_1_0 > 0 then
		AudioMgr.instance:trigger(20190020)

		local var_1_1 = tabletool.copy(FightCardModel.instance:getHandCards())

		table.sort(var_1_0, FightWorkCardRemove2.sort)

		local var_1_2 = FightCardDataHelper.calcRemoveCardTime(var_1_1, var_1_0, 0.7)

		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			table.remove(var_1_1, iter_1_1)
		end

		FightCardModel.instance:coverCard(var_1_1)

		if FightModel.instance:getVersion() >= 4 then
			arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, var_1_2 / FightModel.instance:getUISpeed())
			FightController.instance:dispatchEvent(FightEvent.MasterCardRemove, var_1_0)
		else
			FightCardModel.instance:coverCard(FightCardModel.calcCardsAfterCombine(var_1_1))
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			arg_1_0:onDone(true)
		end

		return
	end

	arg_1_0:onDone(true)
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
