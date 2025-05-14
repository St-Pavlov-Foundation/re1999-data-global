module("modules.logic.versionactivity1_5.act142.model.Activity142TaskListModel", package.seeall)

local var_0_0 = class("Activity142TaskListModel", ListScrollModel)

local function var_0_1(arg_1_0)
	if arg_1_0.id == Activity142Enum.TASK_ALL_RECEIVE_ITEM_EMPTY_ID then
		return 1
	elseif arg_1_0:haveRewardToGet() then
		return 2
	elseif arg_1_0:alreadyGotReward() then
		return 100
	end

	return 50
end

local function var_0_2(arg_2_0, arg_2_1)
	local var_2_0 = var_0_1(arg_2_0)
	local var_2_1 = var_0_1(arg_2_1)

	if var_2_0 ~= var_2_1 then
		return var_2_0 < var_2_1
	elseif arg_2_0.id ~= arg_2_1.id then
		return arg_2_0.id < arg_2_1.id
	end
end

function var_0_0.init(arg_3_0, arg_3_1)
	local var_3_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity142)
	local var_3_1 = {}
	local var_3_2 = 0

	if var_3_0 then
		local var_3_3 = Activity142Config.instance:getTaskByActId(arg_3_1)

		for iter_3_0, iter_3_1 in ipairs(var_3_3) do
			local var_3_4 = var_3_0[iter_3_1.id]
			local var_3_5 = Activity142TaskMO.New()

			var_3_5:init(iter_3_1, var_3_4)

			if var_3_5:haveRewardToGet() then
				var_3_2 = var_3_2 + 1
			end

			table.insert(var_3_1, var_3_5)
		end
	end

	if var_3_2 > 1 then
		local var_3_6 = Activity142TaskMO.New()

		var_3_6.id = Activity142Enum.TASK_ALL_RECEIVE_ITEM_EMPTY_ID
		var_3_6.activityId = arg_3_1

		table.insert(var_3_1, var_3_6)
	end

	table.sort(var_3_1, var_0_2)
	arg_3_0:setList(var_3_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
