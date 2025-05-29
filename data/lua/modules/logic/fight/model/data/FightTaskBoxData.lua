module("modules.logic.fight.model.data.FightTaskBoxData", package.seeall)

local var_0_0 = FightDataClass("FightTaskBoxData")

var_0_0.TaskStatus = {
	Finished = 3,
	Running = 2,
	Init = 1
}

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.tasks = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.tasks) do
		arg_1_0.tasks[iter_1_1.taskId] = arg_1_0:newTask(iter_1_1)
	end
end

function var_0_0.newTask(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.taskId
	local var_2_1 = {
		taskId = var_2_0,
		status = arg_2_1.status,
		values = {}
	}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.values) do
		local var_2_2 = {
			index = iter_2_1.index,
			progress = iter_2_1.progress,
			maxProgress = iter_2_1.maxProgress,
			finished = iter_2_1.finished
		}

		table.insert(var_2_1.values, var_2_2)
	end

	return var_2_1
end

return var_0_0
