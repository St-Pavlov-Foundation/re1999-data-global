module("modules.logic.task.model.TaskListModel", package.seeall)

local var_0_0 = class("TaskListModel", BaseModel)

function var_0_0.getTaskList(arg_1_0, arg_1_1)
	local var_1_0 = {}
	local var_1_1 = TaskModel.instance:getAllUnlockTasks(arg_1_1)

	if arg_1_1 == TaskEnum.TaskType.Novice then
		local var_1_2 = TaskModel.instance:getCurStageAllLockTaskIds()
		local var_1_3 = TaskModel.instance:getNoviceTaskCurStage()
		local var_1_4 = {}
		local var_1_5 = {}
		local var_1_6 = {}

		for iter_1_0, iter_1_1 in pairs(var_1_1) do
			if iter_1_1.type == TaskEnum.TaskType.Novice then
				if iter_1_1.config.stage == var_1_3 and iter_1_1.config.minTypeId == TaskEnum.TaskMinType.Novice and JumpConfig.instance:isOpenJumpId(iter_1_1.config.jumpId) then
					table.insert(var_1_0, iter_1_1)
				end

				if iter_1_1.config.minTypeId == TaskEnum.TaskMinType.GrowBack and JumpConfig.instance:isOpenJumpId(iter_1_1.config.jumpId) and iter_1_1.finishCount < iter_1_1.config.maxFinishCount then
					table.insert(var_1_5, iter_1_1)
				end
			end
		end

		for iter_1_2, iter_1_3 in ipairs(var_1_2) do
			local var_1_7 = arg_1_0:fillLockTaskMo(iter_1_3)

			if JumpConfig.instance:isOpenJumpId(var_1_7.config.jumpId) then
				table.insert(var_1_0, var_1_7)
			end
		end

		table.sort(var_1_0, function(arg_2_0, arg_2_1)
			local var_2_0 = arg_2_0.finishCount >= arg_2_0.config.maxFinishCount and 3 or arg_2_0.hasFinished and 1 or 2
			local var_2_1 = arg_2_1.finishCount >= arg_2_1.config.maxFinishCount and 3 or arg_2_1.hasFinished and 1 or 2

			if var_2_0 ~= var_2_1 then
				return var_2_0 < var_2_1
			elseif arg_2_0.config.sortId ~= arg_2_1.config.sortId then
				return arg_2_0.config.sortId < arg_2_1.config.sortId
			else
				return arg_2_0.config.id < arg_2_1.config.id
			end
		end)
		table.sort(var_1_5, function(arg_3_0, arg_3_1)
			return arg_3_0.config.sortId > arg_3_1.config.sortId
		end)

		for iter_1_4, iter_1_5 in ipairs(var_1_5) do
			table.insert(var_1_0, 1, iter_1_5)
		end

		local var_1_8 = arg_1_0:_getCurMainTaskMo(var_1_1)

		for iter_1_6, iter_1_7 in ipairs(var_1_8) do
			if JumpConfig.instance:isOpenJumpId(iter_1_7.config.jumpId) then
				table.insert(var_1_0, 1, iter_1_7)
			end
		end
	else
		for iter_1_8, iter_1_9 in pairs(var_1_1) do
			if iter_1_9.type == arg_1_1 then
				local var_1_9 = true

				if not string.nilorempty(iter_1_9.config.prepose) then
					local var_1_10 = string.split(iter_1_9.config.prepose, "#")

					for iter_1_10, iter_1_11 in ipairs(var_1_10) do
						if not TaskModel.instance:isTaskFinish(iter_1_9.type, tonumber(iter_1_11)) then
							var_1_9 = false

							break
						end
					end
				end

				if var_1_9 then
					table.insert(var_1_0, iter_1_9)
				end
			end
		end

		table.sort(var_1_0, function(arg_4_0, arg_4_1)
			local var_4_0 = arg_4_0.finishCount >= arg_4_0.config.maxFinishCount and 3 or arg_4_0.hasFinished and 1 or 2
			local var_4_1 = arg_4_1.finishCount >= arg_4_1.config.maxFinishCount and 3 or arg_4_1.hasFinished and 1 or 2

			if var_4_0 ~= var_4_1 then
				return var_4_0 < var_4_1
			elseif arg_4_0.config.sortId ~= arg_4_1.config.sortId then
				return arg_4_0.config.sortId < arg_4_1.config.sortId
			else
				return arg_4_0.config.id < arg_4_1.config.id
			end
		end)
	end

	return var_1_0
end

function var_0_0.fillLockTaskMo(arg_5_0, arg_5_1)
	local var_5_0 = {}

	var_5_0.typeId = 0
	var_5_0.config = TaskConfig.instance:gettaskNoviceConfig(arg_5_1)
	var_5_0.progress = 0
	var_5_0.hasFinished = false
	var_5_0.finishCount = 0
	var_5_0.type = TaskEnum.TaskType.Novice
	var_5_0.lock = true

	return var_5_0
end

function var_0_0._getCurMainTaskMo(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		if iter_6_1.type == TaskEnum.TaskType.Novice and iter_6_1.config.chapter ~= 0 then
			table.insert(var_6_0, iter_6_1)
		end
	end

	table.sort(var_6_0, function(arg_7_0, arg_7_1)
		return arg_7_0.config.sortId < arg_7_1.config.sortId
	end)

	for iter_6_2, iter_6_3 in ipairs(var_6_0) do
		if not iter_6_3.config.prepose or iter_6_3.config.prepose == "" then
			if not TaskModel.instance:isTaskFinish(TaskEnum.TaskType.Novice, tonumber(iter_6_3.id)) then
				return {
					iter_6_3
				}
			end
		elseif not TaskModel.instance:isTaskFinish(TaskEnum.TaskType.Novice, tonumber(iter_6_3.config.id)) and TaskModel.instance:isTaskFinish(TaskEnum.TaskType.Novice, tonumber(iter_6_3.config.prepose)) then
			return {
				iter_6_3
			}
		end
	end

	return {}
end

var_0_0.instance = var_0_0.New()

return var_0_0
