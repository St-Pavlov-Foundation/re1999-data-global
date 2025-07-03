module("modules.logic.fight.system.work.FightWorkCardRemove2", package.seeall)

local var_0_0 = class("FightWorkCardRemove2", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0.oldHandCard = FightDataUtil.copyData(FightDataHelper.handCardMgr.handCard)
end

function var_0_0.onStart(arg_2_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_2_0.actEffectData) then
		arg_2_0:onDone(true)

		return
	end

	arg_2_0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local var_2_0 = string.splitToNumber(arg_2_0.actEffectData.reserveStr, "#")

	if #var_2_0 > 0 then
		local var_2_1 = arg_2_0.oldHandCard

		table.sort(var_2_0, var_0_0.sort)

		local var_2_2 = FightCardDataHelper.calcRemoveCardTime(var_2_1, var_2_0)

		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			table.remove(var_2_1, iter_2_1)
		end

		if FightModel.instance:getVersion() >= 4 then
			arg_2_0:com_registTimer(arg_2_0._delayAfterPerformance, var_2_2 / FightModel.instance:getUISpeed())
			FightController.instance:dispatchEvent(FightEvent.CardRemove2, var_2_0)
		else
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			arg_2_0:onDone(true)
		end

		return
	end

	arg_2_0:onDone(true)
end

function var_0_0.sort(arg_3_0, arg_3_1)
	return arg_3_1 < arg_3_0
end

function var_0_0._delayAfterPerformance(arg_4_0)
	FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	if arg_5_0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return var_0_0
