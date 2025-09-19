module("modules.logic.survival.model.SurvivalTaskModel", package.seeall)

local var_0_0 = class("SurvivalTaskModel", BaseModel)

function var_0_0.initViewParam(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.selectTaskType = arg_1_1 or SurvivalEnum.TaskModule.MainTask
	arg_1_0.selectTaskId = arg_1_2 or 0
end

function var_0_0.setSelectType(arg_2_0, arg_2_1)
	if arg_2_1 == arg_2_0.selectTaskType then
		return
	end

	arg_2_0.selectTaskType = arg_2_1

	return true
end

function var_0_0.getSelectType(arg_3_0)
	return arg_3_0.selectTaskType
end

function var_0_0.getTaskFinishedNum(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getTaskList(arg_4_1)
	local var_4_1 = 0
	local var_4_2 = 0

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		if arg_4_1 == SurvivalEnum.TaskModule.SubTask then
			if iter_4_1:isFinish() then
				var_4_2 = var_4_2 + 1
			end
		elseif not iter_4_1:isUnFinish() then
			var_4_2 = var_4_2 + 1
		end

		var_4_1 = var_4_1 + 1
	end

	return var_4_2, var_4_1
end

function var_0_0.getTaskList(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = SurvivalShelterModel.instance:getWeekInfo()

	if var_5_1 then
		local var_5_2 = var_5_1.taskPanel:getTaskBoxMo(arg_5_1)

		for iter_5_0, iter_5_1 in pairs(var_5_2.tasks) do
			if not iter_5_1:isFail() then
				table.insert(var_5_0, iter_5_1)
			end
		end

		if arg_5_1 == SurvivalEnum.TaskModule.MainTask then
			local var_5_3 = {}
			local var_5_4 = {}

			for iter_5_2, iter_5_3 in pairs(var_5_0) do
				var_5_4[iter_5_3.id] = true

				if iter_5_3.co then
					var_5_3[iter_5_3.co.group] = true
				end
			end

			for iter_5_4, iter_5_5 in ipairs(lua_survival_maintask.configList) do
				if var_5_3[iter_5_5.group] and not var_5_4[iter_5_5.id] then
					local var_5_5 = SurvivalTaskMo.Create(arg_5_1, iter_5_5.id)

					table.insert(var_5_0, var_5_5)
				end
			end
		end

		if #var_5_0 > 1 then
			if arg_5_1 == SurvivalEnum.TaskModule.SubTask then
				table.sort(var_5_0, SortUtil.tableKeyLower({
					"id",
					"type"
				}))
			elseif arg_5_1 == SurvivalEnum.TaskModule.MainTask then
				table.sort(var_5_0, SortUtil.tableKeyLower({
					"group",
					"step",
					"id"
				}))
			elseif arg_5_1 == SurvivalEnum.TaskModule.NormalTask then
				table.sort(var_5_0, SortUtil.tableKeyLower({
					"status",
					"id"
				}))
			else
				table.sort(var_5_0, SortUtil.keyUpper("id"))
			end
		end
	end

	return var_5_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
