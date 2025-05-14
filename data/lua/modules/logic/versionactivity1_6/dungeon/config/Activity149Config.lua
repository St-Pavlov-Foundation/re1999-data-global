module("modules.logic.versionactivity1_6.dungeon.config.Activity149Config", package.seeall)

local var_0_0 = class("Activity149Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._bossEpisodeCfgList = {}
	arg_1_0._bossEpisodeCfgDict = {}
	arg_1_0._bossMapElementDict = {}
	arg_1_0._rewardCfgDict = {}
	arg_1_0._rewardCfgList = {}
	arg_1_0._activityConstDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity149_episode",
		"activity149_rewards",
		"activity149_const",
		"activity149_map_element"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity149_episode" then
		arg_3_0._bossEpisodeCfgList = arg_3_2.configList
		arg_3_0._bossEpisodeCfgDict = arg_3_2.configDict
	elseif arg_3_1 == "activity149_rewards" then
		arg_3_0:initRewardCfg(arg_3_2)
	elseif arg_3_1 == "activity149_const" then
		arg_3_0._activityConstDict = arg_3_2.configDict
	elseif arg_3_1 == "activity149_map_element" then
		arg_3_0._bossMapElementDict = arg_3_2.configDict
	end
end

function var_0_0.initRewardCfg(arg_4_0, arg_4_1)
	arg_4_0._rewardCfgDict = arg_4_1.configDict
	arg_4_0._rewardCfgList = arg_4_1.configList
	arg_4_0._maxScore = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._rewardCfgList) do
		arg_4_0._maxScore = math.max(arg_4_0._maxScore, iter_4_1.rewardPointNum)
	end
end

function var_0_0.getAct149EpisodeCfg(arg_5_0, arg_5_1)
	return arg_5_0._bossEpisodeCfgDict[arg_5_1]
end

function var_0_0.getDungeonEpisodeCfg(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._bossEpisodeCfgDict[arg_6_1]

	return lua_episode.configDict[var_6_0.episodeId]
end

function var_0_0.getAct149EpisodeCfgByOrder(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 then
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs(arg_7_0._bossEpisodeCfgDict) do
			if iter_7_1.order == arg_7_1 then
				var_7_0[#var_7_0 + 1] = iter_7_1
			end
		end

		return var_7_0
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_0._bossEpisodeCfgDict) do
		if iter_7_3.order == arg_7_1 then
			return iter_7_3
		end
	end
end

function var_0_0.getAct149EpisodeCfgByEpisodeId(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._bossEpisodeCfgDict) do
		if iter_8_1.episodeId == arg_8_1 then
			return iter_8_1
		end
	end
end

function var_0_0.getNextBossEpisodeCfgById(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._bossEpisodeCfgDict[arg_9_1]
	local var_9_1 = arg_9_0._bossEpisodeCfgDict[arg_9_1 + 1]
	local var_9_2 = var_9_0.order

	if var_9_1 then
		if var_9_1.order == var_9_2 then
			return var_9_1
		end
	else
		for iter_9_0, iter_9_1 in ipairs(arg_9_0._bossEpisodeCfgList) do
			if var_9_2 == iter_9_1.order then
				return iter_9_1
			end
		end
	end
end

function var_0_0.getEpisodeMaxScore(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0._bossEpisodeCfgDict[arg_10_1]

	if not var_10_0 then
		return 0
	end

	return tonumber(arg_10_0._activityConstDict[1].value) * var_10_0.multi
end

function var_0_0.getAct149BossMapElement(arg_11_0, arg_11_1)
	return arg_11_0._bossMapElementDict[arg_11_1]
end

function var_0_0.getAct149BossMapElementByMapId(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._bossMapElementDict) do
		if iter_12_1.mapId == arg_12_1 then
			return iter_12_1
		end
	end
end

function var_0_0.getAct149ConstValue(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._activityConstDict[arg_13_1]

	return var_13_0 and var_13_0.value
end

function var_0_0.getBossRewardCfgList(arg_14_0)
	return arg_14_0._rewardCfgList
end

function var_0_0.getBossRewardMaxScore(arg_15_0)
	return arg_15_0._maxScore
end

function var_0_0.calRewardProgressWidth(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6, arg_16_7)
	local var_16_0 = arg_16_0:getBossRewardCfgList()
	local var_16_1 = #var_16_0

	if var_16_1 == 0 then
		return 0, 0
	end

	arg_16_6 = arg_16_6 or 0
	arg_16_7 = arg_16_7 or 0
	arg_16_4 = arg_16_4 or arg_16_3 / 2
	arg_16_5 = arg_16_5 or arg_16_3 + arg_16_2

	local var_16_2 = arg_16_4 + (var_16_1 - 1) * arg_16_5 + arg_16_7
	local var_16_3 = 0
	local var_16_4 = 0

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_5 = iter_16_1.rewardPointNum
		local var_16_6 = iter_16_0 == 1 and arg_16_4 or arg_16_5

		if var_16_5 <= arg_16_1 then
			var_16_3 = var_16_3 + var_16_6
			var_16_4 = var_16_5
		else
			var_16_3 = var_16_3 + GameUtil.remap(arg_16_1, var_16_4, var_16_5, 0, var_16_6)

			break
		end
	end

	return math.max(0, var_16_3 - arg_16_6), var_16_2
end

function var_0_0.getAlternateDay(arg_17_0)
	if not arg_17_0._alternateDay then
		arg_17_0._alternateDay = 1

		if arg_17_0._bossEpisodeCfgDict then
			for iter_17_0, iter_17_1 in pairs(arg_17_0._bossEpisodeCfgDict) do
				if not string.nilorempty(iter_17_1.effectCondition) then
					local var_17_0 = string.splitToNumber(iter_17_1.effectCondition, "_")

					if var_17_0 and var_17_0[2] then
						arg_17_0._alternateDay = math.max(arg_17_0._alternateDay, var_17_0[2])
					end
				end
			end
		end
	end

	return arg_17_0._alternateDay
end

var_0_0.instance = var_0_0.New()

return var_0_0
