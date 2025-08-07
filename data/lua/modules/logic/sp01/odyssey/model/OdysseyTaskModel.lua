module("modules.logic.sp01.odyssey.model.OdysseyTaskModel", package.seeall)

local var_0_0 = class("OdysseyTaskModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.tempTaskModel = BaseModel.New()
	arg_1_0.ColumnCount = 1
	arg_1_0.OpenAnimTime = 0.06
	arg_1_0.OpenAnimStartTime = 0
	arg_1_0.AnimRowCount = 6

	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.tempTaskModel:clear()
	var_0_0.super.clear(arg_2_0)

	arg_2_0._itemStartAnimTime = nil
	arg_2_0.reddotShowMap = {}
	arg_2_0.levelRewardTaskMap = {}
	arg_2_0.normalTaskMap = {}
	arg_2_0.levelRewardTaskList = {}
	arg_2_0.normalTaskList = {}
	arg_2_0.bigRewardTaskMo = nil
end

function var_0_0.setTaskInfoList(arg_3_0)
	local var_3_0 = {}

	arg_3_0.levelRewardTaskMap = {}
	arg_3_0.normalTaskMap = {}

	local var_3_1 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Odyssey)

	for iter_3_0, iter_3_1 in pairs(var_3_1) do
		if not iter_3_1.config then
			local var_3_2 = OdysseyConfig.instance:getTaskConfig(iter_3_1.id)

			if not var_3_2 then
				logError("奥德赛任务配置表id不存在,请检查: " .. tostring(iter_3_1.id))
			end

			iter_3_1:init(iter_3_1, var_3_2)
		end

		table.insert(var_3_0, iter_3_1)
	end

	arg_3_0.tempTaskModel:setList(var_3_0)

	for iter_3_2, iter_3_3 in ipairs(arg_3_0.tempTaskModel:getList()) do
		arg_3_0:initTaskMap(iter_3_3)
	end

	arg_3_0:initTaskList()
	arg_3_0:sortList()
	arg_3_0:checkRedDot()
end

function var_0_0.initTaskMap(arg_4_0, arg_4_1)
	if arg_4_1.config.taskGroupId == OdysseyEnum.TaskGroupType.LevelReward then
		arg_4_0.levelRewardTaskMap[arg_4_1.id] = arg_4_1
	elseif OdysseyEnum.NormalTaskGroupType[arg_4_1.config.taskGroupId] then
		if not arg_4_0.normalTaskMap[arg_4_1.config.taskGroupId] then
			local var_4_0 = {}

			arg_4_0.normalTaskMap[arg_4_1.config.taskGroupId] = var_4_0
		end

		arg_4_0.normalTaskMap[arg_4_1.config.taskGroupId][arg_4_1.id] = arg_4_1
	elseif arg_4_1.config.taskGroupId == 0 and arg_4_1.config.isKeyReward == 1 then
		arg_4_0.bigRewardTaskMo = arg_4_1
	end
end

function var_0_0.initTaskList(arg_5_0)
	arg_5_0.levelRewardTaskList = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0.levelRewardTaskMap) do
		table.insert(arg_5_0.levelRewardTaskList, iter_5_1)
	end

	arg_5_0.normalTaskList = {}

	for iter_5_2, iter_5_3 in pairs(arg_5_0.normalTaskMap) do
		arg_5_0.normalTaskList[iter_5_2] = {}

		for iter_5_4, iter_5_5 in pairs(iter_5_3) do
			table.insert(arg_5_0.normalTaskList[iter_5_2], iter_5_5)
		end
	end
end

function var_0_0.sortList(arg_6_0)
	if #arg_6_0.levelRewardTaskList > 0 then
		table.sort(arg_6_0.levelRewardTaskList, var_0_0.levelRewardTaskSortFunc)
	end

	if tabletool.len(arg_6_0.normalTaskList) > 0 then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.normalTaskList) do
			table.sort(iter_6_1, var_0_0.taskSortFunc)
		end
	end
end

function var_0_0.levelRewardTaskSortFunc(arg_7_0, arg_7_1)
	return arg_7_0.config.maxProgress < arg_7_1.config.maxProgress
