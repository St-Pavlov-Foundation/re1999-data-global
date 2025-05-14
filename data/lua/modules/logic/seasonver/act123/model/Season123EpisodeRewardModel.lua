module("modules.logic.seasonver.act123.model.Season123EpisodeRewardModel", package.seeall)

local var_0_0 = class("Season123EpisodeRewardModel", BaseModel)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.stageRewardMap = {}
	arg_1_0.curActId = arg_1_1

	arg_1_0:initStageRewardConfig(arg_1_2)
end

function var_0_0.release(arg_2_0)
	arg_2_0:clear()

	arg_2_0.stageRewardMap = {}
	arg_2_0.curActId = 0
end

function var_0_0.initStageRewardConfig(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		if iter_3_1.config and iter_3_1.config.seasonId == arg_3_0.curActId and iter_3_1.config.isRewardView == Activity123Enum.TaskRewardViewType then
			local var_3_0 = Season123Config.instance:getTaskListenerParamCache(iter_3_1.config)
			local var_3_1 = tonumber(var_3_0[1])
			local var_3_2 = arg_3_0.stageRewardMap[var_3_1] or {}

			var_3_2[iter_3_0] = iter_3_1
			arg_3_0.stageRewardMap[var_3_1] = var_3_2
		end
	end
end

function var_0_0.setTaskInfoList(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = arg_4_0.stageRewardMap[arg_4_1] or {}

	if GameUtil.getTabLen(var_4_1) == 0 then
		logError("task_activity123 config is not exited, actid: " .. arg_4_0.curActId .. ",stageId: " .. arg_4_1)
	end

	for iter_4_0, iter_4_1 in pairs(var_4_1) do
		table.insert(var_4_0, iter_4_1)
	end

	arg_4_0:setList(var_4_0)
	arg_4_0:sort(var_0_0.sortList)
end

function var_0_0.sortList(arg_5_0, arg_5_1)
	return tonumber(string.split(arg_5_0.config.listenerParam, "#")[2]) > tonumber(string.split(arg_5_1.config.listenerParam, "#")[2])
end

function var_0_0.getCurStageCanGetReward(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = arg_6_0:getList()

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if iter_6_1.progress >= iter_6_1.config.maxProgress and iter_6_1.hasFinished then
			table.insert(var_6_0, iter_6_1.id)
		end
	end

	return var_6_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
