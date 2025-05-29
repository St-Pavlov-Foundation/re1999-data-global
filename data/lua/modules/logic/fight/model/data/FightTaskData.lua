module("modules.logic.fight.model.data.FightTaskData", package.seeall)

local var_0_0 = FightDataClass("FightTaskData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.taskId = arg_1_1.taskId
	arg_1_0.status = arg_1_1.status
	arg_1_0.values = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.values) do
		table.insert(arg_1_0.values, FightTaskValueData.New(iter_1_1))
	end
end

return var_0_0
