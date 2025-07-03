module("modules.logic.fight.system.work.FightWorkAddHandCard", package.seeall)

local var_0_0 = class("FightWorkAddHandCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0.actEffectData) then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	if FightModel.instance:getVersion() >= 4 then
		local var_1_0 = 0.5

		arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, var_1_0)
		FightController.instance:dispatchEvent(FightEvent.AddHandCard)
	else
		FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
		arg_1_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_2_0)
	if arg_2_0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return var_0_0
