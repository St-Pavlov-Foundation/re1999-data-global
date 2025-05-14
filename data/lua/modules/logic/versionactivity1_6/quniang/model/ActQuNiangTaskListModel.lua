module("modules.logic.versionactivity1_6.quniang.model.ActQuNiangTaskListModel", package.seeall)

local var_0_0 = class("ActQuNiangTaskListModel", ListScrollModel)

function var_0_0.init(arg_1_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.RoleActivity
	}, arg_1_0.refreshData, arg_1_0)
end

function var_0_0.refreshData(arg_2_0)
	local var_2_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.RoleActivity)
	local var_2_1 = {}
	local var_2_2 = 0

	if var_2_0 ~= nil then
		local var_2_3 = RoleActivityConfig.instance:getActicityTaskList(ActQuNiangEnum.ActivityId)

		for iter_2_0, iter_2_1 in pairs(var_2_3) do
			local var_2_4 = ActQuNiangTaskMO.New()

			var_2_4:init(iter_2_1, var_2_0[iter_2_1.id])

			if var_2_4:alreadyGotReward() then
				var_2_2 = var_2_2 + 1
			end

			table.insert(var_2_1, var_2_4)
		end
	end

	if var_2_2 > 1 then
		local var_2_5 = ActQuNiangTaskMO.New()

		var_2_5.id = ActQuNiangEnum.TaskMOAllFinishId
		var_2_5.activityId = ActQuNiangEnum.ActivityId

		table.insert(var_2_1, var_2_5)
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
	if arg_4_0.id == ActQuNiangEnum.TaskMOAllFinishId then
		return 1
	elseif arg_4_0:isFinished() then
		return 100
	elseif arg_4_0:alreadyGotReward() then
		return 2
	end

	return 50
end

function var_0_0.createMO(arg_5_0, arg_5_1, arg_5_2)
	return {
		config = arg_5_2.config,
		originTaskMO = arg_5_2
	}
end

function var_0_0.getRankDiff(arg_6_0, arg_6_1)
	if arg_6_0._hasRankDiff and arg_6_1 then
		local var_6_0 = tabletool.indexOf(arg_6_0._idIdxList, arg_6_1.id)
		local var_6_1 = arg_6_0:getIndex(arg_6_1)

		if var_6_0 and var_6_1 then
			arg_6_0._idIdxList[var_6_0] = -2

			return var_6_1 - var_6_0
		end
	end

	return 0
end

function var_0_0.refreshRankDiff(arg_7_0)
	arg_7_0._idIdxList = {}

	local var_7_0 = arg_7_0:getList()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		table.insert(arg_7_0._idIdxList, iter_7_1.id)
	end
end

function var_0_0.preFinish(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return
	end

	local var_8_0 = false

	arg_8_0._hasRankDiff = false

	arg_8_0:refreshRankDiff()

	local var_8_1 = 0
	local var_8_2 = arg_8_0:getList()

	if arg_8_1.id == ActQuNiangEnum.TaskMOAllFinishId then
		for iter_8_0, iter_8_1 in ipairs(var_8_2) do
			if iter_8_1:alreadyGotReward() and iter_8_1.id ~= ActQuNiangEnum.TaskMOAllFinishId then
				iter_8_1.preFinish = true
				var_8_0 = true
				var_8_1 = var_8_1 + 1
			end
		end
	elseif arg_8_1:alreadyGotReward() then
		arg_8_1.preFinish = true
		var_8_0 = true
		var_8_1 = var_8_1 + 1
	end

	if var_8_0 then
		local var_8_3 = arg_8_0:getById(ActQuNiangEnum.TaskMOAllFinishId)

		if var_8_3 and arg_8_0:getGotRewardCount() < var_8_1 + 1 then
			tabletool.removeValue(var_8_2, var_8_3)
		end

		arg_8_0._hasRankDiff = true

		table.sort(var_8_2, var_0_0.sortMO)
		arg_8_0:setList(var_8_2)

		arg_8_0._hasRankDiff = false
	end
end

function var_0_0.getGotRewardCount(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1 or arg_9_0:getList()
	local var_9_1 = 0

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if iter_9_1:alreadyGotReward() and not iter_9_1.preFinish and iter_9_1.id ~= ActQuNiangEnum.TaskMOAllFinishId then
			var_9_1 = var_9_1 + 1
		end
	end

	return var_9_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
