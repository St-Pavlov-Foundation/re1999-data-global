module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeTrackItem", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicFreeTrackItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._imageslider = gohelper.findChildImage(arg_1_0.viewGO, "#go_normal/#image_slider")
	arg_1_0._txtnum1 = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_num1")
	arg_1_0._txttime1 = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_time1")
	arg_1_0._godelstate = gohelper.findChild(arg_1_0.viewGO, "#go_delstate")
	arg_1_0._txtnum3 = gohelper.findChildText(arg_1_0.viewGO, "#go_delstate/#txt_num3")
	arg_1_0._txttime3 = gohelper.findChildText(arg_1_0.viewGO, "#go_delstate/#txt_time3")
	arg_1_0._goadd = gohelper.findChild(arg_1_0.viewGO, "#go_add")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._gorecorded = gohelper.findChild(arg_1_0.viewGO, "#go_recorded")
	arg_1_0._imagerecordbg = gohelper.findChildImage(arg_1_0.viewGO, "#go_recorded/#image_recordbg")
	arg_1_0._txtnum2 = gohelper.findChildText(arg_1_0.viewGO, "#go_recorded/#txt_num2")
	arg_1_0._txttime2 = gohelper.findChildText(arg_1_0.viewGO, "#go_recorded/#txt_time2")
	arg_1_0._btnmute = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_recorded/rightbtn/#btn_mute")
	arg_1_0._btnunmute = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_recorded/rightbtn/#btn__unmute")
	arg_1_0._goselectframe = gohelper.findChild(arg_1_0.viewGO, "#go_selectframe")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnmute:AddClickListener(arg_2_0._btnmuteOnClick, arg_2_0)
	arg_2_0._btnunmute:AddClickListener(arg_2_0._btnunmuteOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnmute:RemoveClickListener()
	arg_3_0._btnunmute:RemoveClickListener()
end

function var_0_0._btnmuteOnClick(arg_4_0)
	arg_4_0:_updateMuteStatus(true)
end

function var_0_0._btnunmuteOnClick(arg_5_0)
	arg_5_0:_updateMuteStatus(false)
end

function var_0_0._btnclickOnClick(arg_6_0)
	if arg_6_0._isRecord or arg_6_0._isPlay then
		return
	end

	if arg_6_0._isDelStatus then
		arg_6_0._mo:setDelSelected(not arg_6_0._mo.isDelSelected)
		arg_6_0:updateSelected()
		VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.TrackDelSelectedChange)

		return
	end

	if arg_6_0._isAddStatus then
		VersionActivity2_4MusicFreeModel.instance:addTrack()
		VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.UpdateTrackList)

		return
	end

	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.ClickTrackItem, arg_6_0._index)
end

function var_0_0._editableInitView(arg_7_0)
	gohelper.setActive(arg_7_0._goselectframe, false)
end

function var_0_0._editableAddEvents(arg_8_0)
	arg_8_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.StartRecord, arg_8_0._onStartRecord, arg_8_0, LuaEventSystem.Low)
	arg_8_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.EndRecord, arg_8_0._onEndRecord, arg_8_0, LuaEventSystem.Low)
	arg_8_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordPause, arg_8_0._onRecordPause, arg_8_0, LuaEventSystem.Low)
	arg_8_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordContinue, arg_8_0._onRecordContinue, arg_8_0, LuaEventSystem.Low)
	arg_8_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.StartPlay, arg_8_0._onStartPlay, arg_8_0, LuaEventSystem.Low)
	arg_8_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.EndPlay, arg_8_0._onEndPlay, arg_8_0, LuaEventSystem.Low)
end

function var_0_0._onStartPlay(arg_9_0)
	arg_9_0._isPlay = true

	arg_9_0:_updateStatus()

	if arg_9_0._mo.recordTotalTime > 0 then
		arg_9_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.PlayFrame, arg_9_0._onPlayFrame, arg_9_0)
	end
end

function var_0_0._onEndPlay(arg_10_0)
	arg_10_0._isPlay = false

	arg_10_0:_updateStatus()
	arg_10_0:removeEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.PlayFrame, arg_10_0._onPlayFrame, arg_10_0)
end

function var_0_0._onPlayFrame(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._mo.recordTotalTime

	if var_11_0 <= arg_11_1 then
		arg_11_0:removeEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.PlayFrame, arg_11_0._onPlayFrame, arg_11_0)
	end

	local var_11_1 = arg_11_1 / var_11_0

	arg_11_0._imagerecordbg.fillAmount = var_11_1

	local var_11_2 = math.ceil(var_11_0 - arg_11_1)

	if var_11_0 < var_11_2 then
		var_11_2 = math.floor(var_11_0)
	end

	if var_11_2 <= 0 then
		var_11_2 = 0
	end

	arg_11_0._txttime2.text = string.format("%s", TimeUtil.second2TimeString(var_11_2))
end

function var_0_0._onStartRecord(arg_12_0)
	arg_12_0._isRecord = true

	arg_12_0:_updateStatus()

	if arg_12_0._isSelected then
		arg_12_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordFrame, arg_12_0._onRecordFrame, arg_12_0)

		return
	end

	if arg_12_0._mo.recordTotalTime > 0 then
		arg_12_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordFrame, arg_12_0._onPlayFrame, arg_12_0)
	end
end

