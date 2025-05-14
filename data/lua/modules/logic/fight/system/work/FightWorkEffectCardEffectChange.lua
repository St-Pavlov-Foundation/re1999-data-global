module("modules.logic.fight.system.work.FightWorkEffectCardEffectChange", package.seeall)

local var_0_0 = class("FightWorkEffectCardEffectChange", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0._actEffectMO) then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = string.splitToNumber(arg_1_0._actEffectMO.reserveStr, "#")
	local var_1_1 = FightCardModel.instance:getHandCards()

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		var_1_1[iter_1_1]:init(arg_1_0._actEffectMO.cardInfoList[iter_1_0])
		FightController.instance:dispatchEvent(FightEvent.RefreshOneHandCard, iter_1_1)
		FightController.instance:dispatchEvent(FightEvent.CardEffectChange, iter_1_1)
	end

	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
