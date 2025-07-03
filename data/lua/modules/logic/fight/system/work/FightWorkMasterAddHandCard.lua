module("modules.logic.fight.system.work.FightWorkMasterAddHandCard", package.seeall)

local var_0_0 = class("FightWorkMasterAddHandCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0.actEffectData) then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)
	AudioMgr.instance:trigger(20190019)

	if FightModel.instance:getVersion() >= 4 then
		FightController.instance:dispatchEvent(FightEvent.MasterAddHandCard)
		arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, 1 / FightModel.instance:getUISpeed())
	else
		FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
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
