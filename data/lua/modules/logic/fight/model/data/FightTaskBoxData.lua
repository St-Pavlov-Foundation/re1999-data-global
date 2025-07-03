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
		local var_1_0 = FightTaskData.New(iter_1_1)

		arg_1_0.tasks[iter_1_1.taskId] = var_1_0
	end
end

return var_0_0
