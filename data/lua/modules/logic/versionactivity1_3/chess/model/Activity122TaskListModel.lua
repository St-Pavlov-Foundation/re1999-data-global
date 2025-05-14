module("modules.logic.versionactivity1_3.chess.model.Activity122TaskListModel", package.seeall)

local var_0_0 = class("Activity122TaskListModel", ListScrollModel)
local var_0_1 = -100

function var_0_0.init(arg_1_0, arg_1_1)
	local var_1_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity122)
	local var_1_1 = {}
	local var_1_2 = 0

	if var_1_0 ~= nil then
		local var_1_3 = Activity122Config.instance:getTaskByActId(arg_1_1)

		for iter_1_0, iter_1_1 in ipairs(var_1_3) do
			local var_1_4 = Activity122TaskMO.New()
			local var_1_5 = var_1_0[iter_1_1.id]

			var_1_4:init(iter_1_1, var_1_5)

			if var_1_4:haveRewardToGet() then
				var_1_2 = var_1_2 + 1
			end

			table.insert(var_1_1, var_1_4)
		end
	end

	if var_1_2 > 1 then
		local var_1_6 = Activity122TaskMO.New()

		var_1_6.id = var_0_1
		var_1_6.activityId = arg_1_1

		table.insert(var_1_1, var_1_6)
	end

	table.sort(var_1_1, var_0_0.sortMO)
	arg_1_0:setList(var_1_1)
end

function var_0_0.sortMO(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.getSortIndex(arg_2_0)
	local var_2_1 = var_0_0.getSortIndex(arg_2_1)

	if var_2_0 ~= var_2_1 then
		return var_2_0 < var_2_1
	elseif arg_2_0.id ~= arg_2_1.id then
		return arg_2_0.id < arg_2_1.id
	end
end

function var_0_0.getSortIndex(arg_3_0)
	if arg_3_0.id == var_0_1 then
		return 1
	elseif arg_3_0:haveRewardToGet() then
		return 2
	elseif arg_3_0:alreadyGotReward() then
		return 100
	end

	return 50
end

function var_0_0.createMO(arg_4_0, arg_4_1, arg_4_2)
	return {
		config = arg_4_2.config,
		originTaskMO = arg_4_2
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
