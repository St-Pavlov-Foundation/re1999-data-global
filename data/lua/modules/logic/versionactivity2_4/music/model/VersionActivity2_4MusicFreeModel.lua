module("modules.logic.versionactivity2_4.music.model.VersionActivity2_4MusicFreeModel", package.seeall)

slot0 = class("VersionActivity2_4MusicFreeModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._trackList = {}
	slot0._recordIndex = nil
	slot0._selectedTrackIndex = nil
end

function slot0.getMaxTrackCount(slot0)
	return slot0._maxTrackCount
end

function slot0.getTrackLength(slot0)
	return slot0._trackLength
end

function slot0.timeout(slot0, slot1)
	return slot0._trackLength <= slot1
end

function slot0.getTrackList(slot0)
	return slot0._trackList
end

function slot0.getTrackMo(slot0)
	return slot0._trackList[slot0._selectedTrackIndex]
end

function slot0.anyOneHasRecorded(slot0)
	for slot4, slot5 in pairs(slot0._trackList) do
		if slot5.recordTotalTime > 0 then
			return true
		end
	end

	return false
end

function slot0.getActionStatus(slot0)
	return slot0._actionStatus
end

function slot0.getAccompanyStatus(slot0)
	return slot0._accompanyStatus
end

function slot0.setActionStatus(slot0, slot1)
	slot0._actionStatus = slot1

	slot0:updateTrackListStatus()
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.ActionStatusChange)
end

function slot0.onEnd(slot0)
	TaskDispatcher.cancelTask(slot0._playBgm, slot0)
end

function slot0.onStart(slot0)
	VersionActivity2_4MusicController.instance:initBgm()

	slot0._maxTrackCount = Activity179Model.instance:getConstValue(VersionActivity2_4MusicEnum.Const.MaxTrackCount)
	slot0._trackLength = Activity179Model.instance:getConstValue(VersionActivity2_4MusicEnum.Const.TrackLength)
	slot0._actionStatus = VersionActivity2_4MusicEnum.ActionStatus.Record
	slot0._trackList = {}
	slot0._trackCount = 1

	slot0:_initTrackList()
	slot0:updateTrackListStatus()
	slot0:setInstrumentIndexList({
		1,
		2
	})

	slot1 = VersionActivity2_4MusicEnum.AccompanyStatus.Close
	slot0._accompanyStatus = slot0._accompanyStatus or {
		slot1,
		slot1,
		slot1
	}
	slot0._accompanyIcon = {
		"v2a4_bakaluoer_freeinstrument_icon_t_gu",
		"v2a4_bakaluoer_freeinstrument_icon_t_zhongyin",
		"v2a4_bakaluoer_freeinstrument_icon_t_gaoyin"
	}
	slot2 = false

	for slot6, slot7 in ipairs(slot0._accompanyStatus) do
		AudioMgr.instance:setRTPCValue(VersionActivity2_4MusicEnum.AccompanyTypeName[slot6], slot7)

		if slot7 == VersionActivity2_4MusicEnum.AccompanyStatus.Open then
			slot2 = true
		end
	end

	if slot2 then
		TaskDispatcher.cancelTask(slot0._playBgm, slot0)
		TaskDispatcher.runDelay(slot0._playBgm, slot0, 0.5)
	end
end

function slot0._playBgm(slot0)
	VersionActivity2_4MusicController.instance:playBgm(VersionActivity2_4MusicEnum.BgmPlay)
end

function slot0.onAccompanyStatusChange(slot0)
	if slot0:isRecordingOrPlaying() then
		return
	end

	slot1 = false

	for slot5, slot6 in ipairs(slot0._accompanyStatus) do
		if slot6 == VersionActivity2_4MusicEnum.AccompanyStatus.Open then
			slot1 = true
		end
	end

	if slot1 then
		if VersionActivity2_4MusicController.instance:bgmIsStop() then
			VersionActivity2_4MusicController.instance:playBgm(VersionActivity2_4MusicEnum.BgmPlay)
		end
	elseif VersionActivity2_4MusicController.instance:bgmIsPlay() then
		VersionActivity2_4MusicController.instance:stopBgm()
	end
end

function slot0._initTrackList(slot0)
	for slot4 = 1, slot0._maxTrackCount do
		slot0:_initTrack(slot4)
	end
end

