module("modules.logic.activity.model.chessmap.Activity109ChessGameTaskListModel", package.seeall)

local var_0_0 = class("Activity109ChessGameTaskListModel", ListScrollModel)

function var_0_0.init(arg_1_0, arg_1_1)
	local var_1_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity109)
	local var_1_1 = Activity106Config.instance:getTaskByActId(arg_1_1)
	local var_1_2 = {}

	if var_1_0 ~= nil then
		for iter_1_0, iter_1_1 in ipairs(var_1_1) do
			local var_1_3 = Activity109ChessGameTaskMO.New()
			local var_1_4 = var_1_0[iter_1_1.id]

			var_1_3:init(var_1_4)
			table.insert(var_1_2, var_1_3)
		end

		table.sort(var_1_2, var_0_0.sortMO)
	end

	arg_1_0:setList(var_1_2)
end

function var_0_0.sortMO(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:alreadyGotReward()
	local var_2_1 = arg_2_1:alreadyGotReward()

	if var_2_0 ~= var_2_1 then
		return var_2_1
	else
		return arg_2_0.id < arg_2_1.id
	end
end

function var_0_0.createMO(arg_3_0, arg_3_1, arg_3_2)
	return {
		config = arg_3_2.config,
		originTaskMO = arg_3_2
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
