module("modules.logic.commandstation.model.CommandStationTaskListModel", package.seeall)

local var_0_0 = class("CommandStationTaskListModel", ListScrollModel)

function var_0_0.ctor(arg_1_0)
	arg_1_0.allNormalTaskMos = {}
	arg_1_0.allCatchTaskMos = {}
	arg_1_0.curSelectType = 1

	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.isCatchTaskType(arg_2_0)
	return arg_2_0.curSelectType == CommandStationEnum.TaskType.Catch
end

function var_0_0.initServerData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.allNormalTaskMos = {}
	arg_3_0.allCatchTaskMos = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = lua_copost_version_task.configDict[iter_3_1.id]

		if var_3_0 then
			local var_3_1 = TaskMo.New()

			var_3_1:init(iter_3_1, var_3_0)
			table.insert(arg_3_0.allNormalTaskMos, var_3_1)
		else
			logError("指挥部任务ID不存在" .. iter_3_1.id)
		end
	end

	for iter_3_2, iter_3_3 in ipairs(arg_3_2) do
		local var_3_2 = lua_copost_catch_task.configDict[iter_3_3.id]

		if var_3_2 then
			local var_3_3 = TaskMo.New()

			var_3_3:init(iter_3_3, var_3_2)
			table.insert(arg_3_0.allCatchTaskMos, var_3_3)
		else
			logError("指挥部任务ID不存在" .. iter_3_3.id)
		end
	end

	CommandStationController.instance:dispatchEvent(CommandStationEvent.OnTaskUpdate)
end

function var_0_0.init(arg_4_0)
	local var_4_0 = arg_4_0.curSelectType == 1
	local var_4_1 = var_4_0 and arg_4_0.allNormalTaskMos or arg_4_0.allCatchTaskMos
	local var_4_2 = {}
	local var_4_3 = 0

	if var_4_1 ~= nil then
		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			local var_4_4 = var_4_0 and CommandStationTaskMo.New() or CommandStationCatchTaskMo.New()

			var_4_4:init(iter_4_1.config, iter_4_1)

			if var_4_4:alreadyGotReward() then
				var_4_3 = var_4_3 + 1
			end

			table.insert(var_4_2, var_4_4)
		end
	end

	if var_4_3 > 1 then
		local var_4_5 = var_4_0 and CommandStationTaskMo.New() or CommandStationCatchTaskMo.New()

		var_4_5.id = -99999

		table.insert(var_4_2, var_4_5)
	end

	table.sort(var_4_2, var_0_0.sortMO)

	arg_4_0._hasRankDiff = false

	arg_4_0:setList(var_4_2)
end

function var_0_0.sortMO(arg_5_0, arg_5_1)
	local var_5_0 = var_0_0.getSortIndex(arg_5_0)
	local var_5_1 = var_0_0.getSortIndex(arg_5_1)

	if var_5_0 ~= var_5_1 then
		return var_5_0 < var_5_1
	elseif arg_5_0.id ~= arg_5_1.id then
		return arg_5_0.id < arg_5_1.id
	end
end

function var_0_0.getSortIndex(arg_6_0)
	if arg_6_0.id == -99999 then
		return 1
	elseif arg_6_0:isFinished() then
		return 100
	elseif arg_6_0:alreadyGotReward() then
		return 2
	end

	local var_6_0 = arg_6_0:getActivityStatus()

	if var_6_0 and var_6_0 ~= ActivityEnum.ActivityStatus.Normal then
		return 80
	end

	return 50
end

function var_0_0.createMO(arg_7_0, arg_7_1, arg_7_2)
	return {
		config = arg_7_2.config,
		originTaskMO = arg_7_2
	}
end

function var_0_0.getRankDiff(arg_8_0, arg_8_1)
	if arg_8_0._hasRankDiff and arg_8_1 then
		local var_8_0 = tabletool.indexOf(arg_8_0._idIdxList, arg_8_1.id)
		local var_8_1 = arg_8_0:getIndex(arg_8_1)

		if var_8_0 and var_8_1 then
			arg_8_0._idIdxList[var_8_0] = -2

			return var_8_1 - var_8_0
		end
	end

	return 0
end

function var_0_0.refreshRankDiff(arg_9_0)
	arg_9_0._idIdxList = {}

	local var_9_0 = arg_9_0:getList()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		table.insert(arg_9_0._idIdxList, iter_9_1.id)
	end
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

	if arg_10_1.id == -99999 then
		for iter_10_0, iter_10_1 in ipairs(var_10_2) do
			if iter_10_1:alreadyGotReward() and iter_10_1.id ~= -99999 then
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
		local var_10_3 = arg_10_0:getById(-99999)

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
		if iter_11_1:alreadyGotReward() and not iter_11_1.preFinish and iter_11_1.id ~= -99999 then
			var_11_1 = var_11_1 + 1
		end
	end

	return var_11_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
