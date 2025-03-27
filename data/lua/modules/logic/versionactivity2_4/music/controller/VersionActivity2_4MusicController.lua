module("modules.logic.versionactivity2_4.music.controller.VersionActivity2_4MusicController", package.seeall)

slot0 = class("VersionActivity2_4MusicController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onEnterBeatView(slot0, slot1)
	slot0._episodeId = slot1
	slot0._enterBeatViewTime = Time.time
end

function slot0.trackBeatView(slot0, slot1, slot2, slot3)
	StatController.instance:track(StatEnum.EventName.Exit_Barcarola_activity, {
		[StatEnum.EventProperties.Bakaluoer_useTime] = math.floor(Time.time - slot0._enterBeatViewTime),
		[StatEnum.EventProperties.Bakaluoer_episodeId] = tostring(slot0._episodeId),
		[StatEnum.EventProperties.Bakaluoer_result] = VersionActivity2_4MusicEnum.BeatResultStatName[slot1],
		[StatEnum.EventProperties.Bakaluoer_activity_points] = slot2,
		[StatEnum.EventProperties.Bakaluoer_creation_result] = slot3
	})

	slot0._enterBeatViewTime = Time.time
end

function slot0.trackFreeView(slot0, slot1)
	StatController.instance:track(StatEnum.EventName.Barcarola_record, {
		[StatEnum.EventProperties.Bakaluoer_audio_duration] = slot1
	})
end

function slot0.openVersionActivity2_4MusicChapterView(slot0, slot1, slot2)
	Activity179Rpc.instance:sendGet179InfosRequest(Activity179Model.instance:getActivityId(), function (slot0, slot1, slot2)
		if slot1 ~= 0 then
			return
		end

		ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicChapterView, uv0, uv1)
	end)
end

function slot0.openVersionActivity2_4MusicTaskView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicTaskView, slot1, slot2)
end

function slot0.openVersionActivity2_4MusicFreeView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicFreeView, slot1, slot2)
end

function slot0.openVersionActivity2_4MusicBeatView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicBeatView, slot1, slot2)
end

function slot0.openVersionActivity2_4MusicFreeInstrumentSetView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicFreeInstrumentSetView, slot1, slot2)
end

function slot0.openVersionActivity2_4MusicFreeAccompanyView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicFreeAccompanyView, slot1, slot2)
end

function slot0.openVersionActivity2_4MusicFreeCalibrationView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicFreeCalibrationView, slot1, slot2)
end

function slot0.openVersionActivity2_4MusicFreeImmerseView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicFreeImmerseView, slot1, slot2)
end

function slot0.openVersionActivity2_4MusicBeatResultView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.VersionActivity2_4MusicBeatResultView, slot1, slot2)
end

function slot0.initBgm(slot0)
	slot0._bgmStatus = VersionActivity2_4MusicEnum.BgmStatus.Stop
end

function slot0.bgmIsPlay(slot0)
	return slot0._bgmStatus == VersionActivity2_4MusicEnum.BgmStatus.Play
end

function slot0.bgmIsStop(slot0)
	return slot0._bgmStatus == VersionActivity2_4MusicEnum.BgmStatus.Stop
end

function slot0.playBgm(slot0, slot1)
	if slot0._bgmStatus == VersionActivity2_4MusicEnum.BgmStatus.Play then
		logError("VersionActivity2_4MusicController Bgm is playing")

		return
	end

	if slot0._bgmStatus ~= VersionActivity2_4MusicEnum.BgmStatus.Stop then
		logError("VersionActivity2_4MusicController playBgm() Bgm is not stop")
	end

	slot0._bgmStatus = VersionActivity2_4MusicEnum.BgmStatus.Play

	AudioMgr.instance:trigger(slot1)
end

function slot0.pauseBgm(slot0)
	if slot0._bgmStatus == VersionActivity2_4MusicEnum.BgmStatus.Pause then
		return
	end

	if slot0._bgmStatus ~= VersionActivity2_4MusicEnum.BgmStatus.Play and slot0._bgmStatus ~= VersionActivity2_4MusicEnum.BgmStatus.Resume then
		logError("VersionActivity2_4MusicController pauseBgm() Bgm is not playing")
	end

	slot0._bgmStatus = VersionActivity2_4MusicEnum.BgmStatus.Pause

	AudioMgr.instance:trigger(VersionActivity2_4MusicEnum.BgmPause)
end

function slot0.resumeBgm(slot0)
	if slot0._bgmStatus == VersionActivity2_4MusicEnum.BgmStatus.Resume then
		logError("VersionActivity2_4MusicController Bgm is Resume playing")

		return
	end

	if slot0._bgmStatus ~= VersionActivity2_4MusicEnum.BgmStatus.Pause then
		logError("VersionActivity2_4MusicController resumeBgm() Bgm is not Pause")
	end

	slot0._bgmStatus = VersionActivity2_4MusicEnum.BgmStatus.Resume

	AudioMgr.instance:trigger(VersionActivity2_4MusicEnum.BgmResume)
end

function slot0.stopBgm(slot0)
	slot0._bgmStatus = VersionActivity2_4MusicEnum.BgmStatus.Stop

	AudioMgr.instance:trigger(VersionActivity2_4MusicEnum.BgmStop)
end

slot0.instance = slot0.New()

return slot0
