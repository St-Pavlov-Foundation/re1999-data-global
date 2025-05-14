module("modules.logic.fight.system.work.FightWorkEffectExtraMoveAct", package.seeall)

local var_0_0 = class("FightWorkEffectExtraMoveAct", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	FightCardModel.instance:getCardMO():setExtraMoveAct(arg_1_0._actEffectMO.effectNum)
	FightController.instance:dispatchEvent(FightEvent.OnEffectExtraMoveAct)
	arg_1_0:onDone(true)
end

return var_0_0
