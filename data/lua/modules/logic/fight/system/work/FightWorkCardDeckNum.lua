module("modules.logic.fight.system.work.FightWorkCardDeckNum", package.seeall)

local var_0_0 = class("FightWorkCardDeckNum", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0.afterDeckNum = FightDataHelper.fieldMgr.deckNum
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = FightDataHelper.fieldMgr.deckNum

	arg_2_0:com_sendFightEvent(FightEvent.CardBoxNumChange, arg_2_0.afterDeckNum, var_2_0)
	arg_2_0:onDone(true)
end

return var_0_0
