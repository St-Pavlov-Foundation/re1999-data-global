module("modules.logic.versionactivity3_1.gaosiniao.config.Activity210Config", package.seeall)

local var_0_0 = class("Activity210Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.__activityId = false
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity210_const",
		"activity210_episode",
		"activity210_task"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity210_const" then
		arg_3_0.__activityId = false
	end
end

local function var_0_1(arg_4_0, arg_4_1)
	return lua_activity210_episode.configDict[arg_4_0][arg_4_1]
end

local function var_0_2(arg_5_0, arg_5_1)
	return lua_activity210_const.configDict[arg_5_0][arg_5_1]
end

function var_0_0.getConstWithActId(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = var_0_2(arg_6_1, arg_6_2)

	if not var_6_0 then
		return nil, nil
	end

	return var_6_0.value, var_6_0.value2
end

function var_0_0.actId(arg_7_0)
	if arg_7_0.__activityId then
		return arg_7_0.__activityId
	end

	arg_7_0.__activityId = ActivityConfig.instance:getConstAsNum(2, 13118)

	return arg_7_0.__activityId
end

function var_0_0.getEpisodeCO(arg_8_0, arg_8_1)
	return var_0_1(arg_8_0:actId(), arg_8_1)
end

function var_0_0.getPreEpisodeId(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return 0
	end

	local var_9_0 = arg_9_0:getEpisodeCO(arg_9_1)

	if not var_9_0 then
		return 0
	end

	return var_9_0.preEpisodeId
end

function var_0_0.getPreEpisodeCO(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getPreEpisodeId(arg_10_1)

	if var_10_0 <= 0 then
		return nil
	end

	return arg_10_0:getEpisodeCO(var_10_0)
end

function var_0_0.getStoryIdPrePost(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getEpisodeCO(arg_11_1)

	if not var_11_0 then
		return 0, 0
	end

	return var_11_0.storyBefore, var_11_0.storyClear
end

function var_0_0.getPreStoryId(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getEpisodeCO(arg_12_1)

	return var_12_0 and var_12_0.storyBefore or 0
end

function var_0_0.getPostStoryId(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getEpisodeCO(arg_13_1)

	return var_13_0 and var_13_0.storyClear or 0
end

function var_0_0.getPreEpisodeBranchId(arg_14_0, arg_14_1)
	return arg_14_0:getEpisodeCO(arg_14_1).preEpisodeBranchId or 0
end

function var_0_0.getEpisodeCO_gameId(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getEpisodeCO(arg_15_1)

	return var_15_0 and var_15_0.gameId or 0
end

function var_0_0.getEpisodeCO_disactiveEpisodeInfoList(arg_16_0, arg_16_1)
	if not arg_16_1 or arg_16_1 <= 0 then
		return {}
	end

	local var_16_0 = arg_16_0:getEpisodeCO(arg_16_1)
	local var_16_1 = var_16_0 and var_16_0.disactiveEpisodeIds or nil

	if string.nilorempty(var_16_1) then
		return {}
	end

	return GameUtil.splitString2(var_16_1, true)
end

function var_0_0.getEpisodeCOs(arg_17_0)
	local var_17_0 = arg_17_0:actId()

	if not var_17_0 then
		return {}
	end

	return lua_activity210_episode.configDict[var_17_0]
end

function var_0_0.isSP(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getEpisodeCO(arg_18_1)

	if not var_18_0 then
		return false
	end

	return var_18_0.type == GaoSiNiaoEnum.EpisodeType.SP
end

function var_0_0.getEpisodeCO_guideId(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getEpisodeCO(arg_19_1)

	return var_19_0 and var_19_0.guideId or 0
end

return var_0_0
