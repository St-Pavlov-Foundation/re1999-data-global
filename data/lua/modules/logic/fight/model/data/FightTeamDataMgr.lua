module("modules.logic.fight.model.data.FightTeamDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightTeamDataMgr", FightDataMgrBase)

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
	arg_6_2.cardHeat = FightDataUtil.coverData(arg_6_1.cardHeat, arg_6_2.cardHeat)

	if arg_6_1.bloodPool then
		arg_6_2.bloodPool = FightDataUtil.coverData(arg_6_1.bloodPool, arg_6_2.bloodPool)
	end

	arg_6_2.itemSkillInfos = FightDataUtil.coverData(arg_6_1.itemSkillInfos, arg_6_2.itemSkillInfos)
end

function var_0_0.checkBloodPoolExist(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0[arg_7_1]

	if var_7_0.bloodPool then
		return
	end

	var_7_0.bloodPool = FightDataBloodPool.New()
end

return var_0_0
