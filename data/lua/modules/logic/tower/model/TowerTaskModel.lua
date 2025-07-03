module("modules.logic.tower.model.TowerTaskModel", package.seeall)

local var_0_0 = class("TowerTaskModel", MixScrollModel)

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

	arg_2_0.limitTimeTaskMap = {}
	arg_2_0.limitTimeTaskList = {}
	arg_2_0.bossTaskMap = {}
	arg_2_0.bossTaskList = {}
	arg_2_0.actTaskMap = {}
	arg_2_0.actTaskList = {}
	arg_2_0.reddotShowMap = {}
	arg_2_0._itemStartAnimTime = nil

	arg_2_0:cleanData()
end

function var_0_0.cleanData(arg_3_0)
	arg_3_0.curSelectToweId = 1
	arg_3_0.curSelectTowerType = TowerEnum.TowerType.Limited
end

function var_0_0.setTaskInfoList(arg_4_0, arg_4_1)
	local var_4_0 = {}

	arg_4_0.limitTimeTaskMap = {}
	arg_4_0.bossTaskMap = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		if not iter_4_1.config then
			local var_4_1 = TowerConfig.instance:getTowerTaskConfig(iter_4_1.id)

			if not var_4_1 then
				logError("爬塔任务配置表id不存在,请检查: " .. tostring(iter_4_1.id))
			end

			iter_4_1:init(iter_4_1, var_4_1)
		end

		table.insert(var_4_0, iter_4_1)
	end

	arg_4_0.tempTaskModel:setList(var_4_0)

	for iter_4_2, iter_4_3 in ipairs(arg_4_0.tempTaskModel:getList()) do
		arg_4_0:initTaskMap(iter_4_3)
	end

	arg_4_0:initTaskList()
	arg_4_0:sortList()
	arg_4_0:checkRedDot()
end

function var_0_0.initTaskMap(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.config.taskGroupId
	local var_5_1 = TowerConfig.instance:getTowerBossTimeCoByTaskGroupId(var_5_0)
	local var_5_2 = TowerConfig.instance:getTowerLimitedCoByTaskGroupId(var_5_0)

	if var_5_1 and arg_5_1.config.activityId == 0 then
		if not arg_5_0.bossTaskMap[var_5_1.towerId] then
			local var_5_3 = {}

			arg_5_0.bossTaskMap[var_5_1.towerId] = var_5_3
		end

		arg_5_0.bossTaskMap[var_5_1.towerId][arg_5_1.id] = arg_5_1
	elseif var_5_2 then
		arg_5_0.limitTimeTaskMap[arg_5_1.id] = arg_5_1
	elseif var_5_0 == 0 and arg_5_1.config.activityId > 0 and arg_5_1.config.isKeyReward ~= 1 then
		arg_5_0.actTaskMap[arg_5_1.id] = arg_5_1
	end
end

function var_0_0.initTaskList(arg_6_0)
	arg_6_0.limitTimeTaskList = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0.limitTimeTaskMap) do
		table.insert(arg_6_0.limitTimeTaskList, iter_6_1)
	end

	arg_6_0.bossTaskList = {}

	for iter_6_2, iter_6_3 in pairs(arg_6_0.bossTaskMap) do
		arg_6_0.bossTaskList[iter_6_2] = {}

		for iter_6_4, iter_6_5 in pairs(iter_6_3) do
			table.insert(arg_6_0.bossTaskList[iter_6_2], iter_6_5)
		end
	end

	arg_6_0.actTaskList = {}

	for iter_6_6, iter_6_7 in pairs(arg_6_0.actTaskMap) do
		table.insert(arg_6_0.actTaskList, iter_6_7)
	end
end

function var_0_0.sortList(arg_7_0)
	if #arg_7_0.limitTimeTaskList > 0 then
		table.sort(arg_7_0.limitTimeTaskList, var_0_0.limitTimeSortFunc)
	end

	if tabletool.len(arg_7_0.bossTaskList) > 0 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0.bossTaskList) do
			table.sort(iter_7_1, var_0_0.bossSortFunc)
		end
	end

	if #arg_7_0.actTaskList > 0 then
		table.sort(arg_7_0.actTaskList, var_0_0.actSortFunc)
	end
end

