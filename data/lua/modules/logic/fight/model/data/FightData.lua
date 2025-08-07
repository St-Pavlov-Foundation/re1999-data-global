module("modules.logic.fight.model.data.FightData", package.seeall)

local var_0_0 = FightDataClass("FightData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.attacker = FightTeamData.New(arg_1_1.attacker)
	arg_1_0.defender = FightTeamData.New(arg_1_1.defender)
	arg_1_0.curRound = arg_1_1.curRound
	arg_1_0.maxRound = arg_1_1.maxRound
	arg_1_0.isFinish = arg_1_1.isFinish
	arg_1_0.curWave = arg_1_1.curWave
	arg_1_0.battleId = arg_1_1.battleId

	if arg_1_1:HasField("magicCircle") then
		arg_1_0.magicCircle = FightMagicCircleInfoData.New(arg_1_1.magicCircle)
	end

	arg_1_0.version = arg_1_1.version
	arg_1_0.isRecord = arg_1_1.isRecord
	arg_1_0.episodeId = arg_1_1.episodeId
	arg_1_0.fightActType = arg_1_1.fightActType
	arg_1_0.lastChangeHeroUid = arg_1_1.lastChangeHeroUid
	arg_1_0.progress = arg_1_1.progress
	arg_1_0.progressMax = arg_1_1.progressMax
	arg_1_0.param = FightParamData.New(arg_1_1.param)
	arg_1_0.customData = FightCustomData.New(arg_1_1.customData)
	arg_1_0.fightTaskBox = FightTaskBoxData.New(arg_1_1.fightTaskBox)
	arg_1_0.progressDic = FightProgressInfoData.New(arg_1_1.progressList)
end

return var_0_0
