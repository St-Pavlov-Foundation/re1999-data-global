module("modules.logic.fight.system.work.FightWorkBFSGConvertCard", package.seeall)

local var_0_0 = class("FightWorkBFSGConvertCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0.actEffectData) then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = FightDataHelper.handCardMgr.handCard
	local var_1_1 = arg_1_0.actEffectData.effectNum

	if var_1_0[var_1_1] then
		FightController.instance:dispatchEvent(FightEvent.RefreshOneHandCard, var_1_1)
	end

	arg_1_0:onDone(true)
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
