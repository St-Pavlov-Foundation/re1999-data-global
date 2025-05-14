module("modules.logic.versionactivity2_4.music.controller.VersionActivity2_4MusicController", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.onEnterBeatView(arg_5_0, arg_5_1)
	arg_5_0._episodeId = arg_5_1
	arg_5_0._enterBeatViewTime = Time.time
end

function var_0_0.trackBeatView(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = {
		[StatEnum.EventProperties.Bakaluoer_useTime] = math.floor(Time.time - arg_6_0._enterBeatViewTime),
		[StatEnum.EventProperties.Bakaluoer_episodeId] = tostring(arg_6_0._episodeId),
		[StatEnum.EventProperties.Bakaluoer_result] = VersionActivity2_4MusicEnum.BeatResultStatName[arg_6_1],
		[StatEnum.EventProperties.Bakaluoer_activity_points] = arg_6_2,
		[StatEnum.EventProperties.Bakaluoer_creation_result] = arg_6_3
	}

	StatController.instance:track(StatEnum.EventName.Exit_Barcarola_activity, var_6_0)

	arg_6_0._enterBeatViewTime = Time.time
end

function var_0_0.trackFreeView(arg_7_0, arg_7_1)
	local var_7_0 = {
		[StatEnum.EventProperties.Bakaluoer_audio_duration] = arg_7_1
	}

	StatController.instance:track(StatEnum.EventName.Barcarola_record, var_7_0)
end

function var_0_0.openVersionActivity2_4MusicChapterView(arg_8_0, arg_8_1, arg_8_2)
	Activity179Rpc.instance:sendGet179InfosRequest(Activity179Model.instance:getActivityId(), function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_1 ~= 0 then
			return
		end

		ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicChapterView, arg_8_1, arg_8_2)
	end)
end

function var_0_0.openVersionActivity2_4MusicTaskView(arg_10_0, arg_10_1, arg_10_2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicTaskView, arg_10_1, arg_10_2)
end

function var_0_0.openVersionActivity2_4MusicFreeView(arg_11_0, arg_11_1, arg_11_2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicFreeView, arg_11_1, arg_11_2)
end

function var_0_0.openVersionActivity2_4MusicBeatView(arg_12_0, arg_12_1, arg_12_2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicBeatView, arg_12_1, arg_12_2)
end

function var_0_0.openVersionActivity2_4MusicFreeInstrumentSetView(arg_13_0, arg_13_1, arg_13_2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicFreeInstrumentSetView, arg_13_1, arg_13_2)
end

function var_0_0.openVersionActivity2_4MusicFreeAccompanyView(arg_14_0, arg_14_1, arg_14_2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicFreeAccompanyView, arg_14_1, arg_14_2)
end

function var_0_0.openVersionActivity2_4MusicFreeCalibrationView(arg_15_0, arg_15_1, arg_15_2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicFreeCalibrationView, arg_15_1, arg_15_2)
end

function var_0_0.openVersionActivity2_4MusicFreeImmerseView(arg_16_0, arg_16_1, arg_16_2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicFreeImmerseView, arg_16_1, arg_16_2)
end

function var_0_0.openVersionActivity2_4MusicBeatResultView(arg_17_0, arg_17_1, arg_17_2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicBeatResultView, arg_17_1, arg_17_2)
end

function var_0_0.initBgm(arg_18_0)
	arg_18_0._bgmStatus = VersionActivity2_4MusicEnum.BgmStatus.Stop
end

function var_0_0.bgmIsPlay(arg_19_0)
	return arg_19_0._bgmStatus == VersionActivity2_4MusicEnum.BgmStatus.Play
end

function var_0_0.bgmIsStop(arg_20_0)
	return arg_20_0._bgmStatus == VersionActivity2_4MusicEnum.BgmStatus.Stop
end

function var_0_0.playBgm(arg_21_0, arg_21_1)
	if arg_21_0._bgmStatus == VersionActivity2_4MusicEnum.BgmStatus.Play then
		logError("VersionActivity2_4MusicController Bgm is playing")

		return
	end

	if arg_21_0._bgmStatus ~= VersionActivity2_4MusicEnum.BgmStatus.Stop then
		logError("VersionActivity2_4MusicController playBgm() Bgm is not stop")
	end

	arg_21_0._bgmStatus = VersionActivity2_4MusicEnum.BgmStatus.Play

	AudioMgr.instance:trigger(arg_21_1)
end

function var_0_0.pauseBgm(arg_22_0)
	if arg_22_0._bgmStatus == VersionActivity2_4MusicEnum.BgmStatus.Pause then
		return
	end

	if arg_22_0._bgmStatus ~= VersionActivity2_4MusicEnum.BgmStatus.Play and arg_22_0._bgmStatus ~= VersionActivity2_4MusicEnum.BgmStatus.Resume then
		logError("VersionActivity2_4MusicController pauseBgm() Bgm is not playing")
	end

	arg_22_0._bgmStatus = VersionActivity2_4MusicEnum.BgmStatus.Pause

	AudioMgr.instance:trigger(VersionActivity2_4MusicEnum.BgmPause)
end

function var_0_0.resumeBgm(arg_23_0)
	if arg_23_0._bgmStatus == VersionActivity2_4MusicEnum.BgmStatus.Resume then
		logError("VersionActivity2_4MusicController Bgm is Resume playing")

		return
	end

	if arg_23_0._bgmStatus ~= VersionActivity2_4MusicEnum.BgmStatus.Pause then
		logError("VersionActivity2_4MusicController resumeBgm() Bgm is not Pause")
	end

	arg_23_0._bgmStatus = VersionActivity2_4MusicEnum.BgmStatus.Resume

	AudioMgr.instance:trigger(VersionActivity2_4MusicEnum.BgmResume)
end

function var_0_0.stopBgm(arg_24_0)
	arg_24_0._bgmStatus = VersionActivity2_4MusicEnum.BgmStatus.Stop

	AudioMgr.instance:trigger(VersionActivity2_4MusicEnum.BgmStop)
end

var_0_0.instance = var_0_0.New()

return var_0_0