end

function var_0_0.taskSortFunc(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.finishCount > 0 and arg_8_0.progress >= arg_8_0.config.maxProgress and 3 or arg_8_0.hasFinished and 1 or 2
	local var_8_1 = arg_8_1.finishCount > 0 and arg_8_1.progress >= arg_8_1.config.maxProgress and 3 or arg_8_1.hasFinished and 1 or 2

	if var_8_0 ~= var_8_1 then
		return var_8_0 < var_8_1
	else
		return arg_8_0.config.id < arg_8_1.config.id
	end
end

function var_0_0.updateTaskInfo(arg_9_0, arg_9_1)
	local var_9_0 = false

	if GameUtil.getTabLen(arg_9_0.tempTaskModel:getList()) == 0 then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if iter_9_1.type == TaskEnum.TaskType.Odyssey then
			local var_9_1 = arg_9_0.tempTaskModel:getById(iter_9_1.id)

			if not var_9_1 then
				local var_9_2 = OdysseyConfig.instance:getTaskConfig(iter_9_1.id)

				if var_9_2 then
					var_9_1 = TaskMo.New()

					var_9_1:init(iter_9_1, var_9_2)
					arg_9_0.tempTaskModel:addAtLast(var_9_1)
					arg_9_0:initTaskMap(var_9_1)
				else
					logError("奥德赛任务配置表id不存在,请检查: " .. tostring(iter_9_1.id))
				end
			else
				var_9_1:update(iter_9_1)
			end

			arg_9_0:initTaskMap(var_9_1)

			var_9_0 = true
		end
	end

	if var_9_0 then
		arg_9_0:initTaskList()
		arg_9_0:sortList()
		arg_9_0:checkRedDot()
	end

	return var_9_0
end

function var_0_0.checkRedDot(arg_10_0)
	if tabletool.len(arg_10_0.levelRewardTaskList) > 0 then
		local var_10_0 = arg_10_0:getTaskItemCanGetCount(arg_10_0.levelRewardTaskList)

		arg_10_0.reddotShowMap[OdysseyEnum.TaskType.LevelReward] = var_10_0 > 0
	end

	if tabletool.len(arg_10_0.normalTaskList) > 0 then
		arg_10_0.reddotShowMap[OdysseyEnum.TaskType.NormalTask] = {}

		for iter_10_0, iter_10_1 in pairs(arg_10_0.normalTaskList) do
			local var_10_1 = arg_10_0:getTaskItemCanGetCount(iter_10_1)

			arg_10_0.reddotShowMap[OdysseyEnum.TaskType.NormalTask][iter_10_0] = var_10_1 > 0
		end
	end
end

function var_0_0.canShowReddot(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == OdysseyEnum.TaskType.LevelReward then
		return arg_11_0.reddotShowMap[arg_11_1]
	else
		return arg_11_0.reddotShowMap[arg_11_1][arg_11_2]
	end
end

function var_0_0.setCurSelectTaskTypeAndGroupId(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.curTaskType = arg_12_1
	arg_12_0.curSelectGroupTypeId = arg_12_2
end

function var_0_0.getCurSelectTaskTypeAndGroupId(arg_13_0)
	return arg_13_0.curTaskType, arg_13_0.curSelectGroupTypeId
end

function var_0_0.refreshList(arg_14_0)
	local var_14_0 = arg_14_0:getCurTaskList(arg_14_0.curTaskType) or {}

	if not var_14_0 or #var_14_0 == 0 then
		return
	end

	local var_14_1 = tabletool.copy(var_14_0)

	if arg_14_0.curTaskType == OdysseyEnum.TaskType.NormalTask and arg_14_0:getTaskItemCanGetCount(var_14_1) > 1 then
		table.insert(var_14_1, 1, {
			id = 0,
			canGetAll = true
		})
	end

	arg_14_0:setList(var_14_1)
	arg_14_0:checkRedDot()
	OdysseyController.instance:dispatchEvent(OdysseyEvent.OdysseyTaskRefresh)
end

function var_0_0.getCurTaskList(arg_15_0, arg_15_1)
	local var_15_0 = {}

	if arg_15_1 == OdysseyEnum.TaskType.LevelReward then
		var_15_0 = arg_15_0.levelRewardTaskList
	elseif arg_15_1 == OdysseyEnum.TaskType.NormalTask then
		var_15_0 = arg_15_0.normalTaskList[arg_15_0.curSelectGroupTypeId]
	end

	return var_15_0
end

function var_0_0.getTaskItemCanGetCount(arg_16_0, arg_16_1)
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		if iter_16_1.progress >= iter_16_1.config.maxProgress and iter_16_1.finishCount == 0 then
			var_16_0 = var_16_0 + 1
		end
	end

	return var_16_0
end

function var_0_0.isTaskHasGet(arg_17_0, arg_17_1)
	return arg_17_1.finishCount > 0 and arg_17_1.progress >= arg_17_1.config.maxProgress
end

function var_0_0.isTaskCanGet(arg_18_0, arg_18_1)
	return arg_18_1.hasFinished
end

function var_0_0.getAllCanGetMoList(arg_19_0, arg_19_1)
	local var_19_0 = {}
	local var_19_1 = arg_19_1 or arg_19_0.curTaskType
	local var_19_2 = arg_19_0:getCurTaskList(var_19_1)

	for iter_19_0, iter_19_1 in ipairs(var_19_2) do
		if arg_19_0:isTaskCanGet(iter_19_1) then
			table.insert(var_19_0, iter_19_1)
		end
	end

	return var_19_0
end

function var_0_0.getAllCanGetIdList(arg_20_0, arg_20_1)
	local var_20_0 = {}
	local var_20_1 = arg_20_1 or arg_20_0.curTaskType
	local var_20_2 = arg_20_0:getAllCanGetMoList(var_20_1)

	for iter_20_0, iter_20_1 in ipairs(var_20_2) do
		table.insert(var_20_0, iter_20_1.id)
	end

	return var_20_0
end

function var_0_0.getBigRewardTaskMo(arg_21_0)
	return arg_21_0.bigRewardTaskMo
end

function var_0_0.checkHasLevelReawrdTaskCanGet(arg_22_0)
	return arg_22_0:canShowReddot(OdysseyEnum.TaskType.LevelReward)
end

function var_0_0.checkHasNormalTaskCanGet(arg_23_0)
	local var_23_0 = arg_23_0.reddotShowMap[OdysseyEnum.TaskType.NormalTask] or {}
	local var_23_1 = false

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		if iter_23_1 then
			var_23_1 = true

			break
		end
	end

	local var_23_2 = arg_23_0.bigRewardTaskMo and arg_23_0:isTaskCanGet(arg_23_0.bigRewardTaskMo)

	return var_23_1 or var_23_2
end

function var_0_0.getNormalTaskListByGroupType(arg_24_0, arg_24_1)
	return arg_24_0.normalTaskList[arg_24_1]
end

function var_0_0.getTaskItemRewardCount(arg_25_0, arg_25_1)
	local var_25_0 = 0

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		if iter_25_1.progress >= iter_25_1.config.maxProgress then
			var_25_0 = var_25_0 + 1
		end
	end

	return var_25_0
end

function var_0_0.getDelayPlayTime(arg_26_0, arg_26_1)
	if arg_26_1 == nil then
		return -1
	end

	local var_26_0 = Time.time

	if arg_26_0._itemStartAnimTime == nil then
		arg_26_0._itemStartAnimTime = var_26_0 + arg_26_0.OpenAnimStartTime
	end

	local var_26_1 = arg_26_0:getIndex(arg_26_1)

	if not var_26_1 or var_26_1 > arg_26_0.AnimRowCount * arg_26_0.ColumnCount then
		return -1
	end

	local var_26_2 = math.floor((var_26_1 - 1) / arg_26_0.ColumnCount) * arg_26_0.OpenAnimTime + arg_26_0.OpenAnimStartTime

	if var_26_0 - arg_26_0._itemStartAnimTime - var_26_2 > 0.1 then
		return -1
	else
		return var_26_2
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
