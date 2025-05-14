module("modules.logic.fight.system.work.FightWorkCardEffectChangeDone", package.seeall)

local var_0_0 = class("FightWorkCardEffectChangeDone", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, arg_2_0._onCardMagicEffectChangeDone, arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.PlayCardMagicEffectChange)
end

function var_0_0._onCardMagicEffectChangeDone(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_3_0._onCardMagicEffectChangeDone, arg_3_0)
	arg_3_0:_onDone()
end

function var_0_0._onDone(arg_4_0)
	arg_4_0:clearWork()
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	return
end

return var_0_0
