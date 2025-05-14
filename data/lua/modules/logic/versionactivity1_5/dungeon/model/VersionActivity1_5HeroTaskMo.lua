module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5HeroTaskMo", package.seeall)

local var_0_0 = pureTable("DispatchMo")

function var_0_0.initById(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.config = VersionActivity1_5DungeonConfig.instance:getHeroTaskCo(arg_1_0.id)
	arg_1_0.subTaskCoList = VersionActivity1_5DungeonConfig.instance:getSubHeroTaskList(arg_1_0.id)
	arg_1_0.gainedReward = false
	arg_1_0.subTaskGainedRewardList = nil
end

function var_0_0.initByCo(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.config = arg_2_1
	arg_2_0.gainedReward = false
	arg_2_0.subTaskGainedRewardList = nil
end

function var_0_0.updateGainedReward(arg_3_0, arg_3_1)
	arg_3_0.gainedReward = arg_3_1
end

function var_0_0.updateSubHeroTaskGainedReward(arg_4_0, arg_4_1)
	if arg_4_0:isExploreTask() then
		return
	end

	arg_4_0.subTaskGainedRewardList = {}

	if not arg_4_1 then
		return
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		table.insert(arg_4_0.subTaskGainedRewardList, iter_4_1)
	end
end

function var_0_0.gainedSubHeroTaskId(arg_5_0, arg_5_1)
	table.insert(arg_5_0.subTaskGainedRewardList, arg_5_1)
end

function var_0_0.isExploreTask(arg_6_0)
	return arg_6_0.id == VersionActivity1_5DungeonEnum.ExploreTaskId
end

function var_0_0.isUnlock(arg_7_0)
	return DungeonModel.instance:hasPassLevelAndStory(arg_7_0.config.preEpisodeId)
end

function var_0_0.isFinish(arg_8_0)
	if arg_8_0:isExploreTask() then
		return false
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.subTaskCoList) do
		if not VersionActivity1_5RevivalTaskModel.instance:checkSubHeroTaskIsFinish(iter_8_1) then
			return false
		end
	end

	return true
end

function var_0_0.getSpriteName(arg_9_0)
	if arg_9_0.id == VersionActivity1_5DungeonEnum.ExploreTaskId then
		return arg_9_0.isSelect and VersionActivity1_5DungeonEnum.ExploreTabImageSelect or VersionActivity1_5DungeonEnum.ExploreTabImageNotSelect
	end

	return arg_9_0.isSelect and arg_9_0.config.heroTabIcon .. 1 or arg_9_0.config.heroTabIcon .. 2
end

function var_0_0.subTaskIsGainedReward(arg_10_0, arg_10_1)
	return arg_10_0.subTaskGainedRewardList and tabletool.indexOf(arg_10_0.subTaskGainedRewardList, arg_10_1)
end

function var_0_0.getSubTaskFinishCount(arg_11_0)
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.subTaskCoList) do
		if VersionActivity1_5RevivalTaskModel.instance:checkSubHeroTaskIsFinish(iter_11_1) then
			var_11_0 = var_11_0 + 1
		end
	end

	return var_11_0
end

function var_0_0.getSubTaskCount(arg_12_0)
	return arg_12_0.subTaskCoList and #arg_12_0.subTaskCoList or 0
end

function var_0_0.getSubTaskCoList(arg_13_0)
	return arg_13_0.subTaskCoList
end

return var_0_0
