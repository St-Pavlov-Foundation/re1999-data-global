module("modules.logic.fight.system.work.FightWorkCardDeckDelete", package.seeall)

local var_0_0 = class("FightWorkCardDeckDelete", FightEffectBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.SAFETIME = 3
end

function var_0_0.beforePlayEffectData(arg_2_0)
	arg_2_0.beforeNum = FightDataHelper.fieldMgr.deckNum
end

function var_0_0.onStart(arg_3_0)
	local var_3_0 = arg_3_0.actEffectData.cardInfoList

	if var_3_0 and #var_3_0 < 1 then
		return arg_3_0:onDone(true)
	end

	local var_3_1 = FightDataHelper.fieldMgr.deckNum

	arg_3_0:com_sendFightEvent(FightEvent.CardBoxNumChange, arg_3_0.beforeNum, var_3_1)
	arg_3_0:com_registFightEvent(FightEvent.CardDeckDeleteDone, arg_3_0._delayDone)
	arg_3_0:com_sendFightEvent(FightEvent.CardDeckDelete, arg_3_0.actEffectData.cardInfoList)
end

return var_0_0
