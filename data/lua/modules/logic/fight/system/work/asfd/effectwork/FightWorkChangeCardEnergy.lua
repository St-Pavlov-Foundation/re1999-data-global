module("modules.logic.fight.system.work.asfd.effectwork.FightWorkChangeCardEnergy", package.seeall)

local var_0_0 = class("FightWorkChangeCardEnergy", FightEffectBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.SAFETIME = 1.5
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = FightStrUtil.instance:getSplitString2Cache(arg_2_0.actEffectData.reserveStr, true)

	FightController.instance:dispatchEvent(FightEvent.ASFD_OnChangeCardEnergy, var_2_0)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 1 / FightModel.instance:getUISpeed())
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayDone, arg_3_0)
end

return var_0_0
