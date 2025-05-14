module("modules.logic.seasonver.act123.model.Season123TaskModel", package.seeall)

local var_0_0 = class("Season123TaskModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.tempTaskModel = BaseModel.New()
	arg_1_0.curTaskType = Activity123Enum.TaskRewardViewType
	arg_1_0.stageTaskMap = {}
	arg_1_0.normalTaskMap = {}
	arg_1_0.reddotShowMap = {}
	arg_1_0.curStage = 1
	arg_1_0.TaskMaskTime = 0.65
	arg_1_0.ColumnCount = 1
	arg_1_0.AnimRowCount = 7
	arg_1_0.OpenAnimTime = 0.06
	arg_1_0.OpenAnimStartTime = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.tempTaskModel:clear()
end

function var_0_0.clear(arg_3_0)
	arg_3_0.tempTaskModel:clear()
	var_0_0.super.clear(arg_3_0)

	arg_3_0._itemStartAnimTime = nil
	arg_3_0.stageTaskMap = {}
	arg_3_0.normalTaskMap = {}
	arg_3_0.reddotShowMap = {}
end

function var_0_0.resetMapData(arg_4_0)
	arg_4_0.stageTaskMap = {}
	arg_4_0.normalTaskMap = {}
end

function var_0_0.setTaskInfoList(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = Season123Model.instance:getCurSeasonId()

	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		if iter_5_1.config and iter_5_1.config.seasonId == var_5_1 then
			table.insert(var_5_0, iter_5_1)
		end
	end

	arg_5_0.tempTaskModel:setList(var_5_0)
	arg_5_0:sortList()
	arg_5_0:checkRedDot()

	for iter_5_2, iter_5_3 in pairs(arg_5_0.tempTaskModel:getList()) do
		arg_5_0:initTaskMap(iter_5_3)
	end
end

function var_0_0.initTaskMap(arg_6_0, arg_6_1)
	local var_6_0 = Season123Config.instance:getTaskListenerParamCache(arg_6_1.config)

	if #var_6_0 > 1 and arg_6_1.config.isRewardView == Activity123Enum.TaskRewardViewType then
		local var_6_1 = tonumber(var_6_0[1])

		if not arg_6_0.stageTaskMap[var_6_1] then
			arg_6_0.stageTaskMap[var_6_1] = {}
		end

		arg_6_0.stageTaskMap[var_6_1][arg_6_1.id] = arg_6_1
	else
		arg_6_0.normalTaskMap[arg_6_1.id] = arg_6_1
	end
end

function var_0_0.sortList(arg_7_0)
	arg_7_0.tempTaskModel:sort(var_0_0.sortFunc)
end

function var_0_0.sortFunc(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.finishCount >= arg_8_0.config.maxFinishCount and 3 or arg_8_0.hasFinished and 1 or 2
	local var_8_1 = arg_8_1.finishCount >= arg_8_1.config.maxFinishCount and 3 or arg_8_1.hasFinished and 1 or 2

	if var_8_0 ~= var_8_1 then
		return var_8_0 < var_8_1
	elseif arg_8_0.config.sortId ~= arg_8_1.config.sortId then
		return arg_8_0.config.sortId < arg_8_1.config.sortId
	else
		return arg_8_0.config.id < arg_8_1.config.id
	end
end

function var_0_0.updateInfo(arg_9_0, arg_9_1)
	local var_9_0 = false

	if GameUtil.getTabLen(arg_9_0.tempTaskModel:getList()) == 0 then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if iter_9_1.type == TaskEnum.TaskType.Season123 then
			local var_9_1 = arg_9_0.tempTaskModel:getById(iter_9_1.id)

			if not var_9_1 then
				local var_9_2 = Season123Config.instance:getSeason123TaskCo(iter_9_1.id)

				if var_9_2 then
					var_9_1 = TaskMo.New()

					var_9_1:init(iter_9_1, var_9_2)
					arg_9_0.tempTaskModel:addAtLast(var_9_1)
					arg_9_0:initTaskMap(var_9_1)
				else
					logError("Season123TaskCo by id is not exit: " .. tostring(iter_9_1.id))
				end
			else
				var_9_1:update(iter_9_1)
			end

			var_9_0 = true
		end
	end

	if var_9_0 then
		arg_9_0:sortList()
		arg_9_0:checkRedDot()
	end

	return var_9_0
end

function var_0_0.refreshList(arg_10_0, arg_10_1)
	arg_10_0.curTaskType = arg_10_1 or arg_10_0.curTaskType

	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0.tempTaskModel:getList()) do
		local var_10_1 = Season123Config.instance:getTaskListenerParamCache(iter_10_1.config)

		if #var_10_1 > 1 and tonumber(var_10_1[1]) == arg_10_0.curStage and iter_10_1.config.isRewardView == arg_10_0.curTaskType then
			table.insert(var_10_0, iter_10_1)
		elseif iter_10_1.config.isRewardView == Activity123Enum.TaskNormalType and iter_10_1.config.isRewardView == arg_10_0.curTaskType then
			table.insert(var_10_0, iter_10_1)
		end
	end

	local var_10_2 = arg_10_0:checkAndRemovePreposeTask(var_10_0)

	if arg_10_0:getTaskItemRewardCount(var_10_2) > 1 then
		table.insert(var_10_2, 1, {
			id = 0,
			canGetAll = true
		})
	end

	arg_10_0:setList(var_10_2)
	arg_10_0:saveCurStageAndTaskType()
	arg_10_0:checkRedDot()
end

function var_0_0.getTaskItemRewardCount(arg_11_0, arg_11_1)
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if iter_11_1.progress >= iter_11_1.config.maxProgress and iter_11_1.finishCount == 0 then
			var_11_0 = var_11_0 + 1
		end
	end

	return var_11_0
end

function var_0_0.isTaskFinished(arg_12_0, arg_12_1)
	return arg_12_1.finishCount > 0 and arg_12_1.progress >= arg_12_1.config.maxProgress
end

function var_0_0.checkRedDot(arg_13_0)
	local var_13_0 = arg_13_0:checkTaskHaveReward(arg_13_0.normalTaskMap)
	local var_13_1 = arg_13_0:checkTaskHaveReward(arg_13_0.stageTaskMap[arg_13_0.curStage])

	arg_13_0.reddotShowMap[Activity123Enum.TaskRewardViewType] = var_13_1
	arg_13_0.reddotShowMap[Activity123Enum.TaskNormalType] = var_13_0
end

function var_0_0.getAllCanGetList(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = arg_14_0:getList() or {}

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		if iter_14_1.config and iter_14_1.progress >= iter_14_1.config.maxProgress and iter_14_1.finishCount == 0 then
			table.insert(var_14_0, iter_14_1.id)
		end
	end

	return var_14_0
end

function var_0_0.checkAndRemovePreposeTask(arg_15_0, arg_15_1)
	local var_15_0 = tabletool.copy(arg_15_1)

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_1 = string.split(iter_15_1.config.prepose, "#")

		for iter_15_2, iter_15_3 in ipairs(var_15_1) do
			local var_15_2 = arg_15_0.tempTaskModel:getById(tonumber(iter_15_3))

			if var_15_2 and not arg_15_0:isTaskFinished(var_15_2) then
				table.remove(var_15_0, iter_15_0)

				break
			end
		end
	end

	return var_15_0
end

function var_0_0.getDelayPlayTime(arg_16_0, arg_16_1)
	if arg_16_1 == nil then
		return -1
	end

	local var_16_0 = Time.time

	if arg_16_0._itemStartAnimTime == nil then
		arg_16_0._itemStartAnimTime = var_16_0 + arg_16_0.OpenAnimStartTime
	end

	local var_16_1 = arg_16_0:getIndex(arg_16_1)

	if not var_16_1 or var_16_1 > arg_16_0.AnimRowCount * arg_16_0.ColumnCount then
		return -1
	end

	local var_16_2 = math.floor((var_16_1 - 1) / arg_16_0.ColumnCount) * arg_16_0.OpenAnimTime + arg_16_0.OpenAnimStartTime

	if var_16_0 - arg_16_0._itemStartAnimTime - var_16_2 > 0.1 then
		return -1
	else
		return var_16_2
	end
end

function var_0_0.getLocalKey(arg_17_0)
	local var_17_0 = Season123Model.instance:getCurSeasonId()

	return "Season123Task" .. "#" .. tostring(var_17_0) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function var_0_0.saveCurStageAndTaskType(arg_18_0)
	local var_18_0 = arg_18_0.curStage .. "#" .. arg_18_0.curTaskType

	PlayerPrefsHelper.setString(arg_18_0:getLocalKey(), var_18_0)
end

function var_0_0.initStageAndTaskType(arg_19_0)
	local var_19_0 = PlayerPrefsHelper.getString(arg_19_0:getLocalKey(), 1 .. "#" .. Activity123Enum.TaskRewardViewType)
	local var_19_1 = string.splitToNumber(var_19_0, "#")
	local var_19_2 = var_19_1[1]
	local var_19_3 = var_19_1[2]
	local var_19_4 = arg_19_0:getHaveRewardTaskIndexList()
	local var_19_5 = #var_19_4 > 0 and var_19_4[1] or var_19_2
	local var_19_6 = arg_19_0:checkTaskHaveReward(arg_19_0.normalTaskMap)

	if arg_19_0:checkTaskHaveReward(arg_19_0.stageTaskMap[var_19_5]) then
		arg_19_0.curTaskType = Activity123Enum.TaskRewardViewType
	elseif var_19_6 then
		arg_19_0.curTaskType = Activity123Enum.TaskNormalType
	else
		arg_19_0.curTaskType = var_19_3
	end

	arg_19_0.curStage = var_19_5
end

function var_0_0.getHaveRewardTaskIndexList(arg_20_0)
	local var_20_0 = {}
	local var_20_1 = {}

	for iter_20_0 = 1, 6 do
		local var_20_2 = arg_20_0.stageTaskMap[iter_20_0] or {}

		for iter_20_1, iter_20_2 in pairs(var_20_2) do
			if iter_20_2.progress >= iter_20_2.config.maxProgress and iter_20_2.finishCount == 0 then
				table.insert(var_20_0, iter_20_0)

				var_20_1[iter_20_0] = true

				break
			end
		end
	end

	return var_20_0, var_20_1
end

function var_0_0.checkTaskHaveReward(arg_21_0, arg_21_1)
	if not arg_21_1 then
		return false
	end

	for iter_21_0, iter_21_1 in pairs(arg_21_1) do
		if iter_21_1.progress >= iter_21_1.config.maxProgress and iter_21_1.finishCount == 0 then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
