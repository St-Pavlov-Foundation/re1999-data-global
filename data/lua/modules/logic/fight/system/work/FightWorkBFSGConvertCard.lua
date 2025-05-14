module("modules.logic.fight.system.work.FightWorkBFSGConvertCard", package.seeall)

local var_0_0 = class("FightWorkBFSGConvertCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0._actEffectMO) then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = FightCardModel.instance:getHandCards()
	local var_1_1 = arg_1_0._actEffectMO.effectNum
	local var_1_2 = var_1_0[var_1_1]

	if var_1_2 then
		var_1_2:init(arg_1_0._actEffectMO.cardInfo)
		FightController.instance:dispatchEvent(FightEvent.RefreshOneHandCard, var_1_1)
	end

	arg_1_0:onDone(true)
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
