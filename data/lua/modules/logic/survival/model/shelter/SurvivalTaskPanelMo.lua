module("modules.logic.survival.model.shelter.SurvivalTaskPanelMo", package.seeall)

local var_0_0 = pureTable("SurvivalTaskPanelMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.taskBoxs = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.boxs) do
		local var_1_0 = SurvivalTaskBoxMo.New()

		var_1_0:init(iter_1_1)

		arg_1_0.taskBoxs[var_1_0.moduleId] = var_1_0
	end
end

function var_0_0.getTaskBoxMo(arg_2_0, arg_2_1)
	if not arg_2_0.taskBoxs[arg_2_1] then
		arg_2_0.taskBoxs[arg_2_1] = SurvivalTaskBoxMo.Create(arg_2_1)
	end

	return arg_2_0.taskBoxs[arg_2_1]
end

function var_0_0.addOrUpdateTasks(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0:getTaskBoxMo(iter_3_1.moduleId):addOrUpdateTasks(iter_3_1.tasks)
	end
end

function var_0_0.removeTasks(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0:getTaskBoxMo(iter_4_1.moduleId):removeTasks(iter_4_1.taskId)
	end
end

return var_0_0