function var_0_0.bossSortFunc(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.finishCount >= arg_8_0.config.maxProgress and 3 or arg_8_0.hasFinished and 1 or 2
	local var_8_1 = arg_8_1.finishCount >= arg_8_1.config.maxProgress and 3 or arg_8_1.hasFinished and 1 or 2

	if var_8_0 ~= var_8_1 then
		return var_8_0 < var_8_1
	else
		return arg_8_0.config.id < arg_8_1.config.id
	end
end

function var_0_0.limitTimeSortFunc(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.finishCount >= 1 and arg_9_0.progress >= arg_9_0.config.maxProgress and 3 or arg_9_0.hasFinished and 1 or 2
	local var_9_1 = arg_9_1.finishCount >= 1 and arg_9_1.progress >= arg_9_1.config.maxProgress and 3 or arg_9_1.hasFinished and 1 or 2

	if var_9_0 ~= var_9_1 then
		return var_9_0 < var_9_1
	else
		return arg_9_0.config.id < arg_9_1.config.id
	end
end

function var_0_0.actSortFunc(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.finishCount >= arg_10_0.config.maxProgress and 3 or arg_10_0.hasFinished and 1 or 2
	local var_10_1 = arg_10_1.finishCount >= arg_10_1.config.maxProgress and 3 or arg_10_1.hasFinished and 1 or 2

	if var_10_0 ~= var_10_1 then
		return var_10_0 < var_10_1
	else
		return arg_10_0.config.id < arg_10_1.config.id
	end
end

function var_0_0.updateTaskInfo(arg_11_0, arg_11_1)
	local var_11_0 = false

	if GameUtil.getTabLen(arg_11_0.tempTaskModel:getList()) == 0 then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if iter_11_1.type == TaskEnum.TaskType.Tower then
			local var_11_1 = arg_11_0.tempTaskModel:getById(iter_11_1.id)

			if not var_11_1 then
				local var_11_2 = TowerConfig.instance:getTowerTaskConfig(iter_11_1.id)

				if var_11_2 then
					var_11_1 = TaskMo.New()

					var_11_1:init(iter_11_1, var_11_2)
					arg_11_0.tempTaskModel:addAtLast(var_11_1)
					arg_11_0:initTaskMap(var_11_1)
				else
					logError("Season123TaskCo by id is not exit: " .. tostring(iter_11_1.id))
				end
			else
				var_11_1:update(iter_11_1)
			end

			arg_11_0:initTaskMap(var_11_1)

			var_11_0 = true
		end
	end

	if var_11_0 then
		arg_11_0:initTaskList()
		arg_11_0:sortList()
		arg_11_0:checkRedDot()
	end

	return var_11_0
end

function var_0_0.checkRedDot(arg_12_0)
	if tabletool.len(arg_12_0.limitTimeTaskList) > 0 then
		local var_12_0 = arg_12_0:getTaskItemCanGetCount(arg_12_0.limitTimeTaskList)

		arg_12_0.reddotShowMap[TowerEnum.TowerType.Limited] = var_12_0 > 0
	end

	if tabletool.len(arg_12_0.bossTaskList) > 0 then
		arg_12_0.reddotShowMap[TowerEnum.TowerType.Boss] = {}

		for iter_12_0, iter_12_1 in pairs(arg_12_0.bossTaskList) do
			local var_12_1 = arg_12_0:getTaskItemCanGetCount(iter_12_1)

			arg_12_0.reddotShowMap[TowerEnum.TowerType.Boss][iter_12_0] = var_12_1 > 0
		end
	end

	if tabletool.len(arg_12_0.actTaskList) > 0 then
		local var_12_2 = arg_12_0:getTaskItemCanGetCount(arg_12_0.actTaskList)
		local var_12_3 = arg_12_0:getActRewardTask()

		if var_12_3 and var_12_3.progress >= var_12_3.config.maxProgress and var_12_3.finishCount == 0 then
			var_12_2 = var_12_2 + 1
		end

		arg_12_0.reddotShowMap[TowerEnum.ActTaskType] = var_12_2 > 0
	end
end

function var_0_0.canShowReddot(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == TowerEnum.TowerType.Limited then
		return arg_13_0.reddotShowMap[arg_13_1]
	elseif arg_13_1 == TowerEnum.ActTaskType then
		return arg_13_0.reddotShowMap[arg_13_1]
	else
		return arg_13_0.reddotShowMap[arg_13_1][arg_13_2]
	end
end

function var_0_0.setCurSelectTowerTypeAndId(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.curSelectTowerType = arg_14_1
	arg_14_0.curSelectToweId = arg_14_2
end

function var_0_0.refreshList(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getCurTaskList(arg_15_1) or {}
	local var_15_1 = tabletool.copy(var_15_0)

	if arg_15_0:getTaskItemCanGetCount(var_15_1) > 1 then
		table.insert(var_15_1, 1, {
			id = 0,
			canGetAll = true
		})
	end

	arg_15_0:setList(var_15_1)
	arg_15_0:checkRedDot()
	TowerController.instance:dispatchEvent(TowerEvent.TowerRefreshTask)
end

function var_0_0.getAllCanGetList(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = arg_16_0:getCurTaskList() or {}

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		if iter_16_1.config and iter_16_1.progress >= iter_16_1.config.maxProgress and iter_16_1.finishCount == 0 then
			table.insert(var_16_0, iter_16_1.id)
		end
	end

	return var_16_0
end

function var_0_0.getCurTaskList(arg_17_0, arg_17_1)
	local var_17_0 = {}

	arg_17_0.curSelectTowerType = arg_17_1 or arg_17_0.curSelectTowerType

	if arg_17_0.curSelectTowerType == TowerEnum.TowerType.Limited then
		var_17_0 = arg_17_0.limitTimeTaskList
	elseif arg_17_0.curSelectTowerType == TowerEnum.TowerType.Boss then
		var_17_0 = arg_17_0.bossTaskList[arg_17_0.curSelectToweId]
	elseif arg_17_0.curSelectTowerType == TowerEnum.ActTaskType then
		var_17_0 = arg_17_0.actTaskList
	end

	return var_17_0
end

function var_0_0.getTaskItemRewardCount(arg_18_0, arg_18_1)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		if iter_18_1.progress >= iter_18_1.config.maxProgress then
			var_18_0 = var_18_0 + 1
		end
	end

	return var_18_0
end

function var_0_0.getTaskItemCanGetCount(arg_19_0, arg_19_1)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in pairs(arg_19_1) do
		if iter_19_1.progress >= iter_19_1.config.maxProgress and iter_19_1.finishCount == 0 then
			var_19_0 = var_19_0 + 1
		end
	end

	return var_19_0
end

function var_0_0.getTaskItemFinishedCount(arg_20_0, arg_20_1)
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		if arg_20_0:isTaskFinished(iter_20_1) then
			var_20_0 = var_20_0 + 1
		end
	end

	return var_20_0
end

function var_0_0.isTaskFinished(arg_21_0, arg_21_1)
	return arg_21_1.finishCount > 0 and arg_21_1.progress >= arg_21_1.config.maxProgress
end

function var_0_0.isTaskFinishedById(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.tempTaskModel:getById(arg_22_1)

	return var_22_0 and var_22_0.progress >= var_22_0.config.maxProgress
end

function var_0_0.getDelayPlayTime(arg_23_0, arg_23_1)
	if arg_23_1 == nil then
		return -1
	end

	local var_23_0 = Time.time

	if arg_23_0._itemStartAnimTime == nil then
		arg_23_0._itemStartAnimTime = var_23_0 + arg_23_0.OpenAnimStartTime
	end

	local var_23_1 = arg_23_0:getIndex(arg_23_1)

	if not var_23_1 or var_23_1 > arg_23_0.AnimRowCount * arg_23_0.ColumnCount then
		return -1
	end

	local var_23_2 = math.floor((var_23_1 - 1) / arg_23_0.ColumnCount) * arg_23_0.OpenAnimTime + arg_23_0.OpenAnimStartTime

	if var_23_0 - arg_23_0._itemStartAnimTime - var_23_2 > 0.1 then
		return -1
	else
		return var_23_2
	end
end

function var_0_0.getTotalTaskRewardCount(arg_24_0)
	local var_24_0 = arg_24_0.tempTaskModel:getList()
	local var_24_1 = #var_24_0

	return arg_24_0:getTaskItemRewardCount(var_24_0), var_24_1
end

function var_0_0.checkHasBossTask(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.bossTaskMap) do
		if tabletool.len(iter_25_1) > 0 then
			return true
		end
	end

	return false
end

function var_0_0.getActRewardTask(arg_26_0)
	local var_26_0 = arg_26_0.tempTaskModel:getList()

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		if iter_26_1.config.isKeyReward == 1 and iter_26_1.config.activityId > 0 then
			return iter_26_1
		end
	end
end

function var_0_0.getBossTaskList(arg_27_0, arg_27_1)
	return arg_27_0.bossTaskList[arg_27_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
