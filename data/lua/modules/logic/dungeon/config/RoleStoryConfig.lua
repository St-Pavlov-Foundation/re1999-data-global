module("modules.logic.dungeon.config.RoleStoryConfig", package.seeall)

local var_0_0 = class("RoleStoryConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._roleStoryConfig = nil
	arg_1_0._roleStoryScoreDict = {}
	arg_1_0._roleStoryRewardDict = {}
	arg_1_0._roleStoryRewardConfig = nil
	arg_1_0._roleStoryDispatchDict = {}
	arg_1_0._roleStoryDispatchConfig = nil
	arg_1_0._roleStoryDispatchTalkConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"hero_story",
		"hero_story_score",
		"hero_story_score_reward",
		"hero_story_dispatch",
		"hero_story_dispatch_talk"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "hero_story" then
		arg_3_0._roleStoryConfig = arg_3_2
	elseif arg_3_1 == "hero_story_score" then
		arg_3_0._roleStoryScoreDict = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_2.configList) do
			if not arg_3_0._roleStoryScoreDict[iter_3_1.storyId] then
				arg_3_0._roleStoryScoreDict[iter_3_1.storyId] = {}
			end

			local var_3_0 = string.splitToNumber(iter_3_1.wave, "#")

			if var_3_0[#var_3_0] then
				table.insert(arg_3_0._roleStoryScoreDict[iter_3_1.storyId], {
					wave = var_3_0[#var_3_0],
					score = iter_3_1.score
				})
			end
		end

		for iter_3_2, iter_3_3 in pairs(arg_3_0._roleStoryScoreDict) do
			table.sort(iter_3_3, SortUtil.keyLower("wave"))
		end
	elseif arg_3_1 == "hero_story_score_reward" then
		arg_3_0._roleStoryRewardDict = {}

		for iter_3_4, iter_3_5 in ipairs(arg_3_2.configList) do
			if not arg_3_0._roleStoryRewardDict[iter_3_5.storyId] then
				arg_3_0._roleStoryRewardDict[iter_3_5.storyId] = {}
			end

			table.insert(arg_3_0._roleStoryRewardDict[iter_3_5.storyId], iter_3_5)
		end

		for iter_3_6, iter_3_7 in pairs(arg_3_0._roleStoryRewardDict) do
			table.sort(iter_3_7, SortUtil.keyLower("score"))
		end

		arg_3_0._roleStoryRewardConfig = arg_3_2
	elseif arg_3_1 == "hero_story_dispatch" then
		arg_3_0._roleStoryDispatchDict = {}

		for iter_3_8, iter_3_9 in ipairs(arg_3_2.configList) do
			if not arg_3_0._roleStoryDispatchDict[iter_3_9.heroStoryId] then
				arg_3_0._roleStoryDispatchDict[iter_3_9.heroStoryId] = {}
			end

			if not arg_3_0._roleStoryDispatchDict[iter_3_9.heroStoryId][iter_3_9.type] then
				arg_3_0._roleStoryDispatchDict[iter_3_9.heroStoryId][iter_3_9.type] = {}
			end

			table.insert(arg_3_0._roleStoryDispatchDict[iter_3_9.heroStoryId][iter_3_9.type], iter_3_9)
		end

		for iter_3_10, iter_3_11 in pairs(arg_3_0._roleStoryDispatchDict) do
			for iter_3_12, iter_3_13 in pairs(iter_3_11) do
				table.sort(iter_3_13, SortUtil.keyLower("id"))
			end
		end

		arg_3_0._roleStoryDispatchConfig = arg_3_2
	elseif arg_3_1 == "hero_story_dispatch_talk" then
		arg_3_0._roleStoryDispatchTalkConfig = arg_3_2
	end
end

function var_0_0.getStoryList(arg_4_0)
	return arg_4_0._roleStoryConfig.configList
end

function var_0_0.getStoryById(arg_5_0, arg_5_1)
	return arg_5_0._roleStoryConfig.configDict[arg_5_1]
end

function var_0_0.getScoreConfig(arg_6_0, arg_6_1)
	return arg_6_0._roleStoryScoreDict[arg_6_1]
end

function var_0_0.getRewardList(arg_7_0, arg_7_1)
	return arg_7_0._roleStoryRewardDict[arg_7_1]
end

function var_0_0.getRewardConfig(arg_8_0, arg_8_1)
	return arg_8_0._roleStoryRewardConfig.configDict[arg_8_1]
end

function var_0_0.getStoryIdByActivityId(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getStoryList()
	local var_9_1 = 0

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if iter_9_1.activityId == arg_9_1 then
			var_9_1 = iter_9_1.id

			break
		end
	end

	return var_9_1
end

function var_0_0.getStoryIdByChapterId(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getStoryList()

	if var_10_0 then
		for iter_10_0, iter_10_1 in pairs(var_10_0) do
			if iter_10_1.chapterId == arg_10_1 then
				return iter_10_1.id
			end
		end
	end
end

function var_0_0.getDispatchList(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_0._roleStoryDispatchDict[arg_11_1] and arg_11_0._roleStoryDispatchDict[arg_11_1][arg_11_2]
end

function var_0_0.getDispatchConfig(arg_12_0, arg_12_1)
	return arg_12_0._roleStoryDispatchConfig.configDict[arg_12_1]
end

function var_0_0.getTalkConfig(arg_13_0, arg_13_1)
	return arg_13_0._roleStoryDispatchTalkConfig.configDict[arg_13_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
