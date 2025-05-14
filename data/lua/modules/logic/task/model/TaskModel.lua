module("modules.logic.task.model.TaskModel", package.seeall)

local var_0_0 = class("TaskModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._taskMODict = {}
	arg_2_0._taskActivityMODict = {}
	arg_2_0._newTaskIdDict = {}
	arg_2_0._curStage = 0
	arg_2_0._taskList = {}
	arg_2_0._hasTaskNoviceStageReward = false
	arg_2_0._noviceTaskHeroParam = nil
end

function var_0_0.setHasTaskNoviceStageReward(arg_3_0, arg_3_1)
	arg_3_0._hasTaskNoviceStageReward = arg_3_1
end

function var_0_0.couldGetTaskNoviceStageReward(arg_4_0)
	return arg_4_0._hasTaskNoviceStageReward
end

function var_0_0.setTaskNoviceStageHeroParam(arg_5_0, arg_5_1)
	arg_5_0._noviceTaskHeroParam = arg_5_1
end

function var_0_0.getTaskNoviceStageParam(arg_6_0)
	return arg_6_0._noviceTaskHeroParam
end

function var_0_0.getTaskById(arg_7_0, arg_7_1)
	return arg_7_0._taskList[arg_7_1]
end

function var_0_0.getTaskMoList(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}
	local var_8_1 = arg_8_0:getAllUnlockTasks(arg_8_1)

	if not var_8_1 then
		return var_8_0
	end

	for iter_8_0, iter_8_1 in pairs(var_8_1) do
		if iter_8_1.config and iter_8_1.config.activityId == arg_8_2 then
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function var_0_0.getRefreshCount(arg_9_0)
	return arg_9_0._selectCount
end

function var_0_0.setRefreshCount(arg_10_0, arg_10_1)
	arg_10_0._selectCount = arg_10_1
end

function var_0_0.setTaskMOList(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
		arg_11_0._taskMODict[iter_11_1] = {}
	end

	if arg_11_1 then
		for iter_11_2, iter_11_3 in ipairs(arg_11_1) do
			local var_11_0 = arg_11_0:getTaskConfig(iter_11_3.type, iter_11_3.id)
			local var_11_1 = TaskMo.New()

			var_11_1:init(iter_11_3, var_11_0)

			if not arg_11_0._taskMODict[iter_11_3.type] then
				arg_11_0._taskMODict[iter_11_3.type] = {}
			end

			arg_11_0._taskMODict[iter_11_3.type][iter_11_3.id] = var_11_1
			arg_11_0._taskList[iter_11_3.id] = var_11_1
		end
	end
end

function var_0_0.onTaskMOChange(arg_12_0, arg_12_1)
	if arg_12_1 then
		for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
			local var_12_0 = arg_12_0._taskMODict[iter_12_1.type] and arg_12_0._taskMODict[iter_12_1.type][iter_12_1.id] or nil

			if not var_12_0 then
				local var_12_1 = arg_12_0:getTaskConfig(iter_12_1.type, iter_12_1.id)
				local var_12_2 = TaskMo.New()

				var_12_2:init(iter_12_1, var_12_1)

				if not arg_12_0._taskMODict[iter_12_1.type] then
					arg_12_0._taskMODict[iter_12_1.type] = {}
				end

				arg_12_0._taskMODict[iter_12_1.type][iter_12_1.id] = var_12_2
				arg_12_0._taskList[iter_12_1.id] = var_12_2
				arg_12_0._newTaskIdDict[iter_12_1.id] = true
			else
				var_12_0:update(iter_12_1)
			end
		end
	end
end

function var_0_0.getTaskConfig(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = TaskConfigGetDefine.instance:getTaskConfigFunc(arg_13_1)

	if var_13_0 then
		return var_13_0(arg_13_2)
	end
end

function var_0_0.isTaskFinish(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0._taskMODict[arg_14_1]

	if not var_14_0 then
		return false
	end

	local var_14_1 = var_14_0[arg_14_2]

	if not var_14_1 then
		return false
	end

	return var_14_1:isClaimed()
end

function var_0_0.taskHasFinished(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0._taskMODict[arg_15_1]

	if not var_15_0 then
		return false
	end

	local var_15_1 = var_15_0[arg_15_2]

	if not var_15_1 then
		return false
	end

	return var_15_1:isFinished()
end

function var_0_0.isTaskUnlock(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0._taskMODict[arg_16_1]

	if not var_16_0 then
		return false
	end

	local var_16_1 = var_16_0[arg_16_2]

	if not var_16_1 then
		return false
	end

	return var_16_1.id == arg_16_2
end

function var_0_0.getAllUnlockTasks(arg_17_0, arg_17_1)
	return arg_17_0._taskMODict[arg_17_1] or {}
end

function var_0_0.setTaskActivityMOList(arg_18_0, arg_18_1)
	if arg_18_1 then
		for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
			local var_18_0 = arg_18_0._taskActivityMODict[iter_18_1.typeId]

			if not var_18_0 then
				local var_18_1

				if iter_18_1.defineId + 1 <= 5 then
					var_18_1 = TaskConfig.instance:gettaskactivitybonusCO(iter_18_1.typeId, iter_18_1.defineId + 1)
				else
					var_18_1 = TaskConfig.instance:gettaskactivitybonusCO(iter_18_1.typeId, iter_18_1.defineId)
				end

				var_18_0 = TaskActivityMo.New()

				var_18_0:init(iter_18_1, var_18_1)

				arg_18_0._taskActivityMODict[iter_18_1.typeId] = var_18_0
			else
				var_18_0:update(iter_18_1)
			end
		end
	end
end

function var_0_0.onTaskActivityMOChange(arg_19_0, arg_19_1)
	if arg_19_1 then
		local var_19_0

		for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
			local var_19_1 = arg_19_0._taskActivityMODict[iter_19_1.typeId]

			if not var_19_1 then
				local var_19_2

				if iter_19_1.defineId + 1 <= 5 then
					var_19_2 = TaskConfig.instance:gettaskactivitybonusCO(iter_19_1.typeId, iter_19_1.defineId + 1)
				else
					var_19_2 = TaskConfig.instance:gettaskactivitybonusCO(iter_19_1.typeId, iter_19_1.defineId)
				end

				local var_19_3 = TaskActivityMo.New()

				if var_19_2 ~= nil then
					var_19_3:init(iter_19_1, var_19_2)
				end

				var_19_0 = var_19_0 or {}

				table.insert(var_19_0, var_19_3)

				arg_19_0._taskActivityMODict[iter_19_1.typeId] = var_19_3
			else
				var_19_1:update(iter_19_1)
			end
		end
	end
end

function var_0_0.deleteTask(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in pairs(arg_20_1) do
		for iter_20_2, iter_20_3 in pairs(arg_20_0._taskMODict) do
			arg_20_0._taskMODict[iter_20_2][iter_20_1] = nil
		end
	end
end

function var_0_0.clearNewTaskIds(arg_21_0)
	arg_21_0._newTaskIdDict = {}
end

function var_0_0.getNewTaskIds(arg_22_0)
	return arg_22_0._newTaskIdDict
end

function var_0_0.getTaskActivityMO(arg_23_0, arg_23_1)
	return arg_23_0._taskActivityMODict[arg_23_1]
end

function var_0_0.getNoviceTaskCurStage(arg_24_0)
	if arg_24_0._curStage == 0 then
		arg_24_0._curStage = arg_24_0:getNoviceTaskMaxUnlockStage()
	end

	return arg_24_0._curStage
end

function var_0_0.setNoviceTaskCurStage(arg_25_0, arg_25_1)
	arg_25_0._curStage = arg_25_1
end

function var_0_0.setNoviceTaskCurSelectStage(arg_26_0, arg_26_1)
	arg_26_0._curSelectStage = arg_26_1
end

function var_0_0.getNoviceTaskCurSelectStage(arg_27_0)
	return arg_27_0._curSelectStage or arg_27_0:getNoviceTaskCurStage()
end

function var_0_0.getStageRewardGetIndex(arg_28_0)
	return arg_28_0._taskActivityMODict[TaskEnum.TaskType.Novice].defineId
end

function var_0_0.getNoviceTaskMaxUnlockStage(arg_29_0)
	local var_29_0 = 0

	if arg_29_0._taskMODict[TaskEnum.TaskType.Novice] then
		for iter_29_0, iter_29_1 in pairs(arg_29_0._taskMODict[TaskEnum.TaskType.Novice]) do
			if iter_29_1.config.minTypeId == TaskEnum.TaskMinType.Novice then
				local var_29_1 = TaskConfig.instance:gettaskNoviceConfig(iter_29_1.id).stage

				if var_29_0 < var_29_1 and iter_29_1.config.chapter == 0 then
					var_29_0 = var_29_1
				end
			end
		end
	end

	return var_29_0
end

function var_0_0.getCurStageActDotGetNum(arg_30_0)
	local var_30_0 = arg_30_0:getNoviceTaskCurStage()
	local var_30_1 = arg_30_0:getMaxStage(TaskEnum.TaskType.Novice)

	if var_30_0 == var_30_1 and arg_30_0._taskActivityMODict[TaskEnum.TaskType.Novice].gainValue == arg_30_0:getAllTaskTotalActDot() then
		return TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, var_30_1).needActivity
	end

	if not arg_30_0._taskActivityMODict[TaskEnum.TaskType.Novice] then
		return 0
	end

	return arg_30_0._taskActivityMODict[TaskEnum.TaskType.Novice].value - arg_30_0._taskActivityMODict[TaskEnum.TaskType.Novice].gainValue
end

function var_0_0.getStageActDotGetNum(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0:getNoviceTaskCurStage()

	if var_31_0 < arg_31_1 then
		return 0
	end

	if arg_31_1 < var_31_0 then
		return TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, arg_31_1).needActivity
	end

	return arg_31_0:getCurStageActDotGetNum()
end

function var_0_0.getAllTaskTotalActDot(arg_32_0)
	local var_32_0 = 0
	local var_32_1 = TaskConfig.instance:gettaskNoviceConfigs()

	for iter_32_0, iter_32_1 in pairs(var_32_1) do
		var_32_0 = var_32_0 + iter_32_1.activity
	end

	return var_32_0
end

function var_0_0.getCurStageMaxActDot(arg_33_0)
	local var_33_0 = TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, arg_33_0._curStage)

	return var_33_0 and var_33_0.needActivity or 0
end

function var_0_0.getStageMaxActDot(arg_34_0, arg_34_1)
	local var_34_0 = TaskConfig.instance:gettaskactivitybonusCO(TaskEnum.TaskType.Novice, arg_34_1)

	return var_34_0 and var_34_0.needActivity or 0
end

function var_0_0.getMaxStage(arg_35_0, arg_35_1)
	local var_35_0 = 1
	local var_35_1 = TaskConfig.instance:getTaskActivityBonusConfig(arg_35_1)
	local var_35_2 = VersionValidator.instance:isInReviewing()

	for iter_35_0, iter_35_1 in pairs(var_35_1) do
		if (var_35_2 and iter_35_1.hideInVerifing == true) == false and var_35_0 < iter_35_1.id then
			var_35_0 = iter_35_1.id
		end
	end

	return var_35_0
end

function var_0_0.getCurStageAllLockTaskIds(arg_36_0)
	local var_36_0 = {}
	local var_36_1 = TaskConfig.instance:gettaskNoviceConfigs()

	for iter_36_0, iter_36_1 in pairs(var_36_1) do
		if iter_36_1.stage == arg_36_0._curStage and iter_36_1.minTypeId == 1 and iter_36_1.chapter == 0 and not arg_36_0:isTaskUnlock(TaskEnum.TaskType.Novice, iter_36_1.id) then
			table.insert(var_36_0, iter_36_1.id)
		end
	end

	return var_36_0
end

function var_0_0.getAllRewardUnreceivedTasks(arg_37_0, arg_37_1)
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in pairs(arg_37_0._taskMODict[arg_37_1]) do
		if iter_37_1:isClaimable() then
			table.insert(var_37_0, iter_37_1)
		end
	end

	return var_37_0
end

function var_0_0.isTypeAllTaskFinished(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0:getAllUnlockTasks(arg_38_1)

	for iter_38_0, iter_38_1 in pairs(var_38_0) do
		if not arg_38_0:isTaskFinish(arg_38_1, iter_38_1.id) then
			return false
		end
	end

	return true
end

function var_0_0.isAllRewardGet(arg_39_0, arg_39_1)
	local var_39_0 = TaskConfig.instance:getTaskActivityBonusConfig(arg_39_1)
	local var_39_1 = var_0_0.instance:getTaskActivityMO(arg_39_1)
	local var_39_2 = 0

	for iter_39_0 = 1, #var_39_0 do
		var_39_2 = var_39_2 + var_39_0[iter_39_0].needActivity
	end

	return var_39_2 <= var_39_1.value
end

function var_0_0.isFinishAllNoviceTask(arg_40_0)
	local var_40_0 = arg_40_0:getMaxStage(TaskEnum.TaskType.Novice)
	local var_40_1 = arg_40_0:getNoviceTaskCurStage()
	local var_40_2 = arg_40_0:getCurStageMaxActDot()
	local var_40_3 = arg_40_0:getNoviceTaskMaxUnlockStage()
	local var_40_4 = arg_40_0:getCurStageActDotGetNum()
	local var_40_5 = var_40_1 < var_40_3 and true or var_40_2 <= var_40_4

	return var_40_1 == var_40_0 and var_40_5 and arg_40_0:isTypeAllTaskFinished(TaskEnum.TaskType.Novice)
end

function var_0_0.getTaskTypeExpireTime(arg_41_0, arg_41_1)
	local var_41_0 = 0
	local var_41_1 = arg_41_0:getAllUnlockTasks(arg_41_1)

	for iter_41_0, iter_41_1 in pairs(var_41_1) do
		if iter_41_1.expiryTime > 0 then
			var_41_0 = iter_41_1.expiryTime

			break
		end
	end

	return var_41_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
