module("modules.logic.fight.system.work.FightWorkMasterCardRemove", package.seeall)

local var_0_0 = class("FightWorkMasterCardRemove", FightEffectBase)

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
		AudioMgr.instance:trigger(20190020)

		local var_2_1 = arg_2_0.oldHandCard

		table.sort(var_2_0, FightWorkCardRemove2.sort)

		local var_2_2 = FightCardDataHelper.calcRemoveCardTime(var_2_1, var_2_0, 0.7)

		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			table.remove(var_2_1, iter_2_1)
		end

		if FightModel.instance:getVersion() >= 4 then
			arg_2_0:com_registTimer(arg_2_0._delayAfterPerformance, var_2_2 / FightModel.instance:getUISpeed())
			FightController.instance:dispatchEvent(FightEvent.MasterCardRemove, var_2_0)
		else
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			arg_2_0:onDone(true)
		end

		return
	end

	arg_2_0:onDone(true)
end

function var_0_0._delayAfterPerformance(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return var_0_0
