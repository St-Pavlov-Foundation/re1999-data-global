module("modules.logic.versionactivity2_4.music.model.VersionActivity2_4MusicFreeModel", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicFreeModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._trackList = {}
	arg_2_0._recordIndex = nil
	arg_2_0._selectedTrackIndex = nil
end

function var_0_0.getMaxTrackCount(arg_3_0)
	return arg_3_0._maxTrackCount
end

function var_0_0.getTrackLength(arg_4_0)
	return arg_4_0._trackLength
end

function var_0_0.timeout(arg_5_0, arg_5_1)
	return arg_5_1 >= arg_5_0._trackLength
end

function var_0_0.getTrackList(arg_6_0)
	return arg_6_0._trackList
end

function var_0_0.getTrackMo(arg_7_0)
	return arg_7_0._trackList[arg_7_0._selectedTrackIndex]
end

function var_0_0.anyOneHasRecorded(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._trackList) do
		if iter_8_1.recordTotalTime > 0 then
			return true
		end
	end

	return false
end

function var_0_0.getActionStatus(arg_9_0)
	return arg_9_0._actionStatus
end

function var_0_0.getAccompanyStatus(arg_10_0)
	return arg_10_0._accompanyStatus
end

function var_0_0.setActionStatus(arg_11_0, arg_11_1)
	arg_11_0._actionStatus = arg_11_1

	arg_11_0:updateTrackListStatus()
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.ActionStatusChange)
end

function var_0_0.onEnd(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._playBgm, arg_12_0)
end

function var_0_0.onStart(arg_13_0)
	VersionActivity2_4MusicController.instance:initBgm()

	arg_13_0._maxTrackCount = Activity179Model.instance:getConstValue(VersionActivity2_4MusicEnum.Const.MaxTrackCount)
	arg_13_0._trackLength = Activity179Model.instance:getConstValue(VersionActivity2_4MusicEnum.Const.TrackLength)
	arg_13_0._actionStatus = VersionActivity2_4MusicEnum.ActionStatus.Record
	arg_13_0._trackList = {}
	arg_13_0._trackCount = 1

	arg_13_0:_initTrackList()
	arg_13_0:updateTrackListStatus()
	arg_13_0:setInstrumentIndexList({
		1,
		2
	})

	local var_13_0 = VersionActivity2_4MusicEnum.AccompanyStatus.Close

	arg_13_0._accompanyStatus = arg_13_0._accompanyStatus or {
		var_13_0,
		var_13_0,
		var_13_0
	}
	arg_13_0._accompanyIcon = {
		"v2a4_bakaluoer_freeinstrument_icon_t_gu",
		"v2a4_bakaluoer_freeinstrument_icon_t_zhongyin",
		"v2a4_bakaluoer_freeinstrument_icon_t_gaoyin"
	}

	local var_13_1 = false

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._accompanyStatus) do
		AudioMgr.instance:setRTPCValue(VersionActivity2_4MusicEnum.AccompanyTypeName[iter_13_0], iter_13_1)

		if iter_13_1 == VersionActivity2_4MusicEnum.AccompanyStatus.Open then
			var_13_1 = true
		end
	end

	if var_13_1 then
		TaskDispatcher.cancelTask(arg_13_0._playBgm, arg_13_0)
		TaskDispatcher.runDelay(arg_13_0._playBgm, arg_13_0, 0.5)
	end
end

function var_0_0._playBgm(arg_14_0)
	VersionActivity2_4MusicController.instance:playBgm(VersionActivity2_4MusicEnum.BgmPlay)
end

function var_0_0.onAccompanyStatusChange(arg_15_0)
	if arg_15_0:isRecordingOrPlaying() then
		return
	end

	local var_15_0 = false

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._accompanyStatus) do
		if iter_15_1 == VersionActivity2_4MusicEnum.AccompanyStatus.Open then
			var_15_0 = true
		end
	end

	if var_15_0 then
		if VersionActivity2_4MusicController.instance:bgmIsStop() then
			VersionActivity2_4MusicController.instance:playBgm(VersionActivity2_4MusicEnum.BgmPlay)
		end
	elseif VersionActivity2_4MusicController.instance:bgmIsPlay() then
		VersionActivity2_4MusicController.instance:stopBgm()
	end
end

function var_0_0._initTrackList(arg_16_0)
	for iter_16_0 = 1, arg_16_0._maxTrackCount do
		arg_16_0:_initTrack(iter_16_0)
	end
end

function var_0_0._initTrack(arg_17_0, arg_17_1)
	local var_17_0, var_17_1 = pcall(arg_17_0._safeInitTrack, arg_17_0, arg_17_1)

	if not var_17_0 then
		logError(string.format("VersionActivity2_4MusicFreeModel:_initTrack index:%s error:%s", arg_17_1, var_17_1))
	end
end

