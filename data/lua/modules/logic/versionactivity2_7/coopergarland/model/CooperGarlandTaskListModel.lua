module("modules.logic.versionactivity2_7.coopergarland.model.CooperGarlandTaskListModel", package.seeall)

local var_0_0 = class("CooperGarlandTaskListModel", ListScrollModel)

local function var_0_1(arg_1_0)
	if arg_1_0.id == CooperGarlandEnum.Const.TaskMOAllFinishId then
		return 1
	elseif arg_1_0:isFinished() then
		return 100
	elseif arg_1_0:alreadyGotReward() then
		return 2
	end

	return 50
end

local function var_0_2(arg_2_0, arg_2_1)
	local var_2_0 = var_0_1(arg_2_0)
	local var_2_1 = var_0_1(arg_2_1)

	if var_2_0 ~= var_2_1 then
		return var_2_0 < var_2_1
	elseif arg_2_0.id ~= arg_2_1.id then
		return arg_2_0.id < arg_2_1.id
	end
end

function var_0_0.init(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = 0
	local var_3_2 = CooperGarlandModel.instance:getAct192Id()
	local var_3_3 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity192)

	if var_3_3 ~= nil then
		local var_3_4 = CooperGarlandConfig.instance:getTaskList(var_3_2)

		for iter_3_0, iter_3_1 in ipairs(var_3_4) do
			local var_3_5 = CooperGarlandTaskMO.New()

			var_3_5:init(iter_3_1, var_3_3[iter_3_1.id])

			if var_3_5:alreadyGotReward() then
				var_3_1 = var_3_1 + 1
			end

			table.insert(var_3_0, var_3_5)
		end
	end

	if var_3_1 > 1 then
		local var_3_6 = CooperGarlandTaskMO.New()

		var_3_6.id = CooperGarlandEnum.Const.TaskMOAllFinishId
		var_3_6.activityId = var_3_2

		table.insert(var_3_0, var_3_6)
	end

	table.sort(var_3_0, var_0_2)

	arg_3_0._hasRankDiff = false

	arg_3_0:setList(var_3_0)
end

function var_0_0.getRankDiff(arg_4_0, arg_4_1)
	if arg_4_0._hasRankDiff and arg_4_1 then
		local var_4_0 = tabletool.indexOf(arg_4_0._idIdxList, arg_4_1.id)
		local var_4_1 = arg_4_0:getIndex(arg_4_1)

		if var_4_0 and var_4_1 then
			arg_4_0._idIdxList[var_4_0] = -2

			return var_4_1 - var_4_0
		end
	end

	return 0
end

function var_0_0.refreshRankDiff(arg_5_0)
	arg_5_0._idIdxList = {}

	local var_5_0 = arg_5_0:getList()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		table.insert(arg_5_0._idIdxList, iter_5_1.id)
	end
end

function var_0_0.preFinish(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	local var_6_0 = false

	arg_6_0._hasRankDiff = false

	arg_6_0:refreshRankDiff()

	local var_6_1 = 0
	local var_6_2 = arg_6_0:getList()

	if arg_6_1.id == CooperGarlandEnum.Const.TaskMOAllFinishId then
		for iter_6_0, iter_6_1 in ipairs(var_6_2) do
			if iter_6_1:alreadyGotReward() and iter_6_1.id ~= CooperGarlandEnum.Const.TaskMOAllFinishId then
				iter_6_1.preFinish = true
				var_6_0 = true
				var_6_1 = var_6_1 + 1
			end
		end
	elseif arg_6_1:alreadyGotReward() then
		arg_6_1.preFinish = true
		var_6_0 = true
		var_6_1 = var_6_1 + 1
	end

	if var_6_0 then
		local var_6_3 = arg_6_0:getById(CooperGarlandEnum.Const.TaskMOAllFinishId)

		if var_6_3 and arg_6_0:getGotRewardCount() < var_6_1 + 1 then
			tabletool.removeValue(var_6_2, var_6_3)
		end

		arg_6_0._hasRankDiff = true

		table.sort(var_6_2, var_0_2)
		arg_6_0:setList(var_6_2)

		arg_6_0._hasRankDiff = false
	end
end

function var_0_0.getGotRewardCount(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1 or arg_7_0:getList()
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1:alreadyGotReward() and not iter_7_1.preFinish and iter_7_1.id ~= CooperGarlandEnum.Const.TaskMOAllFinishId then
			var_7_1 = var_7_1 + 1
		end
	end

	return var_7_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
