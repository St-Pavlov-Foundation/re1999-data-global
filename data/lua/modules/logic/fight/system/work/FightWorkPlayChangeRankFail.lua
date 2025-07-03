module("modules.logic.fight.system.work.FightWorkPlayChangeRankFail", package.seeall)

local var_0_0 = class("FightWorkPlayChangeRankFail", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0.actEffectData) then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = arg_1_0.actEffectData.effectNum

	arg_1_0:com_sendFightEvent(FightEvent.PlayChangeRankFail, var_1_0, arg_1_0.actEffectData.reserveStr)
	arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
