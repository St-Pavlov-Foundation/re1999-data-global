module("modules.logic.fight.system.work.FightWorkCardAConvertCardB", package.seeall)

local var_0_0 = class("FightWorkCardAConvertCardB", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0._actEffectMO) then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)
	AudioMgr.instance:trigger(2000072)

	local var_1_0 = FightCardModel.instance:getHandCards()
	local var_1_1 = arg_1_0._actEffectMO.effectNum
	local var_1_2 = var_1_0[var_1_1]

	if var_1_2 then
		var_1_2:init(arg_1_0._actEffectMO.cardInfo)

		if FightModel.instance:getVersion() >= 4 then
			FightController.instance:dispatchEvent(FightEvent.CardAConvertCardB, var_1_1)
			arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, FightEnum.PerformanceTime.CardAConvertCardB / FightModel.instance:getUISpeed())
		else
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			arg_1_0:onDone(true)
		end

		return
	end

	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	if arg_2_0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return var_0_0
