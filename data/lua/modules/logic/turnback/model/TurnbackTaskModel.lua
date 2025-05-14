module("modules.logic.turnback.model.TurnbackTaskModel", package.seeall)

local var_0_0 = class("TurnbackTaskModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.tempTaskModel = BaseModel.New()
	arg_1_0.tempOnlineTaskModel = BaseModel.New()
	arg_1_0.taskLoopTypeDotDict = {}
	arg_1_0.taskSearchList = {}
	arg_1_0.taskSearchDict = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.tempTaskModel:clear()

	arg_2_0.taskLoopTypeDotDict = {}
	arg_2_0.taskSearchList = {}
	arg_2_0.taskSearchDict = {}
end

function var_0_0.setTaskInfoList(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1 = {}

	arg_3_0.taskSearchList = {}

	local var_3_2 = TurnbackModel.instance:isNewType()

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_3 = TurnbackConfig.instance:getTurnbackTaskCo(iter_3_1.id)

		if var_3_3 then
			local var_3_4 = TaskMo.New()

			var_3_4:init(iter_3_1, var_3_3)

			if var_3_2 then
				if var_3_3.type ~= TurnbackEnum.TaskEnum.Online then
					table.insert(var_3_0, var_3_4)
				else
					table.insert(var_3_1, var_3_4)
				end

				if var_3_3.listenerType == "TodayOnlineSeconds" then
					table.insert(arg_3_0.taskSearchList, var_3_4)

					arg_3_0.taskSearchDict[var_3_4.id] = var_3_4
				end
			else
				table.insert(var_3_0, var_3_4)
			end
		end
	end

	table.sort(arg_3_0.taskSearchList, SortUtil.keyLower("id"))
	arg_3_0.tempTaskModel:setList(var_3_0)
	arg_3_0.tempOnlineTaskModel:setList(var_3_1)
	arg_3_0:sortList()
	arg_3_0:checkTaskLoopTypeDotState()
end

function var_0_0.sortList(arg_4_0)
	arg_4_0.tempTaskModel:sort(function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_0.finishCount > 0 and 3 or arg_5_0.progress >= arg_5_0.config.maxProgress and 1 or 2
		local var_5_1 = arg_5_1.finishCount > 0 and 3 or arg_5_1.progress >= arg_5_1.config.maxProgress and 1 or 2

		if var_5_0 == var_5_1 then
			if arg_5_0.config.sortId == arg_5_1.config.sortId then
				return arg_5_0.id < arg_5_1.id
			else
				return arg_5_0.config.sortId < arg_5_1.config.sortId
			end
		else
			return var_5_0 < var_5_1
		end
	end)
end

function var_0_0.updateInfo(arg_6_0, arg_6_1)
	local var_6_0 = false

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		if iter_6_1.type == TaskEnum.TaskType.Turnback then
			local var_6_1 = arg_6_0.tempTaskModel:getById(iter_6_1.id)

			if not var_6_1 then
				local var_6_2 = TurnbackConfig.instance:getTurnbackTaskCo(iter_6_1.id)

				if var_6_2 then
					var_6_1 = TaskMo.New()

					var_6_1:init(iter_6_1, var_6_2)
					arg_6_0.tempTaskModel:addAtLast(var_6_1)
				else
					logError("TurnbackTaskConfig by id is not exit: " .. tostring(iter_6_1.id))
				end
			else
				var_6_1:update(iter_6_1)
			end

			var_6_0 = true
		end
	end

	if var_6_0 then
		arg_6_0:sortList()
		arg_6_0:checkTaskLoopTypeDotState()
	end

	return var_6_0
end

function var_0_0.checkTaskLoopTypeDotState(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.taskLoopTypeDotDict) do
		arg_7_0.taskLoopTypeDotDict[iter_7_0] = false
	end

	for iter_7_2, iter_7_3 in ipairs(arg_7_0.tempTaskModel:getList()) do
		if iter_7_3.progress >= iter_7_3.config.maxProgress and iter_7_3.finishCount == 0 then
			arg_7_0.taskLoopTypeDotDict[iter_7_3.config.loopType] = true
		end
	end
end

function var_0_0.getTaskLoopTypeDotState(arg_8_0)
	return arg_8_0.taskLoopTypeDotDict
end

function var_0_0.refreshListNewTaskList(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.tempTaskModel:getList()) do
		if iter_9_1.config.turnbackId == TurnbackModel.instance:getCurTurnbackId() then
			local var_9_1 = TurnbackModel.instance:getCurTurnbackMo()

			if ServerTime.now() >= var_9_1.startTime + (iter_9_1.config.unlockDay - 1) * TimeUtil.OneDaySecond then
				table.insert(var_9_0, iter_9_1)
			end
		end
	end

	local var_9_2 = arg_9_0:checkAndRemoveTask(var_9_0)

	arg_9_0:setList(var_9_2)
end

function var_0_0.refreshList(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.tempTaskModel:getList()) do
		if iter_10_1.config.loopType == arg_10_1 and iter_10_1.config.turnbackId == TurnbackModel.instance:getCurTurnbackId() then
			arg_10_0.curTaskLoopType = arg_10_1

			table.insert(var_10_0, iter_10_1)
		end
	end

	local var_10_1 = arg_10_0:checkAndRemovePreposeTask(var_10_0)

	arg_10_0:setList(var_10_1)
	arg_10_0:checkTaskLoopTypeDotState()
end

function var_0_0.getCurTaskLoopType(arg_11_0)
	return arg_11_0.curTaskLoopType or TurnbackEnum.TaskLoopType.Day
end

function var_0_0.haveTaskItemReward(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.tempTaskModel:getList()) do
		if iter_12_1.progress >= iter_12_1.config.maxProgress and iter_12_1.finishCount == 0 then
			return true
		end
	end

	return false
end

function var_0_0.isTaskFinished(arg_13_0, arg_13_1)
	return arg_13_1.finishCount > 0 and arg_13_1.progress >= arg_13_1.config.maxProgress
end

function var_0_0.getSearchTaskMoList(arg_14_0)
	return arg_14_0.taskSearchList
end

function var_0_0.getSearchTaskMoById(arg_15_0, arg_15_1)
	return arg_15_0.taskSearchDict[arg_15_1]
end

function var_0_0.checkAndRemovePreposeTask(arg_16_0, arg_16_1)
	local var_16_0 = tabletool.copy(arg_16_1)

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_1 = string.split(iter_16_1.config.prepose, "#")

		for iter_16_2, iter_16_3 in ipairs(var_16_1) do
			local var_16_2 = arg_16_0.tempTaskModel:getById(tonumber(iter_16_3))

			if var_16_2 and not arg_16_0:isTaskFinished(var_16_2) then
				table.remove(var_16_0, iter_16_0)

				break
			end
		end
	end

	return var_16_0
end

function var_0_0.checkAndRemoveTask(arg_17_0, arg_17_1)
	local var_17_0 = tabletool.copy(arg_17_1)
	local var_17_1 = #arg_17_1

	for iter_17_0 = 1, var_17_1 do
		local var_17_2 = arg_17_1[iter_17_0]
		local var_17_3 = string.split(var_17_2.config.prepose, "#")

		for iter_17_1, iter_17_2 in ipairs(var_17_3) do
			local var_17_4 = arg_17_0.tempTaskModel:getById(tonumber(iter_17_2))

			if var_17_4 and not arg_17_0:isTaskFinished(var_17_4) then
				tabletool.removeValue(var_17_0, var_17_2)
			end
		end

		if var_17_2.config.isOnlineTimeTask then
			tabletool.removeValue(var_17_0, var_17_2)
		end
	end

	return var_17_0
end

function var_0_0.checkOnlineTaskAllFinish(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.taskSearchList) do
		if not (iter_18_1.finishCount > 0) then
			return false
		end
	end

	return true
end

var_0_0.instance = var_0_0.New()

return var_0_0
