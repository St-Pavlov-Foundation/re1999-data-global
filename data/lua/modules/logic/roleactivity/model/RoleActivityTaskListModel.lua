module("modules.logic.roleactivity.model.RoleActivityTaskListModel", package.seeall)

local var_0_0 = class("RoleActivityTaskListModel", ListScrollModel)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.actId = arg_1_1

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.RoleActivity
	}, arg_1_0.refreshData, arg_1_0)
end

function var_0_0.refreshData(arg_2_0)
	local var_2_0 = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.RoleActivity, arg_2_0.actId)
	local var_2_1 = {}
	local var_2_2 = 0

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if iter_2_1.hasFinished then
			var_2_2 = var_2_2 + 1
		end

		table.insert(var_2_1, iter_2_1)
	end

	if var_2_2 > 1 then
		table.insert(var_2_1, TaskMo.New())
	end

	table.sort(var_2_1, var_0_0.sortMO)

	arg_2_0._hasRankDiff = false

	arg_2_0:setList(var_2_1)
end

function var_0_0.sortMO(arg_3_0, arg_3_1)
	local var_3_0 = var_0_0.getSortIndex(arg_3_0)
	local var_3_1 = var_0_0.getSortIndex(arg_3_1)

	if var_3_0 ~= var_3_1 then
		return var_3_0 < var_3_1
	elseif arg_3_0.id ~= arg_3_1.id then
		return arg_3_0.id < arg_3_1.id
	end
end

function var_0_0.getSortIndex(arg_4_0)
	if arg_4_0.id == 0 then
		return 1
	elseif arg_4_0.finishCount > 0 or arg_4_0.preFinish then
		return 100
	elseif arg_4_0.hasFinished then
		return 2
	end

	return 50
end

function var_0_0.getRankDiff(arg_5_0, arg_5_1)
	if arg_5_0._hasRankDiff and arg_5_1 then
		local var_5_0 = tabletool.indexOf(arg_5_0._idIdxList, arg_5_1.id)
		local var_5_1 = arg_5_0:getIndex(arg_5_1)

		if var_5_0 and var_5_1 then
			arg_5_0._idIdxList[var_5_0] = -2

			return var_5_1 - var_5_0
		end
	end

	return 0
end

function var_0_0.refreshRankDiff(arg_6_0)
	arg_6_0._idIdxList = {}

	local var_6_0 = arg_6_0:getList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		table.insert(arg_6_0._idIdxList, iter_6_1.id)
	end
end

function var_0_0.preFinish(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = false

	arg_7_0._hasRankDiff = false

	arg_7_0:refreshRankDiff()

	local var_7_1 = 0
	local var_7_2 = arg_7_0:getList()

	if arg_7_1.id == 0 then
		for iter_7_0, iter_7_1 in ipairs(var_7_2) do
			if iter_7_1.hasFinished and iter_7_1.id ~= 0 then
				iter_7_1.preFinish = true
				var_7_0 = true
				var_7_1 = var_7_1 + 1
			end
		end
	elseif arg_7_1.hasFinished then
		arg_7_1.preFinish = true
		var_7_0 = true
		var_7_1 = var_7_1 + 1
	end

	if var_7_0 then
		local var_7_3 = arg_7_0:getById(0)

		if var_7_3 and arg_7_0:getGotRewardCount() < var_7_1 + 1 then
			tabletool.removeValue(var_7_2, var_7_3)
		end

		arg_7_0._hasRankDiff = true

		table.sort(var_7_2, var_0_0.sortMO)
		arg_7_0:setList(var_7_2)

		arg_7_0._hasRankDiff = false
	end
end

function var_0_0.getGotRewardCount(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 or arg_8_0:getList()
	local var_8_1 = 0

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if iter_8_1.hasFinished then
			var_8_1 = var_8_1 + 1
		end
	end

	return var_8_1
end

function var_0_0.getActivityId(arg_9_0)
	return arg_9_0.actId
end

function var_0_0.clearData(arg_10_0)
	arg_10_0.actId = nil

	arg_10_0:clear()
end

var_0_0.instance = var_0_0.New()

return var_0_0
