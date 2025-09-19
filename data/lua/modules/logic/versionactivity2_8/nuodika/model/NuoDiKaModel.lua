module("modules.logic.versionactivity2_8.nuodika.model.NuoDiKaModel", package.seeall)

local var_0_0 = class("NuoDiKaModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._episodeInfos = {}
	arg_2_0._curEpisodeIndex = 0
	arg_2_0._curEpisode = 0
end

function var_0_0.initInfos(arg_3_0, arg_3_1)
	arg_3_0._episodeInfos = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if not arg_3_0._episodeInfos[iter_3_1.episodeId] then
			arg_3_0._episodeInfos[iter_3_1.episodeId] = NuoDiKaEpisodeMo.New()

			arg_3_0._episodeInfos[iter_3_1.episodeId]:init(iter_3_1)
		else
			arg_3_0._episodeInfos[iter_3_1.episodeId]:update(iter_3_1)
		end
	end
end

function var_0_0.updateEpisodeInfo(arg_4_0, arg_4_1)
	arg_4_0._episodeInfos[arg_4_1.episodeId]:update(arg_4_1)
end

function var_0_0.updateInfos(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		if not arg_5_0._episodeInfos[iter_5_1.episodeId] then
			arg_5_0._episodeInfos[iter_5_1.episodeId] = NuoDiKaEpisodeMo.New()

			arg_5_0._episodeInfos[iter_5_1.episodeId]:init(iter_5_1)
		else
			arg_5_0._episodeInfos[iter_5_1.episodeId]:update(iter_5_1)
		end
	end
end

function var_0_0.getCurGameProcess(arg_6_0, arg_6_1)
	return arg_6_0._episodeInfos[arg_6_1].gameString
end

function var_0_0.getEpisodeStatus(arg_7_0, arg_7_1)
	return arg_7_0._episodeInfos[arg_7_1].status
end

function var_0_0.setCurEpisode(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._curEpisodeIndex = arg_8_1
	arg_8_0._curEpisode = arg_8_2 and arg_8_2 or arg_8_0._curEpisode
end

function var_0_0.getEpisodeIndex(arg_9_0, arg_9_1)
	return arg_9_1 % 1000
end

function var_0_0.getCurEpisodeIndex(arg_10_0)
	return arg_10_0._curEpisodeIndex or 0
end

function var_0_0.getCurEpisode(arg_11_0)
	return arg_11_0._curEpisode
end

function var_0_0.isEpisodeUnlock(arg_12_0, arg_12_1)
	return arg_12_0._episodeInfos[arg_12_1]
end

function var_0_0.isEpisodePass(arg_13_0, arg_13_1)
	if not arg_13_0._episodeInfos[arg_13_1] then
		return false
	end

	return arg_13_0._episodeInfos[arg_13_1].isFinished
end

function var_0_0.isAllEpisodeFinish(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._episodeInfos) do
		if not iter_14_1.isFinished then
			return false
		end
	end

	return true
end

function var_0_0.getNewFinishEpisode(arg_15_0)
	return arg_15_0._newFinishEpisode or 0
end

function var_0_0.setNewFinishEpisode(arg_16_0, arg_16_1)
	arg_16_0._newFinishEpisode = arg_16_1
end

function var_0_0.clearFinishEpisode(arg_17_0)
	arg_17_0._newFinishEpisode = 0
end

function var_0_0.getMaxUnlockEpisodeId(arg_18_0)
	local var_18_0 = NuoDiKaConfig.instance:getEpisodeCoList(VersionActivity2_8Enum.ActivityId.NuoDiKa)
	local var_18_1 = 0

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		var_18_1 = arg_18_0:isEpisodeUnlock(iter_18_1.episodeId) and math.max(var_18_1, iter_18_1.episodeId) or var_18_1
	end

	return var_18_1
end

function var_0_0.getMaxEpisodeId(arg_19_0)
	local var_19_0 = NuoDiKaConfig.instance:getEpisodeCoList(VersionActivity2_8Enum.ActivityId.NuoDiKa)
	local var_19_1 = 0

	for iter_19_0, iter_19_1 in pairs(var_19_0) do
		var_19_1 = math.max(var_19_1, iter_19_1.episodeId)
	end

	return var_19_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
