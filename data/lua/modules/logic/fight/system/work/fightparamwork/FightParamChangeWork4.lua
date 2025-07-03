module("modules.logic.fight.system.work.fightparamwork.FightParamChangeWork4", package.seeall)

local var_0_0 = class("FightParamChangeWork4", FightParamWorkBase)

function var_0_0.onStart(arg_1_0)
	FightController.instance:dispatchEvent(FightEvent.DoomsdayClock_OnAreaChange, arg_1_0.currValue)
	arg_1_0:com_registTimer(arg_1_0._delayDone, FightDoomsdayClockView.RotateDuration)
end

return var_0_0
