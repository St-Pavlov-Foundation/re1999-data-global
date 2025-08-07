module("modules.logic.sp01.act204.model.Activity204MO", package.seeall)

local var_0_0 = pureTable("Activity204MO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.spBonusStage = 0
	arg_1_0.taskDict = {}
end

function var_0_0.setSpBonusStage(arg_2_0, arg_2_1)
	arg_2_0.spBonusStage = arg_2_1
end

function var_0_0.updateInfo(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:updateActivityInfo(arg_3_1)
	arg_3_0:updateTaskInfos(arg_3_2)
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
	local var_7_0 = Activity204Enum.RewardStatus.None
	local var_7_1 = Activity204Config.instance:getMileStoneConfig(arg_7_0.id, arg_7_1)
	local var_7_2 = var_7_1 and var_7_1.coinNum or 0
	local var_7_3 = var_7_1 and var_7_1.isLoopBonus or false
	local var_7_4 = Activity204Config.instance:getConstNum(Activity204Enum.ConstId.CurrencyId)
	local var_7_5 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, var_7_4)

	if var_7_3 then
		if var_7_2 <= arg_7_0.getMilestoneProgress then
			if (var_7_1 and var_7_1.loopBonusIntervalNum or 1) <= var_7_5 - arg_7_0.getMilestoneProgress then
				var_7_0 = Activity204Enum.RewardStatus.Canget
			end
		elseif var_7_2 <= var_7_5 then
			var_7_0 = Activity204Enum.RewardStatus.Canget
		end
	elseif var_7_2 <= arg_7_0.getMilestoneProgress then
		var_7_0 = Activity204Enum.RewardStatus.Hasget
	elseif var_7_2 <= var_7_5 then
		var_7_0 = Activity204Enum.RewardStatus.Canget
	end

	return var_7_0
end

function var_0_0.getMilestoneValue(arg_8_0, arg_8_1)
	local var_8_0 = Activity204Config.instance:getMileStoneConfig(arg_8_0.id, arg_8_1)
	local var_8_1 = var_8_0 and var_8_0.coinNum or 0

	if not (var_8_0 and var_8_0.isLoopBonus or false) then
		return var_8_1
	end

	local var_8_2 = var_8_0 and var_8_0.loopBonusIntervalNum or 1
	local var_8_3 = var_8_1

	if var_8_1 <= arg_8_0.getMilestoneProgress then
		var_8_3 = var_8_1 + math.floor((arg_8_0.getMilestoneProgress - var_8_1) / var_8_2) * var_8_2 + var_8_2
	end

	return var_8_3
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
	var_11_0.expireTime = tonumber(arg_11_1.expireTime)
end

function var_0_0.getTaskInfo(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.taskDict[arg_12_1]

	if not var_12_0 and arg_12_2 then
		var_12_0 = {
			taskId = arg_12_1
		}
		var_12_0.progress = 0
		var_12_0.hasGetBonus = false
		var_12_0.expireTime = 0
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
				expireTime = iter_13_1.expireTime,
				canGetReward = arg_13_0:checkTaskCanReward(iter_13_1),
				config = Activity204Config.instance:getTaskConfig(iter_13_1.taskId)
			}

			var_13_1.missionorder = var_13_1.config.missionorder
			var_13_1.status = Activity204Enum.TaskStatus.None

			if var_13_1.hasGetBonus then
				var_13_1.status = Activity204Enum.TaskStatus.Hasget
			elseif var_13_1.canGetReward then
				var_13_1.status = Activity204Enum.TaskStatus.Canget
			end

			table.insert(var_13_0, var_13_1)
		end
	end

	local var_13_2 = Activity204Config.instance:getStageConfig(arg_13_0.id, arg_13_0.currentStage)
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
	var_13_5.status = Activity204Enum.TaskStatus.None

	if var_13_5.hasGetBonus then
		var_13_5.status = Activity204Enum.TaskStatus.Hasget
	elseif var_13_5.canGetReward then
		var_13_5.status = Activity204Enum.TaskStatus.Canget
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
	arg_15_0:checkHasNewTask(arg_15_1)

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

function var_0_0.checkHasNewTask(arg_16_0, arg_16_1)
	arg_16_0._hasNewTask = false

	if arg_16_1 then
		for iter_16_0 = 1, #arg_16_1 do
			local var_16_0 = arg_16_1[iter_16_0].taskId

			if not arg_16_0:getTaskInfo(var_16_0) then
				arg_16_0._hasNewTask = true

				break
			end
		end
	end
end

function var_0_0.hasNewTask(arg_17_0)
	return arg_17_0._hasNewTask
end

function var_0_0.recordHasReadNewTask(arg_18_0)
	arg_18_0._hasNewTask = false
end

function var_0_0.checkTaskCanReward(arg_19_0, arg_19_1)
	local var_19_0 = type(arg_19_1) == "number" and arg_19_0:getTaskInfo(arg_19_1) or arg_19_1

	if not var_19_0 then
		return false
	end

	if var_19_0.hasGetBonus then
		return false
	end

	local var_19_1 = Activity204Config.instance:getTaskConfig(var_19_0.taskId)

	return (var_19_1 and var_19_1.maxProgress or 0) <= var_19_0.progress
end

function var_0_0.hasCanRewardTask(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.taskDict) do
		if arg_20_0:checkTaskCanReward(iter_20_1) then
			return true
		end
	end

	return false
end

function var_0_0.hasActivityReward(arg_21_0)
	if not arg_21_0.getDailyCollection then
		return true
	end

	local var_21_0 = Activity204Config.instance:getMileStoneList(arg_21_0.id)

	if var_21_0 then
		for iter_21_0, iter_21_1 in ipairs(var_21_0) do
			if arg_21_0:getMilestoneRewardStatus(iter_21_1.rewardId) == Activity204Enum.RewardStatus.Canget then
				return true
			end
		end
	end

	return false
end

function var_0_0.hasAnyLimitTask(arg_22_0)
	local var_22_0 = arg_22_0:getTaskList()

	for iter_22_0, iter_22_1 in ipairs(var_22_0 or {}) do
		if iter_22_1.status == Activity204Enum.TaskStatus.None and iter_22_1.config and iter_22_1.config.durationHour ~= 0 then
			return true
		end
	end

	return false
end

return var_0_0