function var_0_0._onEndRecord(arg_13_0)
	arg_13_0._isRecord = false

	arg_13_0:_updateStatus()
	arg_13_0:removeEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordFrame, arg_13_0._onRecordFrame, arg_13_0)
	arg_13_0:removeEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordFrame, arg_13_0._onPlayFrame, arg_13_0)
end

function var_0_0._onRecordPause(arg_14_0)
	return
end

function var_0_0._onRecordContinue(arg_15_0)
	return
end

function var_0_0._onRecordFrame(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1 / arg_16_0._trackLengthConst

	arg_16_0._imageslider.fillAmount = var_16_0
	arg_16_0._txttime1.text = string.format("%s/%s", TimeUtil.second2TimeString(arg_16_1), arg_16_0._trackLengthConstStr)
end

function var_0_0._editableRemoveEvents(arg_17_0)
	return
end

function var_0_0.onUpdateMO(arg_18_0, arg_18_1)
	arg_18_0._mo = arg_18_1
	arg_18_0._index = arg_18_0._mo.index
	arg_18_0._trackLengthConst = VersionActivity2_4MusicFreeModel.instance:getTrackLength()
	arg_18_0._trackLengthConstStr = TimeUtil.second2TimeString(arg_18_0._trackLengthConst)

	arg_18_0:_updateStatus()
	arg_18_0:_updateName(GameUtil.getRomanNums(arg_18_0._index))
end

function var_0_0._updateStatus(arg_19_0)
	local var_19_0 = arg_19_0._mo.status

	if var_19_0 == VersionActivity2_4MusicEnum.TrackStatus.Inactive then
		gohelper.setActive(arg_19_0.viewGO, false)

		return
	end

	arg_19_0._isAddStatus = var_19_0 == VersionActivity2_4MusicEnum.TrackStatus.Add

	if arg_19_0._isRecord and arg_19_0._isAddStatus then
		gohelper.setActive(arg_19_0.viewGO, false)

		return
	end

	local var_19_1 = arg_19_0._index == VersionActivity2_4MusicFreeModel.instance:getSelectedTrackIndex()

	gohelper.setActive(arg_19_0.viewGO, true)

	arg_19_0._isUnRecorded = var_19_0 == VersionActivity2_4MusicEnum.TrackStatus.UnRecorded
	arg_19_0._isDelStatus = var_19_0 == VersionActivity2_4MusicEnum.TrackStatus.Del
	arg_19_0._isFinishedStatus = arg_19_0._mo.recordTotalTime > 0

	if var_19_1 and arg_19_0._isRecord and arg_19_0._isUnRecorded then
		arg_19_0._isFinishedStatus = false
	end

	if arg_19_0._isDelStatus then
		arg_19_0._isFinishedStatus = false
	end

	if arg_19_0._isFinishedStatus then
		arg_19_0._isUnRecorded = false
	end

	gohelper.setActive(arg_19_0._goadd, arg_19_0._isAddStatus)
	gohelper.setActive(arg_19_0._godelstate, arg_19_0._isDelStatus)
	gohelper.setActive(arg_19_0._gonormal, arg_19_0._isUnRecorded)
	gohelper.setActive(arg_19_0._gorecorded, arg_19_0._isFinishedStatus)

	if arg_19_0._isUnRecorded then
		local var_19_2 = arg_19_0._mo.recordTotalTime / arg_19_0._trackLengthConst

		arg_19_0._imageslider.fillAmount = var_19_2
		arg_19_0._txttime1.text = string.format("%s/%s", TimeUtil.second2TimeString(arg_19_0._mo.recordTotalTime), arg_19_0._trackLengthConstStr)
	end

	arg_19_0._mo:setDelSelected(false)

	if arg_19_0._isDelStatus then
		arg_19_0._txttime3.text = string.format("%s/%s", TimeUtil.second2TimeString(arg_19_0._mo.recordTotalTime), arg_19_0._trackLengthConstStr)
	end

	if arg_19_0._isFinishedStatus then
		local var_19_3 = 1

		arg_19_0._imagerecordbg.fillAmount = var_19_3
		arg_19_0._txttime2.text = TimeUtil.second2TimeString(arg_19_0._mo.recordTotalTime)

		arg_19_0:_updateMuteStatus(arg_19_0._mo.mute == VersionActivity2_4MusicEnum.MuteStatus.Open)
	end

	arg_19_0:updateSelected()
end

function var_0_0._updateMuteStatus(arg_20_0, arg_20_1)
	gohelper.setActive(arg_20_0._btnmute, not arg_20_1)
	gohelper.setActive(arg_20_0._btnunmute, arg_20_1)
	arg_20_0._mo:setMute(arg_20_1)
end

function var_0_0._updateName(arg_21_0, arg_21_1)
	arg_21_0._txtnum1.text = arg_21_1
	arg_21_0._txtnum2.text = arg_21_1
	arg_21_0._txtnum3.text = arg_21_1
end

function var_0_0.updateSelected(arg_22_0)
	if arg_22_0._isDelStatus then
		arg_22_0._isSelected = nil

		gohelper.setActive(arg_22_0._goselectframe, arg_22_0._mo.isDelSelected)

		return
	end

	arg_22_0._isSelected = arg_22_0._index == VersionActivity2_4MusicFreeModel.instance:getSelectedTrackIndex()

	if arg_22_0._isPlay then
		arg_22_0._isSelected = false
	end

	gohelper.setActive(arg_22_0._goselectframe, arg_22_0._isSelected)
end

function var_0_0.onDestroyView(arg_23_0)
	return
end

return var_0_0