function slot0._initTrack(slot0, slot1)
	slot2, slot3 = pcall(slot0._safeInitTrack, slot0, slot1)

	if not slot2 then
		logError(string.format("VersionActivity2_4MusicFreeModel:_initTrack index:%s error:%s", slot1, slot3))
	end
end

function slot0._safeInitTrack(slot0, slot1)
	if string.nilorempty(PlayerPrefsHelper.getString(slot0:_getTrackKey(slot1))) then
		return
	end

	if not cjson.decode(slot3) or not slot4.recordTotalTime or not slot4.mute or not slot4.timeline then
		return
	end

	slot5 = VersionActivity2_4MusicTrackMo.New()
	slot5.recordTotalTime = slot4.recordTotalTime
	slot5.mute = slot4.mute
	slot5.timeline = slot4.timeline
	slot5.index = slot1
	slot0._trackList[slot1] = slot5
	slot0._trackCount = slot1
end

function slot0.setAccompany(slot0, slot1, slot2)
	slot0._accompanyStatus[slot1] = slot2

	slot0:onAccompanyStatusChange()
end

function slot0.getAccompany(slot0, slot1)
	return slot0._accompanyStatus[slot1]
end

function slot0.getAccompanyIcon(slot0, slot1)
	return slot0._accompanyIcon[slot1]
end

function slot0.setInstrumentIndexList(slot0, slot1)
	slot0._instrumentIndexList = slot1
end

function slot0.getInstrumentIndexList(slot0)
	return slot0._instrumentIndexList
end

function slot0.addTrack(slot0)
	if slot0._maxTrackCount <= slot0._trackCount then
		return
	end

	slot0._trackCount = slot0._trackCount + 1

	slot0:setSelectedTrackIndex(slot0._trackCount)
	slot0:updateTrackListStatus()
end

function slot0.updateTrackListStatus(slot0)
	for slot4 = 1, slot0._maxTrackCount do
		(slot0._trackList[slot4] or VersionActivity2_4MusicTrackMo.New()).index = slot4

		if slot4 <= slot0._trackCount then
			slot5.status = VersionActivity2_4MusicEnum.TrackStatus.UnRecorded
		elseif slot4 == slot0._trackCount + 1 then
			slot5.status = VersionActivity2_4MusicEnum.TrackStatus.Add
		else
			slot5.status = VersionActivity2_4MusicEnum.TrackStatus.Inactive
		end

		if slot0._actionStatus == VersionActivity2_4MusicEnum.ActionStatus.Del then
			if slot5.status == VersionActivity2_4MusicEnum.TrackStatus.Add then
				slot5.status = VersionActivity2_4MusicEnum.TrackStatus.Inactive
			elseif slot5.status == VersionActivity2_4MusicEnum.TrackStatus.UnRecorded then
				slot5.status = VersionActivity2_4MusicEnum.TrackStatus.Del
			end
		end

		slot0._trackList[slot4] = slot5
	end
end

function slot0.delTrackSelected(slot0)
	slot1 = nil

	for slot5 = #slot0._trackList, 1, -1 do
		if slot0._trackList[slot5].isDelSelected then
			slot1 = slot5

			table.remove(slot0._trackList, slot5)

			slot0._trackCount = slot0._trackCount - 1
		end
	end

	if slot0._trackCount <= 0 then
		slot0._trackCount = 1
	end

	if slot1 then
		if slot1 <= slot0._selectedTrackIndex then
			slot0:setSelectedTrackIndex(1)
		end

		for slot5 = 1, slot0._maxTrackCount do
			if slot1 <= slot5 then
				if slot0._trackList[slot5] then
					slot6.index = slot5
				end

				slot0:_saveTrack(slot5)
			end
		end
	end

	slot0:setActionStatus(VersionActivity2_4MusicEnum.ActionStatus.Record)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.UpdateTrackList)
end

function slot0.getTrackSelectedNum(slot0)
	for slot5, slot6 in ipairs(slot0._trackList) do
		if slot6.isDelSelected then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.setSelectedTrackIndex(slot0, slot1)
	slot0._selectedTrackIndex = slot1

	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.UpdateSelectedTrackIndex)
end

function slot0.getSelectedTrackIndex(slot0)
	return slot0._selectedTrackIndex
end

function slot0.startRecord(slot0)
	slot0._recordIndex = slot0._selectedTrackIndex
	slot0._recordTimeline = {}
	slot0._recordProgressTime = 0
	slot0._playProgressIndex = {}
