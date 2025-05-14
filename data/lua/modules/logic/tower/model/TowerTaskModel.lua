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

	if var_5_1 then
		if not arg_5_0.bossTaskMap[var_5_1.towerId] then
			local var_5_3 = {}

			arg_5_0.bossTaskMap[var_5_1.towerId] = var_5_3
		end

		arg_5_0.bossTaskMap[var_5_1.towerId][arg_5_1.id] = arg_5_1
	elseif var_5_2 then
		arg_5_0.limitTimeTaskMap[arg_5_1.id] = arg_5_1
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

function var_0_0.updateTaskInfo(arg_10_0, arg_10_1)
	local var_10_0 = false

	if GameUtil.getTabLen(arg_10_0.tempTaskModel:getList()) == 0 then
		return
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		if iter_10_1.type == TaskEnum.TaskType.Tower then
			local var_10_1 = arg_10_0.tempTaskModel:getById(iter_10_1.id)

			if not var_10_1 then
				local var_10_2 = TowerConfig.instance:getTowerTaskConfig(iter_10_1.id)

				if var_10_2 then
					var_10_1 = TaskMo.New()

					var_10_1:init(iter_10_1, var_10_2)
					arg_10_0.tempTaskModel:addAtLast(var_10_1)
					arg_10_0:initTaskMap(var_10_1)
				else
					logError("Season123TaskCo by id is not exit: " .. tostring(iter_10_1.id))
				end
			else
				var_10_1:update(iter_10_1)
			end

			arg_10_0:initTaskMap(var_10_1)

			var_10_0 = true
		end
	end

	if var_10_0 then
		arg_10_0:initTaskList()
		arg_10_0:sortList()
		arg_10_0:checkRedDot()
	end

	return var_10_0
end

function var_0_0.checkRedDot(arg_11_0)
	if tabletool.len(arg_11_0.limitTimeTaskList) > 0 then
		local var_11_0 = arg_11_0:getTaskItemCanGetCount(arg_11_0.limitTimeTaskList)

		arg_11_0.reddotShowMap[TowerEnum.TowerType.Limited] = var_11_0 > 0
	end

	if tabletool.len(arg_11_0.bossTaskList) > 0 then
		arg_11_0.reddotShowMap[TowerEnum.TowerType.Boss] = {}

		for iter_11_0, iter_11_1 in pairs(arg_11_0.bossTaskList) do
			local var_11_1 = arg_11_0:getTaskItemCanGetCount(iter_11_1)

			arg_11_0.reddotShowMap[TowerEnum.TowerType.Boss][iter_11_0] = var_11_1 > 0
		end
	end
end

function var_0_0.canShowReddot(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == TowerEnum.TowerType.Limited then
		return arg_12_0.reddotShowMap[arg_12_1]
	else
		return arg_12_0.reddotShowMap[arg_12_1][arg_12_2]
	end
end

function var_0_0.setCurSelectTowerTypeAndId(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.curSelectTowerType = arg_13_1
	arg_13_0.curSelectToweId = arg_13_2
end

function var_0_0.refreshList(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getCurTaskList(arg_14_1) or {}
	local var_14_1 = tabletool.copy(var_14_0)

	if arg_14_0:getTaskItemCanGetCount(var_14_1) > 1 then
		table.insert(var_14_1, 1, {
			id = 0,
			canGetAll = true
		})
	end

	arg_14_0:setList(var_14_1)
	arg_14_0:checkRedDot()
	TowerController.instance:dispatchEvent(TowerEvent.TowerRefreshTask)
end

function var_0_0.getAllCanGetList(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = arg_15_0:getCurTaskList() or {}

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		if iter_15_1.config and iter_15_1.progress >= iter_15_1.config.maxProgress and iter_15_1.finishCount == 0 then
			table.insert(var_15_0, iter_15_1.id)
		end
	end

	return var_15_0
end

function var_0_0.getCurTaskList(arg_16_0, arg_16_1)
	local var_16_0 = {}

	arg_16_0.curSelectTowerType = arg_16_1 or arg_16_0.curSelectTowerType

	if arg_16_0.curSelectTowerType == TowerEnum.TowerType.Limited then
		var_16_0 = arg_16_0.limitTimeTaskList
	elseif arg_16_0.curSelectTowerType == TowerEnum.TowerType.Boss then
		var_16_0 = arg_16_0.bossTaskList[arg_16_0.curSelectToweId]
	end

	return var_16_0
end

function var_0_0.getTaskItemRewardCount(arg_17_0, arg_17_1)
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		if iter_17_1.progress >= iter_17_1.config.maxProgress then
			var_17_0 = var_17_0 + 1
		end
	end

	return var_17_0
end

function var_0_0.getTaskItemCanGetCount(arg_18_0, arg_18_1)
	local var_18_0 = 0

	for iter_18_0, iter_18_1 in pairs(arg_18_1) do
		if iter_18_1.progress >= iter_18_1.config.maxProgress and iter_18_1.finishCount == 0 then
			var_18_0 = var_18_0 + 1
		end
	end

	return var_18_0
end

function var_0_0.getTaskItemFinishedCount(arg_19_0, arg_19_1)
	local var_19_0 = 0

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		if arg_19_0:isTaskFinished(iter_19_1) then
			var_19_0 = var_19_0 + 1
		end
	end

	return var_19_0
end

function var_0_0.isTaskFinished(arg_20_0, arg_20_1)
	return arg_20_1.finishCount > 0 and arg_20_1.progress >= arg_20_1.config.maxProgress
end

function var_0_0.isTaskFinishedById(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.tempTaskModel:getById(arg_21_1)

	return var_21_0 and var_21_0.progress >= var_21_0.config.maxProgress
end

function var_0_0.getDelayPlayTime(arg_22_0, arg_22_1)
	if arg_22_1 == nil then
		return -1
	end

	local var_22_0 = Time.time

	if arg_22_0._itemStartAnimTime == nil then
		arg_22_0._itemStartAnimTime = var_22_0 + arg_22_0.OpenAnimStartTime
	end

	local var_22_1 = arg_22_0:getIndex(arg_22_1)

	if not var_22_1 or var_22_1 > arg_22_0.AnimRowCount * arg_22_0.ColumnCount then
		return -1
	end

	local var_22_2 = math.floor((var_22_1 - 1) / arg_22_0.ColumnCount) * arg_22_0.OpenAnimTime + arg_22_0.OpenAnimStartTime

	if var_22_0 - arg_22_0._itemStartAnimTime - var_22_2 > 0.1 then
		return -1
	else
		return var_22_2
	end
end

function var_0_0.getTotalTaskRewardCount(arg_23_0)
	local var_23_0 = arg_23_0.tempTaskModel:getList()
	local var_23_1 = #var_23_0

	return arg_23_0:getTaskItemRewardCount(var_23_0), var_23_1
end

function var_0_0.checkHasBossTask(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.bossTaskMap) do
		if tabletool.len(iter_24_1) > 0 then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
