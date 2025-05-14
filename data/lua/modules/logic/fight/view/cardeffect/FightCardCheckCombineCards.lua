module("modules.logic.fight.view.cardeffect.FightCardCheckCombineCards", package.seeall)

local var_0_0 = class("FightCardCheckCombineCards", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, true)
	FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, arg_1_0._onCombineDone, arg_1_0)
	FightController.instance:dispatchEvent(FightEvent.PlayCombineCards, arg_1_0.context.cards)
end

function var_0_0._onCombineDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_3_0._onCombineDone, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.PlayDiscardEffect, arg_3_0._onPlayDiscardEffect, arg_3_0)
end

return var_0_0
