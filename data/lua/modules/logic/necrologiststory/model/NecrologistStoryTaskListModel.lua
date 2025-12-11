module("modules.logic.necrologiststory.model.NecrologistStoryTaskListModel", package.seeall)

local var_0_0 = class("NecrologistStoryTaskListModel", ListScrollModel)

function var_0_0.refreshList(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:getTaskList(arg_1_1)
	local var_1_1 = {}
	local var_1_2 = 0

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		var_1_1[iter_1_0] = iter_1_1

		if iter_1_1.hasFinished then
			var_1_2 = var_1_2 + 1
		end
	end

	if var_1_2 > 1 then
		table.insert(var_1_1, 1, {
			isTotalGet = true,
			storyId = arg_1_1
		})
	end

	arg_1_0:setList(var_1_1)
end

function var_0_0.getTaskList(arg_2_0, arg_2_1)
	local var_2_0 = RoleStoryConfig.instance:getStoryById(arg_2_1).activityId

	if not ActivityModel.instance:isActOnLine(var_2_0) then
		var_2_0 = nil
	end

	local var_2_1 = {}
	local var_2_2 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.NecrologistStory)

	for iter_2_0, iter_2_1 in pairs(var_2_2) do
		if iter_2_1.config and iter_2_1.config.storyId == arg_2_1 and (iter_2_1.config.activityId == var_2_0 or iter_2_1.config.activityId == 0) then
			table.insert(var_2_1, iter_2_1)
		end
	end

	table.sort(var_2_1, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_0:isClaimed() and 3 or arg_3_0.hasFinished and 1 or 2
		local var_3_1 = arg_3_1:isClaimed() and 3 or arg_3_1.hasFinished and 1 or 2

		if var_3_0 ~= var_3_1 then
			return var_3_0 < var_3_1
		else
			return arg_3_0.config.id < arg_3_1.config.id
		end
	end)

	return var_2_1
end

function var_0_0.sendFinishAllTaskRequest(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.NecrologistStory)

	for iter_4_0, iter_4_1 in pairs(var_4_1) do
		if iter_4_1.config and iter_4_1.config.storyId == arg_4_1 and iter_4_1:isClaimable() then
			table.insert(var_4_0, iter_4_1.id)
		end
	end

	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.NecrologistStory, nil, var_4_0)
end

function var_0_0.hasLimitTaskNotFinish(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getTaskList(arg_5_1)

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if not iter_5_1:isClaimed() and iter_5_1.config.activityId ~= 0 then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
