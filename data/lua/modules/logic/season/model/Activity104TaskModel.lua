module("modules.logic.season.model.Activity104TaskModel", package.seeall)

local var_0_0 = class("Activity104TaskModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.getTaskSeasonList(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Season)

	for iter_3_0, iter_3_1 in pairs(var_3_1) do
		if iter_3_1.config then
			table.insert(var_3_0, iter_3_1)
		end
	end

	table.sort(var_3_0, function(arg_4_0, arg_4_1)
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

	return var_3_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
