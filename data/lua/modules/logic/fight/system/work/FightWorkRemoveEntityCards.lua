module("modules.logic.fight.system.work.FightWorkRemoveEntityCards", package.seeall)

local var_0_0 = class("FightWorkRemoveEntityCards", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0._actEffectMO) then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local var_1_0 = FightCardModel.instance:getHandCards()
	local var_1_1 = #var_1_0
	local var_1_2 = 0

	for iter_1_0 = #var_1_0, 1, -1 do
		if var_1_0[iter_1_0].uid == arg_1_0._actEffectMO.targetId then
			var_1_2 = var_1_2 + 1

			table.remove(var_1_0, iter_1_0)
		end
	end

	FightCardModel.instance:coverCard(var_1_0)

	if var_1_2 > 0 then
		local var_1_3 = 0.033
		local var_1_4 = 1.2 + var_1_3 * 7 + 3 * var_1_3 * (var_1_1 - var_1_2)

		if FightModel.instance:getVersion() >= 4 then
			arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, var_1_4 / FightModel.instance:getUISpeed())
			FightController.instance:dispatchEvent(FightEvent.RemoveEntityCards, arg_1_0._actEffectMO.targetId)
		else
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			arg_1_0:onDone(true)
		end
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._delayAfterPerformance(arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	if arg_3_0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return var_0_0
