module("modules.logic.versionactivity2_5.act186.model.Activity186MO", package.seeall)

local var_0_0 = pureTable("Activity186MO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.spBonusStage = 0
	arg_1_0.taskDict = {}
end

function var_0_0.setSpBonusStage(arg_2_0, arg_2_1)
	arg_2_0.spBonusStage = arg_2_1
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	arg_3_0:updateActivityInfo(arg_3_1.info)
	arg_3_0:updateTaskInfos(arg_3_1.taskInfos)
	arg_3_0:updateLikeInfos(arg_3_1.likeInfos)
	arg_3_0:updateGameInfos(arg_3_1.gameInfos)
end

function var_0_0.updateActivityInfo(arg_4_0, arg_4_1)
	arg_4_0.currentStage = arg_4_1.currentStage
	arg_4_0.getDailyCollection = arg_4_1.getDailyCollection
	arg_4_0.getOneceBonus = arg_4_1.getOneceBonus
	arg_4_0.getMilestoneProgress = tonumber(arg_4_1.getMilestoneProgress)
end

function var_0_0.onGetOnceBonus(arg_5_0)
	arg_5_0.getOneceBonus = true

	if arg_5_0.spBonusStage == 0 then
		arg_5_0.spBonusStage = 1
	end
end

function var_0_0.acceptRewards(arg_6_0, arg_6_1)
	arg_6_0.getMilestoneProgress = tonumber(arg_6_1)
end

function var_0_0.getMilestoneRewardStatus(arg_7_0, arg_7_1)
	local var_7_0 = Activity186Enum.RewardStatus.None
	local var_7_1 = Activity186Config.instance:getMileStoneConfig(arg_7_0.id, arg_7_1)
	local var_7_2 = var_7_1 and var_7_1.coinNum or 0
	local var_7_3 = var_7_1 and var_7_1.isLoopBonus or false
	local var_7_4 = Activity186Config.instance:getConstNum(Activity186Enum.ConstId.CurrencyId)
	local var_7_5 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, var_7_4)

	if var_7_3 then
		if var_7_2 <= arg_7_0.getMilestoneProgress then
			if (var_7_1 and var_7_1.loopBonusIntervalNum or 1) <= var_7_5 - arg_7_0.getMilestoneProgress then
				var_7_0 = Activity186Enum.RewardStatus.Canget
			end
		elseif var_7_2 <= var_7_5 then
			var_7_0 = Activity186Enum.RewardStatus.Canget
		end
	elseif var_7_2 <= arg_7_0.getMilestoneProgress then
		var_7_0 = Activity186Enum.RewardStatus.Hasget
	elseif var_7_2 <= var_7_5 then
		var_7_0 = Activity186Enum.RewardStatus.Canget
	end

	return var_7_0
end

function var_0_0.getMilestoneValue(arg_8_0, arg_8_1)
	local var_8_0 = Activity186Config.instance:getMileStoneConfig(arg_8_0.id, arg_8_1)
	local var_8_1 = var_8_0 and var_8_0.coinNum or 0

	if not (var_8_0 and var_8_0.isLoopBonus or false) then
		return var_8_1
	end

	local var_8_2 = var_8_0 and var_8_0.loopBonusIntervalNum or 1
	local var_8_3 = Activity186Config.instance:getConstNum(Activity186Enum.ConstId.CurrencyId)
	local var_8_4 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, var_8_3)
	local var_8_5 = var_8_1

	if var_8_1 <= arg_8_0.getMilestoneProgress then
		var_8_5 = var_8_1 + math.floor((arg_8_0.getMilestoneProgress - var_8_1) / var_8_2) * var_8_2 + var_8_2
	end

	return var_8_5
end

function var_0_0.onGetDailyCollection(arg_9_0)
	arg_9_0.getDailyCollection = true
end

function var_0_0.updateTaskInfos(arg_10_0, arg_10_1)
	arg_10_0.taskDict = {}

	if arg_10_1 then
		for iter_10_0 = 1, #arg_10_1 do
			arg_10_0:updateTaskInfo(arg_10_1[iter_10_0])
		end
	end
end

