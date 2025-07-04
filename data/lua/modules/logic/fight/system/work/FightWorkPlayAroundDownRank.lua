module("modules.logic.fight.system.work.FightWorkPlayAroundDownRank", package.seeall)

local var_0_0 = class("FightWorkPlayAroundDownRank", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0.actEffectData) then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = arg_1_0.actEffectData.effectNum
	local var_1_1 = FightPlayCardModel.instance:getUsedCards()[var_1_0]

	if var_1_1 then
		local var_1_2 = var_1_1.skillId

		FightDataUtil.coverData(arg_1_0.actEffectData.cardInfo, var_1_1)
		arg_1_0:com_sendFightEvent(FightEvent.PlayCardAroundDownRank, var_1_0, var_1_2)
	end

	arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
