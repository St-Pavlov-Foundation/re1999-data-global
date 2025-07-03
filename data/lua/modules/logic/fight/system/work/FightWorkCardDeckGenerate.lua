module("modules.logic.fight.system.work.FightWorkCardDeckGenerate", package.seeall)

local var_0_0 = class("FightWorkCardDeckGenerate", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0.beforeNum = FightDataHelper.fieldMgr.deckNum
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = FightDataHelper.fieldMgr.deckNum

	arg_2_0:com_sendFightEvent(FightEvent.CardBoxNumChange, arg_2_0.beforeNum, var_2_0)
	arg_2_0:com_registFightEvent(FightEvent.CardDeckGenerateDone, arg_2_0._delayDone)
	arg_2_0:com_sendFightEvent(FightEvent.CardDeckGenerate, arg_2_0.actEffectData.cardInfoList)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