function var_0_0._safeInitTrack(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:_getTrackKey(arg_18_1)
	local var_18_1 = PlayerPrefsHelper.getString(var_18_0)

	if string.nilorempty(var_18_1) then
		return
	end

	local var_18_2 = cjson.decode(var_18_1)

	if not var_18_2 or not var_18_2.recordTotalTime or not var_18_2.mute or not var_18_2.timeline then
		return
	end

	local var_18_3 = VersionActivity2_4MusicTrackMo.New()

	var_18_3.recordTotalTime = var_18_2.recordTotalTime
	var_18_3.mute = var_18_2.mute
	var_18_3.timeline = var_18_2.timeline
	var_18_3.index = arg_18_1
	arg_18_0._trackList[arg_18_1] = var_18_3
	arg_18_0._trackCount = arg_18_1
end

function var_0_0.setAccompany(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0._accompanyStatus[arg_19_1] = arg_19_2

	arg_19_0:onAccompanyStatusChange()
end

function var_0_0.getAccompany(arg_20_0, arg_20_1)
	return arg_20_0._accompanyStatus[arg_20_1]
end

function var_0_0.getAccompanyIcon(arg_21_0, arg_21_1)
	return arg_21_0._accompanyIcon[arg_21_1]
end

function var_0_0.setInstrumentIndexList(arg_22_0, arg_22_1)
	arg_22_0._instrumentIndexList = arg_22_1
end

function var_0_0.getInstrumentIndexList(arg_23_0)
	return arg_23_0._instrumentIndexList
end

function var_0_0.addTrack(arg_24_0)
	if arg_24_0._trackCount >= arg_24_0._maxTrackCount then
		return
	end

	arg_24_0._trackCount = arg_24_0._trackCount + 1

	arg_24_0:setSelectedTrackIndex(arg_24_0._trackCount)
	arg_24_0:updateTrackListStatus()
end

function var_0_0.updateTrackListStatus(arg_25_0)
	for iter_25_0 = 1, arg_25_0._maxTrackCount do
		local var_25_0 = arg_25_0._trackList[iter_25_0] or VersionActivity2_4MusicTrackMo.New()

		var_25_0.index = iter_25_0

		if iter_25_0 <= arg_25_0._trackCount then
			var_25_0.status = VersionActivity2_4MusicEnum.TrackStatus.UnRecorded
		elseif iter_25_0 == arg_25_0._trackCount + 1 then
			var_25_0.status = VersionActivity2_4MusicEnum.TrackStatus.Add
		else
			var_25_0.status = VersionActivity2_4MusicEnum.TrackStatus.Inactive
		end

		if arg_25_0._actionStatus == VersionActivity2_4MusicEnum.ActionStatus.Del then
			if var_25_0.status == VersionActivity2_4MusicEnum.TrackStatus.Add then
				var_25_0.status = VersionActivity2_4MusicEnum.TrackStatus.Inactive
			elseif var_25_0.status == VersionActivity2_4MusicEnum.TrackStatus.UnRecorded then
				var_25_0.status = VersionActivity2_4MusicEnum.TrackStatus.Del
			end
		end

		arg_25_0._trackList[iter_25_0] = var_25_0
	end
end

function var_0_0.delTrackSelected(arg_26_0)
	local var_26_0

	for iter_26_0 = #arg_26_0._trackList, 1, -1 do
		if arg_26_0._trackList[iter_26_0].isDelSelected then
			var_26_0 = iter_26_0

			table.remove(arg_26_0._trackList, iter_26_0)

			arg_26_0._trackCount = arg_26_0._trackCount - 1
		end
	end

	if arg_26_0._trackCount <= 0 then
		arg_26_0._trackCount = 1
	end

	if var_26_0 then
		if var_26_0 <= arg_26_0._selectedTrackIndex then
			arg_26_0:setSelectedTrackIndex(1)
		end

		for iter_26_1 = 1, arg_26_0._maxTrackCount do
			if var_26_0 <= iter_26_1 then
				local var_26_1 = arg_26_0._trackList[iter_26_1]

				if var_26_1 then
					var_26_1.index = iter_26_1
				end

				arg_26_0:_saveTrack(iter_26_1)
			end
		end
	end

	arg_26_0:setActionStatus(VersionActivity2_4MusicEnum.ActionStatus.Record)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.UpdateTrackList)
end

function var_0_0.getTrackSelectedNum(arg_27_0)
	local var_27_0 = 0

	for iter_27_0, iter_27_1 in ipairs(arg_27_0._trackList) do
		if iter_27_1.isDelSelected then
			var_27_0 = var_27_0 + 1
		end
	end

	return var_27_0
end

function var_0_0.setSelectedTrackIndex(arg_28_0, arg_28_1)
	arg_28_0._selectedTrackIndex = arg_28_1

	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.UpdateSelectedTrackIndex)
end

function var_0_0.getSelectedTrackIndex(arg_29_0)
	return arg_29_0._selectedTrackIndex
end

function var_0_0.startRecord(arg_30_0)
	arg_30_0._recordIndex = arg_30_0._selectedTrackIndex
	arg_30_0._recordTimeline = {}
	arg_30_0._recordProgressTime = 0
	arg_30_0._playProgressIndex = {}
end

