module("modules.logic.fight.model.data.FightFieldDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightFieldDataMgr")

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.actPoint = 0
	arg_1_0.moveNum = 0
	arg_1_0.extraMoveAct = 0
	arg_1_0.deckNum = 0
end

function var_0_0.onStageChanged(arg_2_0)
	arg_2_0.extraMoveAct = 0
end

function var_0_0.updateData(arg_3_0, arg_3_1)
	arg_3_0.version = arg_3_1.version
	arg_3_0.fightActType = arg_3_1.fightActType or FightEnum.FightActType.Normal
	arg_3_0.curRound = arg_3_1.curRound
	arg_3_0.maxRound = arg_3_1.maxRound
	arg_3_0.isFinish = arg_3_1.isFinish
	arg_3_0.curWave = arg_3_1.curWave
	arg_3_0.battleId = arg_3_1.battleId
	arg_3_0.magicCircle = FightDataHelper.coverData(FightMagicCircleInfoData.New(arg_3_1.magicCircle), arg_3_0.magicCircle)
	arg_3_0.isRecord = arg_3_1.isRecord
	arg_3_0.episodeId = arg_3_1.episodeId
	arg_3_0.episodeCo = DungeonConfig.instance:getEpisodeCO(arg_3_0.episodeId)
	arg_3_0.lastChangeHeroUid = arg_3_1.lastChangeHeroUid
	arg_3_0.progress = arg_3_1.progress
	arg_3_0.progressMax = arg_3_1.progressMax
	arg_3_0.param = FightDataHelper.coverData(FightParamData.New(arg_3_1.param), arg_3_0.param)
	arg_3_0.indicatorDict = arg_3_0:buildIndicators(arg_3_1)
	arg_3_0.playerFinisherInfo = arg_3_0:buildPlayerFinisherInfo(arg_3_1)
	arg_3_0.customData = FightDataHelper.coverData(FightCustomData.New(arg_3_1.customData), arg_3_0.customData)
	arg_3_0.fightTaskBox = FightDataHelper.coverData(FightTaskBoxData.New(arg_3_1.fightTaskBox), arg_3_0.fightTaskBox)
end

function var_0_0.buildIndicators(arg_4_0, arg_4_1)
	local var_4_0 = {}

	if arg_4_1:HasField("attacker") then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1.attacker.indicators) do
			local var_4_1 = tonumber(iter_4_1.inticatorId)

			var_4_0[var_4_1] = {
				id = var_4_1,
				num = iter_4_1.num
			}
		end
	end

	return FightDataHelper.coverData(var_4_0, arg_4_0.indicatorDict)
end

function var_0_0.buildPlayerFinisherInfo(arg_5_0, arg_5_1)
	local var_5_0

	if arg_5_1:HasField("attacker") and arg_5_1.attacker:HasField("playerFinisherInfo") then
		var_5_0 = arg_5_1.attacker.playerFinisherInfo
	end

	return arg_5_0:setPlayerFinisherInfo(var_5_0)
end

function var_0_0.setPlayerFinisherInfo(arg_6_0, arg_6_1)
	local var_6_0 = {
		skills = {}
	}

	var_6_0.roundUseLimit = 0

	if arg_6_1 then
		local var_6_1 = arg_6_1

		var_6_0.roundUseLimit = var_6_1.roundUseLimit

		local var_6_2 = var_6_0.skills

		for iter_6_0, iter_6_1 in ipairs(var_6_1.skills) do
			local var_6_3 = {
				skillId = iter_6_1.skillId,
				needPower = iter_6_1.needPower
			}

			table.insert(var_6_2, var_6_3)
		end
	end

	return FightDataHelper.coverData(var_6_0, arg_6_0.playerFinisherInfo)
end

function var_0_0.getIndicatorNum(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.indicatorDict and arg_7_0.indicatorDict[arg_7_1]

	return var_7_0 and var_7_0.num or 0
end

function var_0_0.isDouQuQu(arg_8_0)
	return arg_8_0.fightActType == FightEnum.FightActType.Act174
end

function var_0_0.isSeason2(arg_9_0)
	return arg_9_0.fightActType == FightEnum.FightActType.Season2
end

function var_0_0.isDungeonType(arg_10_0, arg_10_1)
	return arg_10_0.episodeCo and arg_10_0.episodeCo.type == arg_10_1
end

function var_0_0.isPaTa(arg_11_0)
	return arg_11_0:isDungeonType(DungeonEnum.EpisodeType.TowerBoss) or arg_11_0:isDungeonType(DungeonEnum.EpisodeType.TowerLimited) or arg_11_0:isDungeonType(DungeonEnum.EpisodeType.TowerPermanent)
end

function var_0_0.isTowerLimited(arg_12_0)
	return arg_12_0:isDungeonType(DungeonEnum.EpisodeType.TowerLimited)
end

function var_0_0.isAct183(arg_13_0)
	return arg_13_0:isDungeonType(DungeonEnum.EpisodeType.Act183)
end

function var_0_0.dealCardInfoPush(arg_14_0, arg_14_1)
	arg_14_0.actPoint = arg_14_1.actPoint
	arg_14_0.moveNum = arg_14_1.moveNum
	arg_14_0.extraMoveAct = arg_14_1.extraMoveAct
end

function var_0_0.isUnlimitMoveCard(arg_15_0)
	return arg_15_0.extraMoveAct == -1
end

function var_0_0.dirSetDeckNum(arg_16_0, arg_16_1)
	arg_16_0.deckNum = arg_16_1
end

function var_0_0.changeDeckNum(arg_17_0, arg_17_1)
	arg_17_0.deckNum = arg_17_0.deckNum + arg_17_1
end

return var_0_0
