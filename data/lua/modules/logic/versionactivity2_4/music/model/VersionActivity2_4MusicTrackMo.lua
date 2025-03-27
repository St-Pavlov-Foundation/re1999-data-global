module("modules.logic.versionactivity2_4.music.model.VersionActivity2_4MusicTrackMo", package.seeall)

slot0 = class("VersionActivity2_4MusicTrackMo")

function slot0.ctor(slot0)
	slot0.index = nil
	slot0.status = VersionActivity2_4MusicEnum.TrackStatus.Inactive
	slot0.recordTotalTime = 0
	slot0.mute = VersionActivity2_4MusicEnum.MuteStatus.Close
	slot0.timeline = {}
end

function slot0.canSave(slot0)
	return slot0.recordTotalTime > 0
end

function slot0.encode(slot0)
	return cjson.encode({
		index = slot0.index,
		recordTotalTime = slot0.recordTotalTime,
		mute = slot0.mute,
		timeline = slot0.timeline
	})
end

function slot0.setMute(slot0, slot1)
	slot0.mute = not slot1 and VersionActivity2_4MusicEnum.MuteStatus.Close or VersionActivity2_4MusicEnum.MuteStatus.Open
end

function slot0.setDelSelected(slot0, slot1)
	slot0.isDelSelected = slot1
end

return slot0
