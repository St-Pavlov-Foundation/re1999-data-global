module("modules.logic.fight.system.work.FightWorkRemoveEntityCards", package.seeall)

local var_0_0 = class("FightWorkRemoveEntityCards", FightEffectBase)

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

	local var_2_0 = arg_2_0.oldHandCard
	local var_2_1 = #var_2_0
	local var_2_2 = 0

	for iter_2_0 = #var_2_0, 1, -1 do
		if var_2_0[iter_2_0].uid == arg_2_0.actEffectData.targetId then
			var_2_2 = var_2_2 + 1
		end
	end

	if var_2_2 > 0 then
		local var_2_3 = 0.033
		local var_2_4 = 1.2 + var_2_3 * 7 + 3 * var_2_3 * (var_2_1 - var_2_2)

		if FightModel.instance:getVersion() >= 4 then
			arg_2_0:com_registTimer(arg_2_0._delayAfterPerformance, var_2_4 / FightModel.instance:getUISpeed())
			FightController.instance:dispatchEvent(FightEvent.RemoveEntityCards, arg_2_0.actEffectData.targetId)
		else
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			arg_2_0:onDone(true)
		end
	else
		arg_2_0:onDone(true)
	end
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
