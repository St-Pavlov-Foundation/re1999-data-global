module("modules.logic.versionactivity3_1.gaosiniao.model.CorvusTaskListModel", package.seeall)

local var_0_0 = class("CorvusTaskListModel", ListScrollModel)

function var_0_0._getTaskMoList(arg_1_0, arg_1_1, arg_1_2)
	assert(arg_1_1)
	assert(arg_1_2)

	local var_1_0 = TaskModel.instance:getTaskMoList(arg_1_1, arg_1_2)

	table.sort(var_1_0, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_0.config.sorting
		local var_2_1 = arg_2_1.config.sorting
		local var_2_2 = arg_2_0.hasFinished and 1 or 0
		local var_2_3 = arg_2_1.hasFinished and 1 or 0

		if var_2_2 ~= var_2_3 then
			return var_2_3 < var_2_2
		end

		local var_2_4 = arg_2_0:isClaimed() and 1 or 0
		local var_2_5 = arg_2_1:isClaimed() and 1 or 0

		if var_2_4 ~= var_2_5 then
			return var_2_4 < var_2_5
		end

		if var_2_0 ~= var_2_1 then
			return var_2_0 < var_2_1
		end

		return arg_2_0.id < arg_2_1.id
	end)

	return var_1_0
end

function var_0_0.setTaskList(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._taskMoList = arg_3_0:_getTaskMoList(arg_3_1, arg_3_2)

	arg_3_0:setList(arg_3_0._taskMoList)

	arg_3_0._hasGetAllFlag = false
end

function var_0_0.setTaskListWithGetAll(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._taskMoList = arg_4_0:_getTaskMoList(arg_4_1, arg_4_2)

	if arg_4_0:getFinishTaskCount() > 1 then
		table.insert(arg_4_0._taskMoList, 1, {
			getAll = true
		})
	end

	arg_4_0:setList(arg_4_0._taskMoList)

	arg_4_0._hasGetAllFlag = true
end

function var_0_0.refreshList(arg_5_0, arg_5_1)
	if arg_5_1 == nil then
		arg_5_1 = arg_5_0._hasGetAllFlag
	end

	local var_5_0 = arg_5_0:getFinishTaskCount()

	if arg_5_1 and var_5_0 > 1 then
		local var_5_1 = tabletool.copy(arg_5_0._taskMoList)

		table.insert(var_5_1, 1, {
			getAll = true
		})
		arg_5_0:setList(var_5_1)
	else
		arg_5_0:setList(arg_5_0._taskMoList)
	end
end

function var_0_0.getFinishTaskCount(arg_6_0)
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._taskMoList) do
		if iter_6_1.hasFinished and iter_6_1.finishCount < iter_6_1:getMaxFinishCount() then
			var_6_0 = var_6_0 + 1
		end
	end

	return var_6_0
end

function var_0_0.getFinishTaskActivityCount(arg_7_0)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._taskMoList) do
		if iter_7_1.hasFinished and iter_7_1.finishCount < iter_7_1:getMaxFinishCount() then
			var_7_0 = var_7_0 + iter_7_1.config.activity
		end
	end

	return var_7_0
end

function var_0_0.getGetRewardTaskCount(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._taskMoList) do
		if iter_8_1:isClaimed() then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
