module("modules.logic.fight.model.data.FightFieldDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightFieldDataMgr", FightDataMgrBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.deckNum = 0
end

function var_0_0.onStageChanged(arg_2_0)
	return
end

function var_0_0.updateData(arg_3_0, arg_3_1)
	arg_3_0.version = arg_3_1.version
	arg_3_0.fightActType = arg_3_1.fightActType or FightEnum.FightActType.Normal
	arg_3_0.curRound = arg_3_1.curRound
	arg_3_0.maxRound = arg_3_1.maxRound
	arg_3_0.isFinish = arg_3_1.isFinish
	arg_3_0.curWave = arg_3_1.curWave
	arg_3_0.battleId = arg_3_1.battleId
	arg_3_0.magicCircle = FightDataUtil.coverData(arg_3_1.magicCircle, arg_3_0.magicCircle)
	arg_3_0.isRecord = arg_3_1.isRecord
	arg_3_0.episodeId = arg_3_1.episodeId
	arg_3_0.episodeCo = DungeonConfig.instance:getEpisodeCO(arg_3_0.episodeId)
	arg_3_0.lastChangeHeroUid = arg_3_1.lastChangeHeroUid
	arg_3_0.progress = arg_3_1.progress
	arg_3_0.progressMax = arg_3_1.progressMax
	arg_3_0.param = FightDataUtil.coverData(arg_3_1.param, arg_3_0.param)
	arg_3_0.indicatorDict = arg_3_0:buildIndicators(arg_3_1)
	arg_3_0.playerFinisherInfo = FightDataUtil.coverData(arg_3_1.attacker.playerFinisherInfo, arg_3_0.playerFinisherInfo)
	arg_3_0.customData = FightDataUtil.coverData(arg_3_1.customData, arg_3_0.customData)
	arg_3_0.fightTaskBox = FightDataUtil.coverData(arg_3_1.fightTaskBox, arg_3_0.fightTaskBox)
	arg_3_0.progressDic = FightDataUtil.coverData(arg_3_1.progressDic, arg_3_0.progressDic)
end

function var_0_0.buildIndicators(arg_4_0, arg_4_1)
	local var_4_0 = {}

	if arg_4_1.attacker then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1.attacker.indicators) do
			local var_4_1 = tonumber(iter_4_1.inticatorId)

			var_4_0[var_4_1] = {
				id = var_4_1,
				num = iter_4_1.num
			}
		end
	end

	return FightDataUtil.coverData(var_4_0, arg_4_0.indicatorDict)
end

function var_0_0.getIndicatorNum(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.indicatorDict and arg_5_0.indicatorDict[arg_5_1]

	return var_5_0 and var_5_0.num or 0
end

function var_0_0.isDouQuQu(arg_6_0)
	return arg_6_0.fightActType == FightEnum.FightActType.Act174
end

function var_0_0.isSeason2(arg_7_0)
	return arg_7_0.fightActType == FightEnum.FightActType.Season2
end

function var_0_0.isDungeonType(arg_8_0, arg_8_1)
	return arg_8_0.episodeCo and arg_8_0.episodeCo.type == arg_8_1
end

function var_0_0.isPaTa(arg_9_0)
	return arg_9_0:isDungeonType(DungeonEnum.EpisodeType.TowerBoss) or arg_9_0:isDungeonType(DungeonEnum.EpisodeType.TowerLimited) or arg_9_0:isDungeonType(DungeonEnum.EpisodeType.TowerPermanent) or arg_9_0:isDungeonType(DungeonEnum.EpisodeType.TowerBossTeach)
end

function var_0_0.isTowerLimited(arg_10_0)
	return arg_10_0:isDungeonType(DungeonEnum.EpisodeType.TowerLimited)
end

function var_0_0.isAct183(arg_11_0)
	return arg_11_0:isDungeonType(DungeonEnum.EpisodeType.Act183)
end

function var_0_0.dirSetDeckNum(arg_12_0, arg_12_1)
	arg_12_0.deckNum = arg_12_1
end

function var_0_0.changeDeckNum(arg_13_0, arg_13_1)
	arg_13_0.deckNum = arg_13_0.deckNum + arg_13_1
end

function var_0_0.is191DouQuQu(arg_14_0)
	return arg_14_0.customData and arg_14_0.customData[FightCustomData.CustomDataType.Act191]
end

function var_0_0.isShelter(arg_15_0)
	return arg_15_0:isDungeonType(DungeonEnum.EpisodeType.Shelter)
end

function var_0_0.isSurvival(arg_16_0)
	return arg_16_0:isDungeonType(DungeonEnum.EpisodeType.Survival)
end

return var_0_0
