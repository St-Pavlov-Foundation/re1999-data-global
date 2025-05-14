module("modules.logic.versionactivity1_6.act149.model.Activity149Model", package.seeall)

local var_0_0 = class("Activity149Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._act149MoDict = {}
	arg_1_0._preScore = 0
	arg_1_0._curMaxScore = 0
	arg_1_0._totalScore = 0
	arg_1_0._hasGetBonusIds = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._act149MoDict = {}
	arg_2_0._curMaxScore = 0
	arg_2_0._totalScore = 0
	arg_2_0._hasGetBonusIds = {}
end

function var_0_0.onReceiveInfos(arg_3_0, arg_3_1)
	arg_3_0._act149MoDict = {}
	arg_3_0._hasGetBonusIds = {}
	arg_3_0._actId = arg_3_1.activityId

	local var_3_0 = arg_3_1.episodeInfos

	arg_3_0._preScore = arg_3_0._curMaxScore
	arg_3_0._curMaxScore = arg_3_1.currMaxScore
	arg_3_0._totalScore = arg_3_1.totalScore

	local var_3_1 = arg_3_1.hasGetBonusIds

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_2 = iter_3_1.id
		local var_3_3 = iter_3_1.episodeId
		local var_3_4 = Activity149Mo.New(var_3_2, arg_3_0._actId)

		arg_3_0._act149MoDict[var_3_2] = var_3_4
	end

	for iter_3_2, iter_3_3 in ipairs(var_3_1) do
		arg_3_0._hasGetBonusIds[iter_3_3] = true
	end
end

function var_0_0.onReceiveScoreInfos(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.hasGetBonusIds

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		arg_4_0._hasGetBonusIds[iter_4_1] = true
	end
end

function var_0_0.HasGotHigherScore(arg_5_0)
	return arg_5_0._curMaxScore > arg_5_0._preScore
end

function var_0_0.applyPreScoreToCurScore(arg_6_0)
	arg_6_0._preScore = arg_6_0._curMaxScore
end

function var_0_0.setFightScore(arg_7_0, arg_7_1)
	arg_7_0._fightPreScore = arg_7_0:getFightScore()
	arg_7_0._fightCurScore = arg_7_1
end

function var_0_0.noticeFightScore(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._fightPreScore

	arg_8_1 = arg_8_1 or arg_8_0._fightCurScore

	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.DungeonBossFightScoreChange, var_8_0, arg_8_1)
end

function var_0_0.getFightScore(arg_9_0)
	return arg_9_0._fightCurScore or 0
end

function var_0_0.getPreFightScore(arg_10_0)
	return arg_10_0._fightPreScore
end

function var_0_0.getAct149MoByOrder(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0._act149MoDict) do
		if arg_11_1 == iter_11_1.cfg.order then
			return iter_11_1
		end
	end
end

function var_0_0.getAct149MoByEpisodeId(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._act149MoDict) do
		if arg_12_1 == iter_12_1.cfg.episodeId then
			return iter_12_1
		end
	end
end

function var_0_0.getAct149EpisodeCfgIdByOrder(arg_13_0, arg_13_1)
	if arg_13_1 == VersionActivity1_6DungeonEnum.bossMaxOrder then
		local var_13_0 = ActivityModel.instance:getActMO(arg_13_0._actId):getOpeningDay()

		return arg_13_0:getMaxOrderAct149EpisodeCfg(var_13_0)
	else
		return Activity149Config.instance:getAct149EpisodeCfgByOrder(arg_13_1)
	end
end

function var_0_0.getMaxOrderAct149EpisodeCfg(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1 % Activity149Config.instance:getAlternateDay() + VersionActivity1_6DungeonEnum.bossMaxOrder

	return Activity149Config.instance:getAct149EpisodeCfg(var_14_0)
end

function var_0_0.getCurBossEpisodeRemainDay(arg_15_0)
	return 3 - ActivityModel.instance:getActMO(arg_15_0._actId):getOpeningDay() % 3
end

function var_0_0.isLastBossEpisode(arg_16_0)
	local var_16_0 = ActivityModel.instance:getActMO(arg_16_0._actId)

	return var_16_0:getRemainDay() < 2 - var_16_0:getOpeningDay() % 3
end

function var_0_0.getMaxOrderMo(arg_17_0)
	if not arg_17_0._act149MoDict then
		return nil
	end

	local var_17_0 = 0
	local var_17_1 = 1

	for iter_17_0, iter_17_1 in pairs(arg_17_0._act149MoDict) do
		local var_17_2 = iter_17_1.cfg.order

		if var_17_0 < var_17_2 then
			var_17_0 = var_17_2
			var_17_1 = iter_17_0
		end
	end

	return arg_17_0._act149MoDict[var_17_1], var_17_0
end

function var_0_0.getCurMaxScore(arg_18_0)
	return arg_18_0._curMaxScore
end

function var_0_0.getAleadyGotBonusIds(arg_19_0)
	return arg_19_0._hasGetBonusIds
end

function var_0_0.getTotalScore(arg_20_0)
	return arg_20_0._totalScore
end

function var_0_0.getScheduleViewRewardList(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = Activity149Config.instance:getBossRewardCfgList()

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		local var_21_2 = iter_21_1.id
		local var_21_3 = arg_21_0._hasGetBonusIds[var_21_2]

		var_21_0[#var_21_0 + 1] = {
			isGot = var_21_3,
			rewardCfg = iter_21_1
		}
	end

	return var_21_0
end

function var_0_0.checkAbleGetReward(arg_22_0, arg_22_1)
	local var_22_0 = Activity149Config.instance:getBossRewardCfgList()
	local var_22_1 = false
	local var_22_2 = 0
	local var_22_3 = 0

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		local var_22_4 = iter_22_1.id
		local var_22_5 = iter_22_1.rewardPointNum

		if arg_22_0._hasGetBonusIds[var_22_4] then
			var_22_3 = iter_22_0
			var_22_2 = iter_22_0
		elseif var_22_5 <= arg_22_1 then
			var_22_1 = true
			var_22_2 = iter_22_0
		end
	end

	return var_22_1, var_22_3, var_22_2
end

function var_0_0.checkEpisodePassedByOrder(arg_23_0, arg_23_1)
	if arg_23_1 == VersionActivity1_6DungeonEnum.bossMaxOrder then
		local var_23_0 = Activity149Config.instance:getAct149EpisodeCfgByOrder(arg_23_1, true)
		local var_23_1 = false

		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			local var_23_2 = DungeonModel.instance:getEpisodeInfo(iter_23_1.episodeId)

			if var_23_2 and var_23_2.star > 1 then
				var_23_1 = true

				break
			end
		end

		return var_23_1
	else
		local var_23_3 = Activity149Config.instance:getAct149EpisodeCfgByOrder(arg_23_1)
		local var_23_4 = DungeonModel.instance:getEpisodeInfo(var_23_3.episodeId)

		return var_23_4 and var_23_4.star > 1
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