end

function slot0.endRecord(slot0)
	slot1 = slot0._trackList[slot0._recordIndex]
	slot1.recordTotalTime = slot0._recordProgressTime
	slot1.timeline = slot0._recordTimeline

	slot0:_saveTrack(slot0._recordIndex)
	VersionActivity2_4MusicController.instance:trackFreeView(slot0._recordProgressTime)

	slot0._recordProgressTime = 0
	slot0._recordIndex = nil
	slot0._recordTimeline = nil
end

function slot0._saveTrack(slot0, slot1)
	slot2, slot3 = pcall(slot0._safeSaveTrack, slot0, slot1)

	if not slot2 then
		logError(string.format("VersionActivity2_4MusicFreeModel:_saveTrack index:%s error:%s", slot1, slot3))
	end
end

function slot0._safeSaveTrack(slot0, slot1)
	if not slot0._trackList[slot1] then
		PlayerPrefsHelper.deleteKey(slot0:_getTrackKey(slot1))

		return
	end

	if not slot3:canSave() then
		PlayerPrefsHelper.deleteKey(slot2)
	else
		PlayerPrefsHelper.setString(slot2, slot3:encode())

		if SLFramework.FrameworkSettings.IsEditor then
			logNormal(string.format("VersionActivity2_4MusicFreeModel:_saveTrack index:%s str:%s", slot1, slot4))
		end
	end
end

function slot0._getTrackKey(slot0, slot1)
	return PlayerModel.instance:getPlayerPrefsKey(string.format("%s_track_%d#", PlayerPrefsKey.Activity179FreeView, slot1))
end

function slot0.startPlay(slot0)
	slot0._recordProgressTime = 0
	slot0._playProgressIndex = {}
end

function slot0.endPlay(slot0)
	slot0._recordProgressTime = 0
end

function slot0.playTrackList(slot0, slot1)
	slot3 = true

	for slot7, slot8 in pairs(slot0._trackList) do
		if not slot1 or not slot1[slot7] then
			slot9 = slot0._playProgressIndex[slot7] or 1
			slot11 = #slot8.timeline

			if slot0._recordProgressTime <= slot8.recordTotalTime then
				slot3 = false
			end

			if slot9 <= slot11 then
				for slot15 = slot9, slot11 do
					if slot10[slot15][1] <= slot2 then
						slot0._playProgressIndex[slot7] = slot9 + 1

						if slot8.mute == VersionActivity2_4MusicEnum.MuteStatus.Close then
							AudioMgr.instance:trigger(slot16[2])
						end
					else
						break
					end
				end
			end
		end
	end

	return slot3
end

function slot0.setStatus(slot0, slot1)
	slot0._status = slot1
end

function slot0.getStatus(slot0)
	return slot0._status
end

function slot0.isRecordingOrPlaying(slot0)
	return slot0._status == VersionActivity2_4MusicEnum.RecordStatus.Recording or slot0._status == VersionActivity2_4MusicEnum.RecordStatus.RecordReady or slot0._status == VersionActivity2_4MusicEnum.RecordStatus.RecordPause or slot0._status == VersionActivity2_4MusicEnum.RecordStatus.PlayPause or slot0._status == VersionActivity2_4MusicEnum.RecordStatus.Playing
end

function slot0.isRecordStatus(slot0)
	return slot0._status == VersionActivity2_4MusicEnum.RecordStatus.Recording or slot0._status == VersionActivity2_4MusicEnum.RecordStatus.RecordReady or slot0._status == VersionActivity2_4MusicEnum.RecordStatus.RecordPause
end

function slot0.isRecording(slot0)
	return slot0._status == VersionActivity2_4MusicEnum.RecordStatus.Recording
end

function slot0.isNormalStatus(slot0)
	return slot0._status == VersionActivity2_4MusicEnum.RecordStatus.Normal or slot0._status == VersionActivity2_4MusicEnum.RecordStatus.NormalAfterRecord
end

function slot0.setRecordProgressTime(slot0, slot1)
	slot0._recordProgressTime = math.min(math.floor(slot1 * 100) / 100, slot0._trackLength)
end

function slot0.addNote(slot0, slot1)
	if not slot0._recordTimeline then
		return
	end

	table.insert(slot0._recordTimeline, {
		slot0._recordProgressTime,
		slot1
	})
end

slot0.instance = slot0.New()

return slot0
