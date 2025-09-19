module("modules.logic.survival.model.shelter.SurvivalTaskBoxMo", package.seeall)

local var_0_0 = pureTable("SurvivalTaskBoxMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.moduleId = arg_1_1.moduleId
	arg_1_0.tasks = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.tasks) do
		local var_1_0 = SurvivalTaskMo.New()

		var_1_0:init(iter_1_1, arg_1_0.moduleId)

		arg_1_0.tasks[var_1_0.id] = var_1_0
	end
end

function var_0_0.Create(arg_2_0)
	local var_2_0 = var_0_0.New()

	var_2_0.moduleId = arg_2_0
	var_2_0.tasks = {}

	return var_2_0
end

function var_0_0.addOrUpdateTasks(arg_3_0, arg_3_1)
	local var_3_0 = false

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_1 = arg_3_0.tasks[iter_3_1.id] == nil

		if not arg_3_0.tasks[iter_3_1.id] then
			arg_3_0.tasks[iter_3_1.id] = SurvivalTaskMo.New()
		end

		arg_3_0.tasks[iter_3_1.id]:init(iter_3_1, arg_3_0.moduleId)

		if var_3_1 then
			SurvivalController.instance:tryShowTaskEventPanel(arg_3_0.moduleId, iter_3_1.id)
		end
	end
end

function var_0_0.removeTasks(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if not arg_4_0.tasks[iter_4_1] then
			logError("任务不存在" .. arg_4_0.moduleId .. " >> " .. iter_4_1)
		end

		arg_4_0.tasks[iter_4_1] = nil
	end
end

function var_0_0.getTaskInfo(arg_5_0, arg_5_1)
	return arg_5_0.tasks[arg_5_1]
end

return var_0_0
