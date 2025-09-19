module("modules.logic.fight.system.work.FightWorkNuoDiKaRandomAttackNum349", package.seeall)

local var_0_0 = class("FightWorkNuoDiKaRandomAttackNum349", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData

	arg_1_0:com_sendFightEvent(FightEvent.Blood2BengFa, var_1_0)

	local var_1_1 = true

	if var_1_0.effectNum1 == 0 then
		var_1_1 = false
	end

	if var_1_1 then
		arg_1_0:com_registTimer(arg_1_0.finishWork, 0.5)
	else
		arg_1_0:onDone(true)
	end
end

return var_0_0
