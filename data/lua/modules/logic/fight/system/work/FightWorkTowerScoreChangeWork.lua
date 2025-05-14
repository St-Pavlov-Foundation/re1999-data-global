module("modules.logic.fight.system.work.FightWorkTowerScoreChangeWork", package.seeall)

local var_0_0 = class("FightWorkTowerScoreChangeWork", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0.indicatorId = FightEnum.IndicatorId.PaTaScore

	local var_1_0 = FightDataHelper.fieldMgr.indicatorDict[arg_1_0.indicatorId]

	arg_1_0._beforeScore = var_1_0 and var_1_0.num or 0
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = FightDataHelper.fieldMgr.indicatorDict[arg_2_0.indicatorId]

	arg_2_0._curScore = var_2_0 and var_2_0.num or 0

	arg_2_0:com_sendFightEvent(FightEvent.OnIndicatorChange, arg_2_0.indicatorId)
	arg_2_0:com_sendFightEvent(FightEvent.OnAssistBossScoreChange, arg_2_0._beforeScore, arg_2_0._curScore)
	arg_2_0:onDone(true)
end

return var_0_0
