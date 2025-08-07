module("modules.logic.versionactivity1_4.act128.model.Activity128Model", package.seeall)

local var_0_0 = class("Activity128Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.__activityId = false
	arg_2_0.__config = false
	arg_2_0.__stageInfos = {}
	arg_2_0.__stageHasGetBonusIds = {}
	arg_2_0._layer4Score = {}
	arg_2_0._layer4HighestScore = {}
end

function var_0_0._internal_set_activity(arg_3_0, arg_3_1)
	arg_3_0.__activityId = arg_3_1
end

function var_0_0._internal_set_config(arg_4_0, arg_4_1)
	assert(isTypeOf(arg_4_1, Activity128Config), debug.traceback())

	arg_4_0.__config = arg_4_1
end

function var_0_0.getConfig(arg_5_0)
	return assert(arg_5_0.__config, "pleaes call self:_internal_set_config(config) first")
end

function var_0_0.getActivityId(arg_6_0)
	return arg_6_0.__activityId
end

function var_0_0.getStageInfo(arg_7_0, arg_7_1)
	return arg_7_0.__stageInfos[arg_7_1]
end

function var_0_0.hasPassLevel(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.__config:getDungeonEpisodeId(arg_8_1, arg_8_2)

	return DungeonModel.instance:hasPassLevel(var_8_0)
end

function var_0_0.isBossLayerOpen(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0:isBossOnline(arg_9_1) then
		return false
	end

	if arg_9_2 <= 1 then
		return true
	end

	if arg_9_0.__config:getEpisodeCO(arg_9_1, arg_9_2 - 1) then
		return arg_9_0:hasPassLevel(arg_9_1, arg_9_2 - 1)
	end

	local var_9_0 = arg_9_0.__config:getDungeonEpisodeCO(arg_9_1, arg_9_2)

	if var_9_0 and var_9_0.preEpisode ~= 0 then
		return DungeonModel.instance:hasPassLevel(var_9_0.preEpisode)
	end

	return true
end

function var_0_0.hasGetBonusIds(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.__stageHasGetBonusIds[arg_10_1]

	if type(var_10_0) ~= "table" then
		return false
	end

	return var_10_0[arg_10_2] and true or false
end

function var_0_0.getTaskMoList(arg_11_0)
	return TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity128, arg_11_0.__activityId)
end

function var_0_0.getHighestPoint(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getStageInfo(arg_12_1)

	return var_12_0 and var_12_0.highestPoint or 0
end

function var_0_0.setHighestPoint(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if type(arg_13_2) ~= "number" then
		return
	end

	local var_13_0 = arg_13_0:getStageInfo(arg_13_1)

	if not var_13_0[arg_13_1] then
		return
	end

	if arg_13_3 then
		arg_13_2 = GameUtil.clamp(arg_13_2, 0, arg_13_0.__config:getStageCOMaxPoints(arg_13_1))
	end

	var_13_0.highestPoint = math.max(arg_13_0:getHighestPoint(arg_13_1), arg_13_2)
end

function var_0_0.getTotalPoint(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getStageInfo(arg_14_1)

	return var_14_0 and var_14_0.totalPoint or 0
end

function var_0_0.setTotalPoint(arg_15_0, arg_15_1, arg_15_2)
	if type(arg_15_2) ~= "number" then
		return
	end

	local var_15_0 = arg_15_0:getStageInfo(arg_15_1)

	if not var_15_0[arg_15_1] then
		return
	end

	var_15_0.totalPoint = math.max(arg_15_0:getTotalPoint(arg_15_1), arg_15_2)
end

function var_0_0.getStageOpenServerTime(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.__config:getEpisodeCOOpenDay(arg_16_1) or 1

	return arg_16_0:getRealStartTimeStamp() + (var_16_0 - 1) * 86400
end

function var_0_0.getActMO(arg_17_0)
	return ActivityModel.instance:getActMO(arg_17_0.__activityId)
end

function var_0_0.isActOnLine(arg_18_0)
	return ActivityHelper.getActivityStatus(arg_18_0.__activityId, true) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0.getRealStartTimeStamp(arg_19_0)
	return arg_19_0:getActMO():getRealStartTimeStamp()
end

function var_0_0.getRealEndTimeStamp(arg_20_0)
	return arg_20_0:getActMO():getRealEndTimeStamp()
end

function var_0_0.getRemainTimeStr(arg_21_0)
	local var_21_0 = ActivityModel.instance:getRemainTimeSec(arg_21_0.__activityId)

	if not arg_21_0.__config then
		return
	end

	return arg_21_0.__config:getRemainTimeStrWithFmt(var_21_0)
end

function var_0_0.isBossOnline(arg_22_0, arg_22_1)
	return ServerTime.now() >= arg_22_0:getStageOpenServerTime(arg_22_1)
end

function var_0_0.isBossOpen(arg_23_0, arg_23_1)
	local var_23_0 = BossRushModel.instance:getStageLayersInfo(arg_23_1)

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		if iter_23_1.isOpen then
			return true
		end
	end

	return false
end

function var_0_0.getBossUnlockEpisode(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:_getUnlockEpisodeId(arg_24_1)
	local var_24_1 = DungeonConfig.instance:getEpisodeCO(var_24_0)
	local var_24_2 = DungeonConfig.instance:getChapterCO(var_24_1 and var_24_1.chapterId)
	local var_24_3 = ActivityConfig.instance:getActivityCo(var_24_2 and var_24_2.actId)
	local var_24_4 = DungeonConfig.instance:getEpisodeDisplay(var_24_0)

	return var_24_3 and var_24_3.name, var_24_4
end

function var_0_0._getUnlockEpisodeId(arg_25_0, arg_25_1)
	local var_25_0 = BossRushModel.instance:getStageLayersInfo(arg_25_1)

	for iter_25_0, iter_25_1 in pairs(var_25_0) do
		local var_25_1 = BossRushConfig.instance:getDungeonEpisodeCO(arg_25_1, iter_25_1.layer)

		if var_25_1 and var_25_1.preEpisode ~= 0 then
			return var_25_1.preEpisode
		end
	end
end

function var_0_0._updateHasGetBonusIds(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0.__stageHasGetBonusIds[arg_26_1] = {}

	local var_26_0 = arg_26_0.__stageHasGetBonusIds[arg_26_1]

	for iter_26_0, iter_26_1 in ipairs(arg_26_2) do
		var_26_0[iter_26_1] = true
	end
end

function var_0_0._updateSingleHasGetBonusIds(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_0.__stageHasGetBonusIds[arg_27_1] then
		arg_27_0.__stageHasGetBonusIds[arg_27_1] = {}
	end

	arg_27_0.__stageHasGetBonusIds[arg_27_1][arg_27_2] = true
end

function var_0_0._updateAll(arg_28_0, arg_28_1)
	arg_28_0._activityId = arg_28_1.activityId

	for iter_28_0, iter_28_1 in ipairs(arg_28_1.bossDetail) do
		local var_28_0 = iter_28_1.bossId

		arg_28_0.__stageInfos[var_28_0] = iter_28_1

		arg_28_0:_updateHasGetBonusIds(var_28_0, iter_28_1.hasGetBonusIds)
		arg_28_0:_setLayer4Score(iter_28_1.bossId, iter_28_1 and iter_28_1.layer4TotalPoint or 0)
		arg_28_0:_setLayer4HightScore(iter_28_1.bossId, iter_28_1 and iter_28_1.layer4HighestPoint or 0)
	end
end

function var_0_0.onReceiveGet128InfosReply(arg_29_0, arg_29_1)
	arg_29_0:_updateAll(arg_29_1)
	arg_29_0:_onReceiveGet128InfosReply(arg_29_1)
end

function var_0_0._setLayer4Score(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0._layer4Score[arg_30_1] = tonumber(arg_30_2)
end

function var_0_0.getLayer4CurScore(arg_31_0, arg_31_1)
	return arg_31_0._layer4Score[arg_31_1] or 0
end

function var_0_0._setLayer4HightScore(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0._layer4HighestScore[arg_32_1] = tonumber(arg_32_2)
end

function var_0_0.getLayer4HightScore(arg_33_0, arg_33_1)
	return arg_33_0._layer4HighestScore[arg_33_1] or 0
end

function var_0_0.onReceiveAct128GetTotalRewardsReply(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1.bossId
	local var_34_1 = arg_34_1.hasGetBonusIds

	arg_34_0:_updateHasGetBonusIds(var_34_0, var_34_1)
	arg_34_0:_onReceiveAct128GetTotalRewardsReply(arg_34_1)
end

function var_0_0.onReceiveAct128SingleRewardReply(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_1.bossId
	local var_35_1 = arg_35_1.rewardId

	arg_35_0:_updateSingleHasGetBonusIds(var_35_0, var_35_1)
	arg_35_0:_onReceiveAct128SingleRewardReply(arg_35_1)
end

function var_0_0.onReceiveAct128DoublePointReply(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1.bossId
	local var_36_1 = arg_36_1.doubleNum
	local var_36_2 = arg_36_1.totalPoint
	local var_36_3 = arg_36_0:getStageInfo(var_36_0)

	var_36_3.doubleNum = var_36_1
	var_36_3.totalPoint = var_36_2

	arg_36_0:_onReceiveAct128DoublePointReply(arg_36_1)
end

function var_0_0.onReceiveAct128InfoUpdatePush(arg_37_0, arg_37_1)
	arg_37_0:_updateAll(arg_37_1)
	arg_37_0:_onReceiveAct128InfoUpdatePush(arg_37_1)
end

function var_0_0._onReceiveGet128InfosReply(arg_38_0, arg_38_1)
	return
end

function var_0_0._onReceiveAct128GetTotalRewardsReply(arg_39_0, arg_39_1)
	return
end

function var_0_0._onReceiveAct128DoublePointReply(arg_40_0, arg_40_1)
	return
end

return var_0_0
