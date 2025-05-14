module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiModel", package.seeall)

local var_0_0 = class("WuErLiXiModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._episodeInfos = {}
	arg_2_0._curEpisodeIndex = 0
end

function var_0_0.initInfos(arg_3_0, arg_3_1)
	arg_3_0._episodeInfos = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if not arg_3_0._episodeInfos[iter_3_1.episodeId] then
			arg_3_0._episodeInfos[iter_3_1.episodeId] = WuErLiXiEpisodeMo.New()

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
			arg_5_0._episodeInfos[iter_5_1.episodeId] = WuErLiXiEpisodeMo.New()

			arg_5_0._episodeInfos[iter_5_1.episodeId]:init(iter_5_1)
		else
			arg_5_0._episodeInfos[iter_5_1.episodeId]:update(iter_5_1)
		end
	end
end

function var_0_0.updateEpisodeGameString(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._episodeInfos[arg_6_1]:updateGameString(arg_6_2)
end

function var_0_0.getCurGameProcess(arg_7_0, arg_7_1)
	return arg_7_0._episodeInfos[arg_7_1].gameString
end

function var_0_0.getEpisodeStatus(arg_8_0, arg_8_1)
	return arg_8_0._episodeInfos[arg_8_1].status
end

function var_0_0.setCurEpisodeIndex(arg_9_0, arg_9_1)
	arg_9_0._curEpisodeIndex = arg_9_1
end

function var_0_0.getCurEpisodeIndex(arg_10_0)
	return arg_10_0._curEpisodeIndex or 0
end

function var_0_0.isEpisodeUnlock(arg_11_0, arg_11_1)
	return arg_11_0._episodeInfos[arg_11_1]
end

function var_0_0.isEpisodePass(arg_12_0, arg_12_1)
	if not arg_12_0._episodeInfos[arg_12_1] then
		return false
	end

	return arg_12_0._episodeInfos[arg_12_1].isFinished
end

function var_0_0.getNewFinishEpisode(arg_13_0)
	return arg_13_0._newFinishEpisode or 0
end

function var_0_0.setNewFinishEpisode(arg_14_0, arg_14_1)
	arg_14_0._newFinishEpisode = arg_14_1
end

function var_0_0.clearFinishEpisode(arg_15_0)
	arg_15_0._newFinishEpisode = 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
