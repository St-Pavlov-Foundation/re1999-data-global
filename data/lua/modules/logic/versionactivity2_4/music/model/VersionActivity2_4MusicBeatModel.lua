module("modules.logic.versionactivity2_4.music.model.VersionActivity2_4MusicBeatModel", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicBeatModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	VersionActivity2_4MusicController.instance:initBgm()

	arg_3_0._episodeId = arg_3_1

	local var_3_0, var_3_1 = Activity179Model.instance:getConstValue(VersionActivity2_4MusicEnum.Const.Score)

	arg_3_0._scoreList = string.splitToNumber(var_3_1, "#")

	local var_3_2, var_3_3 = Activity179Model.instance:getConstValue(VersionActivity2_4MusicEnum.Const.ScoreTime)
	local var_3_4 = GameUtil.splitString2(var_3_3, true, "|", "#")

	arg_3_0._scoreShowTimeList = var_3_4[1]
	arg_3_0._scoreTimeList = {}
	arg_3_0._scoreTimeList[VersionActivity2_4MusicEnum.BeatGrade.Perfect] = var_3_4[2]
	arg_3_0._scoreTimeList[VersionActivity2_4MusicEnum.BeatGrade.Great] = var_3_4[3]
	arg_3_0._scoreTimeList[VersionActivity2_4MusicEnum.BeatGrade.Cool] = var_3_4[1]
	arg_3_0._successCount = 0
end

function var_0_0.getSuccessCount(arg_4_0)
	return arg_4_0._successCount
end

function var_0_0.setSuccessCount(arg_5_0, arg_5_1)
	arg_5_0._successCount = arg_5_1
end

function var_0_0.getEpisodeId(arg_6_0)
	return arg_6_0._episodeId
end

function var_0_0.updateGradleList(arg_7_0, arg_7_1)
	arg_7_0._gradeList = arg_7_1
end

function var_0_0.getGradleList(arg_8_0)
	return arg_8_0._gradeList or {}
end

function var_0_0.getShowTime(arg_9_0)
	return arg_9_0._scoreShowTimeList[1]
end

function var_0_0.getHideTime(arg_10_0)
	return arg_10_0._scoreShowTimeList[2]
end

function var_0_0.getScoreTimeList(arg_11_0)
	return arg_11_0._scoreTimeList
end

function var_0_0.getGradeScore(arg_12_0, arg_12_1)
	return arg_12_0._scoreList and arg_12_0._scoreList[arg_12_1] or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
