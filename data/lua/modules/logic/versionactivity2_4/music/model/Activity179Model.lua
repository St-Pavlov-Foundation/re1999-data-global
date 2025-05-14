module("modules.logic.versionactivity2_4.music.model.Activity179Model", package.seeall)

local var_0_0 = class("Activity179Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.reInit(arg_3_0)
	arg_3_0._episodeMap = {}
	arg_3_0._activityId = nil
end

function var_0_0.getActivityId(arg_4_0)
	arg_4_0._activityId = arg_4_0._activityId or VersionActivity2_4Enum.ActivityId.MusicGame

	return arg_4_0._activityId
end

function var_0_0.getConstValue(arg_5_0, arg_5_1)
	return Activity179Config.instance:getConstValue(arg_5_0:getActivityId(), arg_5_1)
end

function var_0_0.initEpisodeList(arg_6_0, arg_6_1)
	arg_6_0._episodeMap = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		arg_6_0:updateEpisode(iter_6_1)
	end
end

function var_0_0.updateEpisode(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._episodeMap[arg_7_1.episodeId] or Act179EpisodeMO.New()

	var_7_0:init(arg_7_1)

	arg_7_0._episodeMap[arg_7_1.episodeId] = var_7_0
end

function var_0_0.getEpisodeMo(arg_8_0, arg_8_1)
	return arg_8_0._episodeMap[arg_8_1]
end

function var_0_0.episodeIsFinished(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getEpisodeMo(arg_9_1)

	return var_9_0 and var_9_0.isFinished
end

function var_0_0.getCalibration(arg_10_0)
	local var_10_0 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.Activity179Calibration, 0)
	local var_10_1

	var_10_1 = tonumber(var_10_0) or 0

	return var_10_1 / 1000
end

function var_0_0.setCalibration(arg_11_0, arg_11_1)
	return PlayerPrefsHelper.setNumber(PlayerPrefsKey.Activity179Calibration, arg_11_1)
end

function var_0_0.clearSelectedEpisodeId(arg_12_0)
	arg_12_0._selectedEpisodeId = nil
end

function var_0_0.getSelectedEpisodeId(arg_13_0)
	arg_13_0._selectedEpisodeId = arg_13_0._selectedEpisodeId or GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_4MusicSelectEpisode, VersionActivity2_4MusicEnum.FirstEpisodeId)

	return arg_13_0._selectedEpisodeId
end

var_0_0.instance = var_0_0.New()

return var_0_0
