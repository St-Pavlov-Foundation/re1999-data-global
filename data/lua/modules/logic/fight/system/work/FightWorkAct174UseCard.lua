module("modules.logic.fight.system.work.FightWorkAct174UseCard", package.seeall)

local var_0_0 = class("FightWorkAct174UseCard", FightEffectBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.skipAutoPlayData = true
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = arg_2_0.actEffectData.effectNum

	arg_2_0:com_registTimer(arg_2_0._delayAfterPerformance, 5)
	arg_2_0:com_registFightEvent(FightEvent.PlayCardOver, arg_2_0._onPlayCardOver)
	FightViewPartVisible.set(false, true, true, false, false)
	arg_2_0:com_sendFightEvent(FightEvent.PlayHandCard, var_2_0)
end

function var_0_0._onPlayCardOver(arg_3_0)
	arg_3_0:com_sendFightEvent(FightEvent.RefreshHandCard)
	arg_3_0:onDone(true)
end

return var_0_0