function var_0_0.endRecord(arg_31_0)
	local var_31_0 = arg_31_0._trackList[arg_31_0._recordIndex]

	var_31_0.recordTotalTime = arg_31_0._recordProgressTime
	var_31_0.timeline = arg_31_0._recordTimeline

	arg_31_0:_saveTrack(arg_31_0._recordIndex)
	VersionActivity2_4MusicController.instance:trackFreeView(arg_31_0._recordProgressTime)

	arg_31_0._recordProgressTime = 0
	arg_31_0._recordIndex = nil
	arg_31_0._recordTimeline = nil
end

function var_0_0._saveTrack(arg_32_0, arg_32_1)
	local var_32_0, var_32_1 = pcall(arg_32_0._safeSaveTrack, arg_32_0, arg_32_1)

	if not var_32_0 then
		logError(string.format("VersionActivity2_4MusicFreeModel:_saveTrack index:%s error:%s", arg_32_1, var_32_1))
	end
end

function var_0_0._safeSaveTrack(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:_getTrackKey(arg_33_1)
	local var_33_1 = arg_33_0._trackList[arg_33_1]

	if not var_33_1 then
		PlayerPrefsHelper.deleteKey(var_33_0)

		return
	end

	if not var_33_1:canSave() then
		PlayerPrefsHelper.deleteKey(var_33_0)
	else
		local var_33_2 = var_33_1:encode()

		PlayerPrefsHelper.setString(var_33_0, var_33_2)

		if SLFramework.FrameworkSettings.IsEditor then
			logNormal(string.format("VersionActivity2_4MusicFreeModel:_saveTrack index:%s str:%s", arg_33_1, var_33_2))
		end
	end
end

function var_0_0._getTrackKey(arg_34_0, arg_34_1)
	local var_34_0 = string.format("%s_track_%d#", PlayerPrefsKey.Activity179FreeView, arg_34_1)

	return PlayerModel.instance:getPlayerPrefsKey(var_34_0)
end

function var_0_0.startPlay(arg_35_0)
	arg_35_0._recordProgressTime = 0
	arg_35_0._playProgressIndex = {}
end

function var_0_0.endPlay(arg_36_0)
	arg_36_0._recordProgressTime = 0
end

function var_0_0.playTrackList(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0._recordProgressTime
	local var_37_1 = true

	for iter_37_0, iter_37_1 in pairs(arg_37_0._trackList) do
		if not arg_37_1 or not arg_37_1[iter_37_0] then
			local var_37_2 = arg_37_0._playProgressIndex[iter_37_0] or 1
			local var_37_3 = iter_37_1.timeline
			local var_37_4 = #var_37_3

			if var_37_0 <= iter_37_1.recordTotalTime then
				var_37_1 = false
			end

			if var_37_2 <= var_37_4 then
				for iter_37_2 = var_37_2, var_37_4 do
					local var_37_5 = var_37_3[iter_37_2]

					if var_37_0 >= var_37_5[1] then
						arg_37_0._playProgressIndex[iter_37_0] = var_37_2 + 1

						if iter_37_1.mute == VersionActivity2_4MusicEnum.MuteStatus.Close then
							AudioMgr.instance:trigger(var_37_5[2])
						end
					else
						break
					end
				end
			end
		end
	end

	return var_37_1
end

function var_0_0.setStatus(arg_38_0, arg_38_1)
	arg_38_0._status = arg_38_1
end

function var_0_0.getStatus(arg_39_0)
	return arg_39_0._status
end

function var_0_0.isRecordingOrPlaying(arg_40_0)
	return arg_40_0._status == VersionActivity2_4MusicEnum.RecordStatus.Recording or arg_40_0._status == VersionActivity2_4MusicEnum.RecordStatus.RecordReady or arg_40_0._status == VersionActivity2_4MusicEnum.RecordStatus.RecordPause or arg_40_0._status == VersionActivity2_4MusicEnum.RecordStatus.PlayPause or arg_40_0._status == VersionActivity2_4MusicEnum.RecordStatus.Playing
end

function var_0_0.isRecordStatus(arg_41_0)
	return arg_41_0._status == VersionActivity2_4MusicEnum.RecordStatus.Recording or arg_41_0._status == VersionActivity2_4MusicEnum.RecordStatus.RecordReady or arg_41_0._status == VersionActivity2_4MusicEnum.RecordStatus.RecordPause
end

function var_0_0.isRecording(arg_42_0)
	return arg_42_0._status == VersionActivity2_4MusicEnum.RecordStatus.Recording
end

function var_0_0.isNormalStatus(arg_43_0)
	return arg_43_0._status == VersionActivity2_4MusicEnum.RecordStatus.Normal or arg_43_0._status == VersionActivity2_4MusicEnum.RecordStatus.NormalAfterRecord
end

function var_0_0.setRecordProgressTime(arg_44_0, arg_44_1)
	arg_44_1 = math.floor(arg_44_1 * 100) / 100
	arg_44_0._recordProgressTime = math.min(arg_44_1, arg_44_0._trackLength)
end

function var_0_0.addNote(arg_45_0, arg_45_1)
	if not arg_45_0._recordTimeline then
		return
	end

	table.insert(arg_45_0._recordTimeline, {
		arg_45_0._recordProgressTime,
		arg_45_1
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