function var_0_0.updateTaskInfo(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getTaskInfo(arg_11_1.taskId, true)

	var_11_0.progress = arg_11_1.progress
	var_11_0.hasGetBonus = arg_11_1.hasGetBonus
end

function var_0_0.getTaskInfo(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.taskDict[arg_12_1]

	if not var_12_0 and arg_12_2 then
		var_12_0 = {
			taskId = arg_12_1
		}
		var_12_0.progress = 0
		var_12_0.hasGetBonus = false
		arg_12_0.taskDict[arg_12_1] = var_12_0
	end

	return var_12_0
end

function var_0_0.getTaskList(arg_13_0)
	local var_13_0 = {}

	if arg_13_0.taskDict then
		for iter_13_0, iter_13_1 in pairs(arg_13_0.taskDict) do
			local var_13_1 = {
				id = iter_13_1.taskId,
				progress = iter_13_1.progress,
				hasGetBonus = iter_13_1.hasGetBonus,
				canGetReward = arg_13_0:checkTaskCanReward(iter_13_1),
				config = Activity186Config.instance:getTaskConfig(iter_13_1.taskId)
			}

			var_13_1.missionorder = var_13_1.config.missionorder
			var_13_1.status = Activity186Enum.TaskStatus.None

			if var_13_1.hasGetBonus then
				var_13_1.status = Activity186Enum.TaskStatus.Hasget
			elseif var_13_1.canGetReward then
				var_13_1.status = Activity186Enum.TaskStatus.Canget
			end

			table.insert(var_13_0, var_13_1)
		end
	end

	local var_13_2 = Activity186Config.instance:getStageConfig(arg_13_0.id, arg_13_0.currentStage)
	local var_13_3 = var_13_2 and var_13_2.globalTaskId or 0
	local var_13_4 = TaskModel.instance:getTaskById(var_13_3)
	local var_13_5 = {
		id = var_13_3,
		config = Activity173Config.instance:getTaskConfig(var_13_3),
		progress = var_13_4 and var_13_4.progress or 0,
		hasGetBonus = var_13_4 and var_13_4.finishCount > 0 or false
	}

	var_13_5.canGetReward = not var_13_5.hasGetBonus and var_13_4 and var_13_5.progress >= var_13_5.config.maxProgress
	var_13_5.missionorder = 0
	var_13_5.isGlobalTask = true
	var_13_5.status = Activity186Enum.TaskStatus.None

	if var_13_5.hasGetBonus then
		var_13_5.status = Activity186Enum.TaskStatus.Hasget
	elseif var_13_5.canGetReward then
		var_13_5.status = Activity186Enum.TaskStatus.Canget
	end

	table.insert(var_13_0, var_13_5)

	return var_13_0
end

function var_0_0.finishTask(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getTaskInfo(arg_14_1)

	if var_14_0 then
		var_14_0.hasGetBonus = true
	end
end

function var_0_0.pushTask(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 then
		for iter_15_0 = 1, #arg_15_1 do
			arg_15_0:updateTaskInfo(arg_15_1[iter_15_0])
		end
	end

	if arg_15_2 then
		for iter_15_1 = 1, #arg_15_2 do
			local var_15_0 = arg_15_2[iter_15_1]

			arg_15_0.taskDict[var_15_0.taskId] = nil
		end
	end
end

function var_0_0.checkTaskCanReward(arg_16_0, arg_16_1)
	local var_16_0 = type(arg_16_1) == "number" and arg_16_0:getTaskInfo(arg_16_1) or arg_16_1

	if not var_16_0 then
		return false
	end

	if var_16_0.hasGetBonus then
		return false
	end

	local var_16_1 = Activity186Config.instance:getTaskConfig(var_16_0.taskId)

	return (var_16_1 and var_16_1.maxProgress or 0) <= var_16_0.progress
end

function var_0_0.hasCanRewardTask(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.taskDict) do
		if arg_17_0:checkTaskCanReward(iter_17_1) then
			return true
		end
	end

	return false
end

function var_0_0.updateLikeInfos(arg_18_0, arg_18_1)
	arg_18_0.likeDict = {}

	if arg_18_1 then
		for iter_18_0 = 1, #arg_18_1 do
			arg_18_0:updateLikeInfo(arg_18_1[iter_18_0])
		end
	end
end

function var_0_0.updateLikeInfo(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getLikeInfo(arg_19_1.likeType)

	if not var_19_0 then
		var_19_0 = {
			likeType = arg_19_1.likeType
		}
		arg_19_0.likeDict[arg_19_1.likeType] = var_19_0
	end

	var_19_0.value = arg_19_1.value
end

function var_0_0.getLikeInfo(arg_20_0, arg_20_1)
	return arg_20_0.likeDict[arg_20_1]
end

function var_0_0.getLikeValue(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getLikeInfo(arg_21_1)

	return var_21_0 and var_21_0.value or 0
end

function var_0_0.pushLike(arg_22_0, arg_22_1)
	if arg_22_1 then
		for iter_22_0 = 1, #arg_22_1 do
			arg_22_0:updateLikeInfo(arg_22_1[iter_22_0])
		end
	end
end

function var_0_0.getCurLikeType(arg_23_0)
	if Activity186Config.instance:getConstNum(Activity186Enum.ConstId.BaseLikeValue) > arg_23_0:getLikeValue(4) then
		return 0
	end

	local var_23_0
	local var_23_1 = 0

	for iter_23_0, iter_23_1 in pairs(arg_23_0.likeDict) do
		if iter_23_0 ~= 4 and (not var_23_0 or var_23_0 < iter_23_1.value) then
			var_23_1 = iter_23_0
			var_23_0 = iter_23_1.value
		end
	end

	return var_23_1
end

function var_0_0.checkLikeEqual(arg_24_0, arg_24_1)
	return arg_24_0:getCurLikeType() == arg_24_1
end

function var_0_0.updateGameInfos(arg_25_0, arg_25_1)
	arg_25_0.gameDict = {}

	if arg_25_1 then
		for iter_25_0 = 1, #arg_25_1 do
			arg_25_0:updateGameInfo(arg_25_1[iter_25_0])
		end
	end
end

function var_0_0.updateGameInfo(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getGameInfo(arg_26_1.gameId)

	if not var_26_0 then
		var_26_0 = {
			gameId = arg_26_1.gameId
		}
		arg_26_0.gameDict[arg_26_1.gameId] = var_26_0
	end

	var_26_0.gameTypeId = arg_26_1.gameTypeId
	var_26_0.expireTime = arg_26_1.expireTime

	local var_26_1 = arg_26_1.bTypeGameInfo

	if var_26_1 then
		var_26_0.rewardId = var_26_1.rewardId
		var_26_0.bTypeRetryCount = var_26_1.bTypeRetryCount
	end
end

function var_0_0.getGameInfo(arg_27_0, arg_27_1)
	return arg_27_0.gameDict[arg_27_1]
end

function var_0_0.finishGame(arg_28_0, arg_28_1)
	if arg_28_0:getGameInfo(arg_28_1.gameId) then
		arg_28_0.gameDict[arg_28_1.gameId] = nil
	end
end

function var_0_0.playBTypeGame(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:getGameInfo(arg_29_1.gameId)

	if var_29_0 then
		var_29_0.rewardId = arg_29_1.rewardId

		if var_29_0.bTypeRetryCount then
			var_29_0.bTypeRetryCount = var_29_0.bTypeRetryCount - 1
		end
	end
end

function var_0_0.getOnlineGameList(arg_30_0)
	local var_30_0 = {}

	if arg_30_0.gameDict then
		for iter_30_0, iter_30_1 in pairs(arg_30_0.gameDict) do
			if iter_30_1.expireTime > ServerTime.now() then
				table.insert(var_30_0, iter_30_1)
			end
		end
	end

	return var_30_0
end

function var_0_0.isGameOnline(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0:getGameInfo(arg_31_1)

	return var_31_0 and var_31_0.expireTime > ServerTime.now()
end

function var_0_0.hasGameCanPlay(arg_32_0)
	return #arg_32_0:getOnlineGameList() > 0
end

function var_0_0.getQuestionConfig(arg_33_0, arg_33_1)
	local var_33_0 = Activity186Model.instance:prefabKeyPrefs(Activity186Enum.LocalPrefsKey.Question, arg_33_0.id)
	local var_33_1 = Activity186Controller.instance:getPlayerPrefs(var_33_0)
	local var_33_2 = string.splitToNumber(var_33_1, "#")
	local var_33_3 = var_33_2[1]
	local var_33_4 = var_33_2[2]

	if var_33_3 == arg_33_1 then
		local var_33_5 = Activity186Config.instance:getQuestionConfig(arg_33_1, var_33_4)

		if var_33_5 then
			return var_33_5
		end
	end

	local var_33_6 = Activity186Config.instance:getNextQuestion(arg_33_0.id, var_33_4)

	if var_33_6 then
		Activity186Controller.instance:setPlayerPrefs(var_33_0, string.format("%s#%s", arg_33_1, var_33_6.id))
	end

	return var_33_6
end

function var_0_0.hasActivityReward(arg_34_0)
	if not arg_34_0.getDailyCollection then
		return true
	end

	if Activity186Model.instance:isShowSignRed() then
		return true
	end

	local var_34_0 = Activity186Config.instance:getMileStoneList(arg_34_0.id)

	if var_34_0 then
		for iter_34_0, iter_34_1 in ipairs(var_34_0) do
			if arg_34_0:getMilestoneRewardStatus(iter_34_1.rewardId) == Activity186Enum.RewardStatus.Canget then
				return true
			end
		end
	end

	return false
end

function var_0_0.isInAvgTime(arg_35_0)
	local var_35_0 = Activity186Config.instance:getConstStr(Activity186Enum.ConstId.AvgOpenTime)
	local var_35_1 = string.split(var_35_0, "#")
	local var_35_2 = TimeUtil.stringToTimestamp(var_35_1[1])
	local var_35_3 = TimeUtil.stringToTimestamp(var_35_1[2])
	local var_35_4 = ServerTime.now()

	return var_35_2 <= var_35_4 and var_35_4 <= var_35_3
end

function var_0_0.isCanShowAvgBtn(arg_36_0)
	if arg_36_0.getOneceBonus then
		return false
	end

	return arg_36_0:isInAvgTime()
end

function var_0_0.isCanPlayAvgStory(arg_37_0)
	if arg_37_0.getOneceBonus then
		return false
	end

	if not arg_37_0:isInAvgTime() then
		return
	end

	return Activity186Controller.instance:getPlayerPrefs(Activity186Enum.LocalPrefsKey.AvgMark, 0) == 0
end

return var_0_0
