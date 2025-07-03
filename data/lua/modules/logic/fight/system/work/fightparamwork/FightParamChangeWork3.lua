module("modules.logic.fight.system.work.fightparamwork.FightParamChangeWork3", package.seeall)

local var_0_0 = class("FightParamChangeWork3", FightParamWorkBase)

function var_0_0.onStart(arg_1_0)
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnValueChange, arg_1_0.oldValue, arg_1_0.currValue, arg_1_0.offset)
	arg_1_0:com_registTimer(arg_1_0._delayDone, FightDoomsdayClockView.ZhiZhenTweenDuration)
end

return var_0_0
