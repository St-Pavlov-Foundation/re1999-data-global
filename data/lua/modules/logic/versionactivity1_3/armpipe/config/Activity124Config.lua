module("modules.logic.versionactivity1_3.armpipe.config.Activity124Config", package.seeall)

local var_0_0 = class("Activity124Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._act124Map = nil
	arg_1_0._act124Episode = nil
	arg_1_0._episodeListDict = {}
	arg_1_0._chapterIdListDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity124_map",
		"activity124_episode"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity124_map" then
		arg_3_0._act124Map = arg_3_2
	elseif arg_3_1 == "activity124_episode" then
		arg_3_0._act124Episode = arg_3_2
	end
end

function var_0_0.getMapCo(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._act124Map.configDict[arg_4_1] then
		return arg_4_0._act124Map.configDict[arg_4_1][arg_4_2]
	end

	return nil
end

function var_0_0.getEpisodeCo(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._act124Episode.configDict[arg_5_1] then
		return arg_5_0._act124Episode.configDict[arg_5_1][arg_5_2]
	end

	return nil
end

function var_0_0.getEpisodeList(arg_6_0, arg_6_1)
	if arg_6_0._episodeListDict[arg_6_1] then
		return arg_6_0._episodeListDict[arg_6_1]
	end

	local var_6_0 = {}

	arg_6_0._episodeListDict[arg_6_1] = var_6_0

	if arg_6_0._act124Episode and arg_6_0._act124Episode.configDict[arg_6_1] then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._act124Episode.configDict[arg_6_1]) do
			table.insert(var_6_0, iter_6_1)
		end

		table.sort(var_6_0, var_0_0.sortEpisode)
	end

	return var_6_0
end

function var_0_0.sortEpisode(arg_7_0, arg_7_1)
	if arg_7_0.episodeId ~= arg_7_1.episodeId then
		return arg_7_0.episodeId < arg_7_1.episodeId
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
