module("modules.logic.meilanni.model.MeilanniMapInfoMO", package.seeall)

local var_0_0 = pureTable("MeilanniMapInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.mapId = arg_1_1.mapId
	arg_1_0.mapConfig = lua_activity108_map.configDict[arg_1_0.mapId]

	arg_1_0:_initEpisodeInfos(arg_1_1)

	arg_1_0.score = arg_1_1.score
	arg_1_0.highestScore = arg_1_1.highestScore
	arg_1_0.getRewardIds = arg_1_1.getRewardIds
	arg_1_0.isFinish = arg_1_1.isFinish
	arg_1_0.totalCount = arg_1_1.totalCount

	arg_1_0:updateExcludeRules(arg_1_1)
end

function var_0_0.getExcludeRules(arg_2_0)
	return arg_2_0.excludeRules
end

function var_0_0.updateExcludeRules(arg_3_0, arg_3_1)
	arg_3_0.excludeRules = {}
	arg_3_0.excludeRulesMap = {}
	arg_3_0._excludeThreat = 0

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.excludeRules) do
		local var_3_0 = lua_activity108_rule.configDict[iter_3_1]

		if var_3_0 then
			local var_3_1 = tonumber(var_3_0.rules)

			table.insert(arg_3_0.excludeRules, var_3_1)

			arg_3_0.excludeRulesMap[var_3_1] = var_3_0
			arg_3_0._excludeThreat = arg_3_0._excludeThreat + var_3_0.threat
		end
	end
end

function var_0_0.isExcludeRule(arg_4_0, arg_4_1)
	return arg_4_0.excludeRulesMap[arg_4_1]
end

function var_0_0.getThreat(arg_5_0)
	local var_5_0 = arg_5_0.mapConfig.threat

	return math.max(var_5_0 - arg_5_0._excludeThreat, 0)
end

function var_0_0.getMaxScore(arg_6_0)
	return arg_6_0.highestScore
end

function var_0_0._initEpisodeInfos(arg_7_0, arg_7_1)
	arg_7_0.episodeInfos = {}
	arg_7_0._episodeInfoMap = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1.episodeInfos) do
		local var_7_0 = EpisodeInfoMO.New()

		var_7_0:init(iter_7_1)
		table.insert(arg_7_0.episodeInfos, var_7_0)

		arg_7_0._episodeInfoMap[var_7_0.episodeId] = var_7_0
	end
end

function var_0_0.updateEpisodeInfo(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._episodeInfoMap[arg_8_1.episodeId]

	if not var_8_0 then
		var_8_0 = EpisodeInfoMO.New()

		var_8_0:init(arg_8_1)
		table.insert(arg_8_0.episodeInfos, var_8_0)

		arg_8_0._episodeInfoMap[var_8_0.episodeId] = var_8_0
	else
		var_8_0:init(arg_8_1)
	end
end

function var_0_0.getEpisodeInfo(arg_9_0, arg_9_1)
	return arg_9_0._episodeInfoMap[arg_9_1]
end

function var_0_0.getCurEpisodeInfo(arg_10_0)
	return arg_10_0.episodeInfos[#arg_10_0.episodeInfos]
end

function var_0_0.checkFinish(arg_11_0)
	return arg_11_0.isFinish and arg_11_0:getCurEpisodeInfo().confirm
end

function var_0_0.getEventInfo(arg_12_0, arg_12_1)
	return arg_12_0:getCurEpisodeInfo():getEventInfo(arg_12_1)
end

function var_0_0.getEpisodeByBattleId(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0.episodeInfos) do
		if iter_13_1:getEventByBattleId(arg_13_1) then
			return iter_13_1
		end
	end
end

function var_0_0.isGetReward(arg_14_0, arg_14_1)
	return tabletool.indexOf(arg_14_0.getRewardIds, arg_14_1)
end

function var_0_0.getTotalCostAP(arg_15_0)
	if not arg_15_0._episodeInfoMap then
		return 0
	end

	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(arg_15_0._episodeInfoMap) do
		var_15_0 = var_15_0 + MeilanniConfig.instance:getEpisodeConfig(iter_15_0).actpoint - iter_15_1.leftActPoint
	end

	return var_15_0
end

return var_0_0
