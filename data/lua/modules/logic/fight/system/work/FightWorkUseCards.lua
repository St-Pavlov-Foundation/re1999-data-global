module("modules.logic.fight.system.work.FightWorkUseCards", package.seeall)

local var_0_0 = class("FightWorkUseCards", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	FightPlayCardModel.instance:setUsedCard(arg_1_0.actEffectData.cardInfoList)
	FightController.instance:dispatchEvent(FightEvent.SetUseCards)
	FightViewPartVisible.set(false, false, false, false, true)
	arg_1_0:onDone(true)
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
