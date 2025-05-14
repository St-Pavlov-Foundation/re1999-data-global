module("modules.logic.versionactivity2_5.challenge.model.Act183TaskListModel", package.seeall)

local var_0_0 = class("Act183TaskListModel", MixScrollModel)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._activityId = arg_1_1
	arg_1_0._taskType = arg_1_2

	arg_1_0:_buildTaskMap()
	arg_1_0:refresh()
end

function var_0_0._buildTaskMap(arg_2_0)
	arg_2_0._taskTypeMap = {}

	local var_2_0 = TaskModel.instance:getTaskMoList(TaskEnum.TaskType.Activity183, arg_2_0._activityId)

	if var_2_0 then
		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			local var_2_1 = iter_2_1.config
			local var_2_2 = var_2_1 and var_2_1.type

			arg_2_0._taskTypeMap[var_2_2] = arg_2_0._taskTypeMap[var_2_2] or {}

			table.insert(arg_2_0._taskTypeMap[var_2_2], iter_2_1)
		end
	end

	for iter_2_2, iter_2_3 in pairs(arg_2_0._taskTypeMap) do
		table.sort(iter_2_3, arg_2_0._taskMoListSortFunc)
	end
end

function var_0_0.getTaskMosByType(arg_3_0, arg_3_1)
	return arg_3_0._taskTypeMap and arg_3_0._taskTypeMap[arg_3_1]
end

function var_0_0._taskMoListSortFunc(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.config
	local var_4_1 = arg_4_1.config
	local var_4_2 = var_4_0.groupId
	local var_4_3 = var_4_1.groupId

	if var_4_2 ~= var_4_3 then
		return var_4_2 < var_4_3
	end

	return arg_4_0.id < arg_4_1.id
end

function var_0_0.refresh(arg_5_0)
	local var_5_0 = arg_5_0._taskTypeMap and arg_5_0._taskTypeMap[arg_5_0._taskType]

	var_5_0 = var_5_0 or {}

	local var_5_1 = arg_5_0:_createTaskItemMoList(var_5_0)

	arg_5_0:setList(var_5_1)
end

function var_0_0.getInfoList(arg_6_0, arg_6_1)
	arg_6_0._mixCellInfo = {}

	local var_6_0 = arg_6_0:getList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = iter_6_1.type
		local var_6_2 = Act183Enum.TaskItemHeightMap[var_6_1]

		if var_6_2 then
			local var_6_3 = SLFramework.UGUI.MixCellInfo.New(var_6_1, var_6_2, iter_6_0)

			table.insert(arg_6_0._mixCellInfo, var_6_3)
		else
			logError(string.format("任务条缺少高度配置(Act183Enum.TaskItemHeightMap) dataType = %s", var_6_1))
		end
	end

	return arg_6_0._mixCellInfo
end

function var_0_0._createTaskItemMoList(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1 = {}
	local var_7_2 = {}
	local var_7_3 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_4 = iter_7_1.config.groupId
		local var_7_5 = iter_7_1.id

		if var_7_0 ~= var_7_4 then
			arg_7_0:_addGroupItemToList(var_7_2, var_7_1)
			table.insert(var_7_1, arg_7_0:_createItemMo(Act183Enum.TaskListItemType.Head, iter_7_1))
		end

		if iter_7_1 then
			table.insert(var_7_2, arg_7_0:_createItemMo(Act183Enum.TaskListItemType.Task, iter_7_1))

			if Act183Helper.isTaskCanGetReward(var_7_5) then
				table.insert(var_7_3, iter_7_1)
			end

			var_7_0 = var_7_4
		else
			logError(string.format("缺少任务数据 taskId = %s", var_7_5))
		end
	end

	arg_7_0:_addGroupItemToList(var_7_2, var_7_1)
	arg_7_0:_addOneKeyItemToList(var_7_3, var_7_1)

	return var_7_1
end

function var_0_0._addOneKeyItemToList(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_1 or #arg_8_1 <= 1 then
		arg_8_0._oneKeyTaskItem = nil

		return
	end

	arg_8_0._oneKeyTaskItem = arg_8_0:_createItemMo(Act183Enum.TaskListItemType.OneKey, arg_8_1)
end

function var_0_0.getOneKeyTaskItem(arg_9_0)
	return arg_9_0._oneKeyTaskItem
end

function var_0_0._addGroupItemToList(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 and #arg_10_1 > 0 then
		table.sort(arg_10_1, arg_10_0._taskItemListSortFunc)
		tabletool.addValues(arg_10_2, arg_10_1)

		arg_10_1 = {}
	end
end

function var_0_0._createItemMo(arg_11_0, arg_11_1, arg_11_2)
	return {
		type = arg_11_1,
		data = arg_11_2
	}
end

function var_0_0._taskItemListSortFunc(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.data.config
	local var_12_1 = arg_12_1.data.config
	local var_12_2 = var_12_0.groupId
	local var_12_3 = var_12_1.groupId

	if var_12_2 ~= var_12_3 then
		return var_12_2 < var_12_3
	end

	local var_12_4 = arg_12_0.data.id
	local var_12_5 = arg_12_1.data.id
	local var_12_6 = Act183Helper.isTaskCanGetReward(var_12_4)
	local var_12_7 = Act183Helper.isTaskHasGetReward(var_12_4)
	local var_12_8 = Act183Helper.isTaskCanGetReward(var_12_5)
	local var_12_9 = Act183Helper.isTaskHasGetReward(var_12_5)

	if var_12_6 ~= var_12_8 then
		return var_12_6
	end

	if var_12_7 ~= var_12_9 then
		return not var_12_7
	end

	return var_12_4 < var_12_5
end

var_0_0.instance = var_0_0.New()

return var_0_0
