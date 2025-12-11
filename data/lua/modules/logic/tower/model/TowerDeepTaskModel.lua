module("modules.logic.tower.model.TowerDeepTaskModel", package.seeall)

local var_0_0 = class("TowerDeepTaskModel", MixScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.tempTaskModel = BaseModel.New()
	arg_1_0.ColumnCount = 1
	arg_1_0.OpenAnimTime = 0.06
	arg_1_0.OpenAnimStartTime = 0
	arg_1_0.AnimRowCount = 6
	arg_1_0.succRwardTaskMo = nil

	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.tempTaskModel:clear()
	var_0_0.super.clear(arg_2_0)

	arg_2_0.taskList = {}
end

function var_0_0.setTaskInfoList(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.RewardTaskId)
	local var_3_2 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.TowerPermanentDeep) or {}

	for iter_3_0, iter_3_1 in pairs(var_3_2) do
		if not iter_3_1.config then
			local var_3_3 = TowerDeepConfig.instance:getTaskConfig(iter_3_1.id)

			if not var_3_3 then
				logError("爬塔深层任务配置表id不存在,请检查: " .. tostring(iter_3_1.id))
			end

			iter_3_1:init(iter_3_1, var_3_3)
		end

		if iter_3_1.id == var_3_1 then
			arg_3_0.succRwardTaskMo = iter_3_1
		else
			table.insert(var_3_0, iter_3_1)
		end
	end

	arg_3_0.tempTaskModel:setList(var_3_0)
	arg_3_0:sortList()
end

function var_0_0.updateTaskInfo(arg_4_0, arg_4_1)
	local var_4_0 = false

	if GameUtil.getTabLen(arg_4_0.tempTaskModel:getList()) == 0 then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if iter_4_1.type == TaskEnum.TaskType.TowerPermanentDeep then
			local var_4_1 = arg_4_0.tempTaskModel:getById(iter_4_1.id)

			if not var_4_1 then
				local var_4_2 = TowerDeepConfig.instance:getTaskConfig(iter_4_1.id)

				if var_4_2 then
					var_4_1 = TaskMo.New()

					var_4_1:init(iter_4_1, var_4_2)
					arg_4_0.tempTaskModel:addAtLast(var_4_1)
				else
					logError("爬塔深层任务配置表id不存在: " .. tostring(iter_4_1.id))
				end
			else
				var_4_1:update(iter_4_1)
			end

			var_4_0 = true
		end
	end

	if var_4_0 then
		arg_4_0:sortList()
	end

	return var_4_0
end

function var_0_0.sortList(arg_5_0)
	if tabletool.len(arg_5_0.tempTaskModel:getList()) > 0 then
		table.sort(arg_5_0.tempTaskModel:getList(), var_0_0.sortFunc)
	end
end

function var_0_0.sortFunc(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.progress >= arg_6_0.config.maxProgress and arg_6_0.finishCount > 0 and 3 or arg_6_0.hasFinished and 1 or 2
	local var_6_1 = arg_6_1.progress >= arg_6_1.config.maxProgress and arg_6_1.finishCount > 0 and 3 or arg_6_1.hasFinished and 1 or 2

	if var_6_0 ~= var_6_1 then
		return var_6_0 < var_6_1
	else
		return arg_6_0.config.id < arg_6_1.config.id
	end
end

function var_0_0.refreshList(arg_7_0)
	local var_7_0 = tabletool.copy(arg_7_0.tempTaskModel:getList())

	if arg_7_0:getTaskItemCanGetCount(var_7_0) > 1 then
		table.insert(var_7_0, 1, {
			id = 0,
			canGetAll = true
		})
	end

	arg_7_0:setList(var_7_0)
	TowerController.instance:dispatchEvent(TowerEvent.TowerDeepRefreshTask)
end

function var_0_0.getAllCanGetList(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.tempTaskModel:getList()) do
		if iter_8_1.config and arg_8_0:isTaskCanGet(iter_8_1) then
			table.insert(var_8_0, iter_8_1.id)
		end
	end

	return var_8_0
end

function var_0_0.getTaskItemCanGetCount(arg_9_0, arg_9_1)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		if arg_9_0:isTaskCanGet(iter_9_1) then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

function var_0_0.isTaskFinished(arg_10_0, arg_10_1)
	return arg_10_1.finishCount > 0 and arg_10_1.progress >= arg_10_1.config.maxProgress
end

function var_0_0.isTaskCanGet(arg_11_0, arg_11_1)
	return arg_11_1.progress >= arg_11_1.config.maxProgress and arg_11_1.finishCount == 0
end

function var_0_0.getSuccRewardTaskMo(arg_12_0)
	return arg_12_0.succRwardTaskMo
end

function var_0_0.isSuccRewardHasGet(arg_13_0)
	return arg_13_0.succRwardTaskMo and arg_13_0:isTaskFinished(arg_13_0.succRwardTaskMo)
end

function var_0_0.getDelayPlayTime(arg_14_0, arg_14_1)
	if arg_14_1 == nil then
		return -1
	end

	local var_14_0 = Time.time

	if arg_14_0._itemStartAnimTime == nil then
		arg_14_0._itemStartAnimTime = var_14_0 + arg_14_0.OpenAnimStartTime
	end

	local var_14_1 = arg_14_0:getIndex(arg_14_1)

	if not var_14_1 or var_14_1 > arg_14_0.AnimRowCount * arg_14_0.ColumnCount then
		return -1
	end

	local var_14_2 = math.floor((var_14_1 - 1) / arg_14_0.ColumnCount) * arg_14_0.OpenAnimTime + arg_14_0.OpenAnimStartTime

	if var_14_0 - arg_14_0._itemStartAnimTime - var_14_2 > 0.1 then
		return -1
	else
		return var_14_2
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
