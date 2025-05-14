module("modules.logic.bossrush.model.V1a4_BossRush_ScoreTaskAchievementListModel", package.seeall)

local var_0_0 = class("V1a4_BossRush_ScoreTaskAchievementListModel", ListScrollModel)

function var_0_0.setStaticData(arg_1_0, arg_1_1)
	arg_1_0._staticData = arg_1_1
end

function var_0_0.getStaticData(arg_2_0)
	return arg_2_0._staticData
end

function var_0_0.claimRewardByIndex(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getByIndex(arg_3_1)

	if not var_3_0 then
		return
	end

	local var_3_1 = var_3_0.id
	local var_3_2 = var_3_0.config

	var_3_0.finishCount = math.min(var_3_0.finishCount + 1, var_3_2.maxFinishCount)
	var_3_0.hasFinished = false

	arg_3_0:sort(arg_3_0._sort)
	TaskRpc.instance:sendFinishTaskRequest(var_3_1)
end

function var_0_0._sort(arg_4_0, arg_4_1)
	if arg_4_0.getAll then
		return true
	end

	if arg_4_1.getAll then
		return false
	end

	local var_4_0 = arg_4_0.config
	local var_4_1 = arg_4_1.config
	local var_4_2 = arg_4_0.id
	local var_4_3 = arg_4_1.id
	local var_4_4 = arg_4_0.finishCount >= var_4_0.maxFinishCount and 1 or 0
	local var_4_5 = arg_4_1.finishCount >= var_4_1.maxFinishCount and 1 or 0
	local var_4_6 = arg_4_0.hasFinished and 1 or 0
	local var_4_7 = arg_4_1.hasFinished and 1 or 0
	local var_4_8 = arg_4_0.maxProgress
	local var_4_9 = arg_4_1.maxProgress

	if var_4_6 ~= var_4_7 then
		return var_4_7 < var_4_6
	end

	if var_4_4 ~= var_4_5 then
		return var_4_4 < var_4_5
	end

	if var_4_8 ~= var_4_9 then
		return var_4_8 < var_4_9
	end

	return var_4_2 < var_4_3
end

function var_0_0.getFinishCount(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = 0

	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		if iter_5_1.config and iter_5_1.config.stage == arg_5_2 and iter_5_1.finishCount < iter_5_1.config.maxFinishCount and iter_5_1.hasFinished then
			var_5_0 = var_5_0 + 1
		end
	end

	return var_5_0
end

function var_0_0.setAchievementMoList(arg_6_0, arg_6_1)
	local var_6_0 = BossRushModel.instance:getTaskMoListByStage(arg_6_1)

	if arg_6_0:getFinishCount(var_6_0, arg_6_1) > 1 then
		table.insert(var_6_0, 1, {
			getAll = true,
			stage = arg_6_1
		})
	end

	table.sort(var_6_0, arg_6_0._sort)
	arg_6_0:setList(var_6_0)
end

function var_0_0.getAllAchievementTask(arg_7_0, arg_7_1)
	local var_7_0 = BossRushModel.instance:getTaskMoListByStage(arg_7_1)
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		table.insert(var_7_1, iter_7_1.id)
	end

	return var_7_1
end

function var_0_0.isReddot(arg_8_0, arg_8_1)
	local var_8_0 = BossRushModel.instance:getTaskMoListByStage(arg_8_1)

	if var_8_0 then
		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			local var_8_1 = iter_8_1.config

			if iter_8_1.finishCount < var_8_1.maxFinishCount and iter_8_1.hasFinished then
				return true
			end
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
