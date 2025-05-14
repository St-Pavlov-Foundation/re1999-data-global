module("modules.logic.versionactivity1_5.aizila.model.AiZiLaTaskListModel", package.seeall)

local var_0_0 = class("AiZiLaTaskListModel", ListScrollModel)

function var_0_0.init(arg_1_0)
	local var_1_0 = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.RoleAiZiLa) or {}
	local var_1_1 = {}
	local var_1_2 = VersionActivity1_5Enum.ActivityId.AiZiLa
	local var_1_3 = AiZiLaConfig.instance:getTaskList(var_1_2)
	local var_1_4 = 0

	for iter_1_0, iter_1_1 in ipairs(var_1_3) do
		local var_1_5 = AiZiLaTaskMO.New()

		var_1_5:init(iter_1_1, var_1_0[iter_1_1.id])
		table.insert(var_1_1, var_1_5)

		if var_1_5:alreadyGotReward() then
			var_1_4 = var_1_4 + 1
		end
	end

	if var_1_4 > 1 then
		local var_1_6 = AiZiLaTaskMO.New()

		var_1_6.id = AiZiLaEnum.TaskMOAllFinishId
		var_1_6.activityId = var_1_2

		table.insert(var_1_1, 1, var_1_6)
	end

	table.sort(var_1_1, var_0_0.sortMO)

	arg_1_0._hasRankDiff = false

	arg_1_0:_refreshShowTab(var_1_1)
	arg_1_0:setList(var_1_1)
end

function var_0_0.sortMO(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.getSortIndex(arg_2_0)
	local var_2_1 = var_0_0.getSortIndex(arg_2_1)

	if var_2_0 ~= var_2_1 then
		return var_2_0 < var_2_1
	elseif arg_2_0.id ~= arg_2_1.id then
		return arg_2_0.id < arg_2_1.id
	end
end

function var_0_0.getSortIndex(arg_3_0)
	if arg_3_0.id == AiZiLaEnum.TaskMOAllFinishId then
		return 1
	end

	local var_3_0 = arg_3_0:isMainTask() and 0 or 200

	if arg_3_0:isFinished() then
		return 99 + var_3_0
	elseif arg_3_0:alreadyGotReward() then
		return 2 + var_3_0
	end

	return 50 + var_3_0
end

function var_0_0.createMO(arg_4_0, arg_4_1, arg_4_2)
	return {
		config = arg_4_2.config,
		originTaskMO = arg_4_2
	}
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

function var_0_0.refreshShowTab(arg_7_0)
	arg_7_0:_refreshShowTab(arg_7_0:getList())
end

function var_0_0._refreshShowTab(arg_8_0, arg_8_1)
	local var_8_0

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_1 = iter_8_1:isMainTask()

		if iter_8_1.id ~= AiZiLaEnum.TaskMOAllFinishId and var_8_0 ~= var_8_1 then
			var_8_0 = var_8_1

			iter_8_1:setShowTab(true)
		else
			iter_8_1:setShowTab(false)
		end
	end
end

function var_0_0.getInfoList(arg_9_0, arg_9_1)
	local var_9_0 = {}
	local var_9_1 = arg_9_0:getList()

	arg_9_0:_refreshShowTab(var_9_1)

	for iter_9_0, iter_9_1 in ipairs(var_9_1) do
		local var_9_2 = SLFramework.UGUI.MixCellInfo.New(iter_9_0, iter_9_1:getLineHeight(), iter_9_0)

		table.insert(var_9_0, var_9_2)
	end

	return var_9_0
end

function var_0_0.preFinish(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	local var_10_0 = false

	arg_10_0._hasRankDiff = false

	arg_10_0:refreshRankDiff()

	local var_10_1 = 0
	local var_10_2 = arg_10_0:getList()

	if arg_10_1.id == AiZiLaEnum.TaskMOAllFinishId then
		for iter_10_0, iter_10_1 in ipairs(var_10_2) do
			if iter_10_1:alreadyGotReward() and iter_10_1.id ~= AiZiLaEnum.TaskMOAllFinishId then
				iter_10_1.preFinish = true
				var_10_0 = true
				var_10_1 = var_10_1 + 1
			end
		end
	elseif arg_10_1:alreadyGotReward() then
		arg_10_1.preFinish = true
		var_10_0 = true
		var_10_1 = var_10_1 + 1
	end

	if var_10_0 then
		local var_10_3 = arg_10_0:getById(AiZiLaEnum.TaskMOAllFinishId)

		if var_10_3 and arg_10_0:getGotRewardCount() < var_10_1 + 1 then
			tabletool.removeValue(var_10_2, var_10_3)
		end

		arg_10_0._hasRankDiff = true

		table.sort(var_10_2, var_0_0.sortMO)
		arg_10_0:setList(var_10_2)

		arg_10_0._hasRankDiff = false
	end
end

function var_0_0.getGotRewardCount(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 or arg_11_0:getList()
	local var_11_1 = 0

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if iter_11_1:alreadyGotReward() and not iter_11_1.preFinish and iter_11_1.id ~= AiZiLaEnum.TaskMOAllFinishId then
			var_11_1 = var_11_1 + 1
		end
	end

	return var_11_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
