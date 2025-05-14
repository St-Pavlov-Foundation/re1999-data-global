module("modules.logic.fight.model.data.FightTeamDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightTeamDataMgr")

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.myData = {}
	arg_1_0.enemyData = {}
	arg_1_0[FightEnum.TeamType.MySide] = arg_1_0.myData
	arg_1_0[FightEnum.TeamType.EnemySide] = arg_1_0.enemyData
	arg_1_0.myCardHeatOffset = {}
end

function var_0_0.clearClientSimulationData(arg_2_0)
	arg_2_0.myCardHeatOffset = {}
end

function var_0_0.onCancelOperation(arg_3_0)
	arg_3_0:clearClientSimulationData()
end

function var_0_0.onStageChanged(arg_4_0)
	arg_4_0:clearClientSimulationData()
end

function var_0_0.updateData(arg_5_0, arg_5_1)
	arg_5_0:refreshTeamDataByProto(arg_5_1.attacker, arg_5_0.myData)
	arg_5_0:refreshTeamDataByProto(arg_5_1.defender, arg_5_0.enemyData)
end

function var_0_0.refreshTeamDataByProto(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2.cardHeat = FightDataHelper.coverData(FightDataCardHeatInfo.New(arg_6_1.cardHeat), arg_6_2.cardHeat)
end

return var_0_0
