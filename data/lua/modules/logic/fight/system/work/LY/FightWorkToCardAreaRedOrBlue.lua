module("modules.logic.fight.system.work.LY.FightWorkToCardAreaRedOrBlue", package.seeall)

local var_0_0 = class("FightWorkToCardAreaRedOrBlue", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	FightPlayCardModel.instance:setUsedCard(arg_1_0.actEffectData.cardInfoList)
	FightController.instance:dispatchEvent(FightEvent.SetUseCards)
	FightViewPartVisible.set(false, false, false, false, true)
	arg_1_0:onDone(true)
end

return var_0_0
