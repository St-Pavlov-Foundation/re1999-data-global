module("modules.logic.versionactivity3_1.bpoper.model.V3a1_BpOperActModel", package.seeall)

local var_0_0 = class("V3a1_BpOperActModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.isTaskFinished(arg_3_0, arg_3_1)
	local var_3_0 = TaskModel.instance:getTaskById(arg_3_1)

	return var_3_0 and var_3_0.finishCount > 0
end

function var_0_0.isAllTaskFinihshed(arg_4_0)
	local var_4_0 = arg_4_0:getAllShowTask()

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		if not arg_4_0:isTaskFinished(iter_4_1) then
			return false
		end
	end

	return true
end

function var_0_0.getNextTaskId(arg_5_0, arg_5_1)
	local var_5_0 = V3a1_BpOperActConfig.instance:getTaskCos()

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		if not LuaUtil.isEmptyStr(iter_5_1.prepose) and arg_5_1 == tonumber(iter_5_1.prepose) then
			return iter_5_1.id
		end
	end

	return 0
end

function var_0_0.getAllShowTask(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.BpOperAct)

	for iter_6_0, iter_6_1 in pairs(var_6_1) do
		if arg_6_0:isTaskFinished(iter_6_1.id) then
			table.insert(var_6_0, iter_6_1.id)
		else
			local var_6_2 = V3a1_BpOperActConfig.instance:getTaskCO(iter_6_1.id)

			if LuaUtil.isEmptyStr(var_6_2.prepose) then
				table.insert(var_6_0, iter_6_1.id)
			elseif arg_6_0:isTaskFinished(tonumber(var_6_2.prepose)) then
				table.insert(var_6_0, iter_6_1.id)
			end
		end
	end

	if #var_6_0 < 2 then
		return var_6_0
	end

	table.sort(var_6_0, function(arg_7_0, arg_7_1)
		local var_7_0 = TaskModel.instance:getTaskById(arg_7_0)
		local var_7_1 = TaskModel.instance:getTaskById(arg_7_1)
		local var_7_2 = V3a1_BpOperActConfig.instance:getTaskCO(arg_7_0)
		local var_7_3 = V3a1_BpOperActConfig.instance:getTaskCO(arg_7_1)
		local var_7_4 = var_7_0.finishCount > 0 and 3 or var_7_0.progress >= var_7_2.maxProgress and 1 or 2
		local var_7_5 = var_7_1.finishCount > 0 and 3 or var_7_1.progress >= var_7_3.maxProgress and 1 or 2

		if var_7_4 ~= var_7_5 then
			return var_7_4 < var_7_5
		elseif var_7_2.sortId ~= var_7_3.sortId then
			return var_7_2.sortId < var_7_3.sortId
		else
			return var_7_2.id < var_7_3.id
		end
	end)

	return var_6_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
