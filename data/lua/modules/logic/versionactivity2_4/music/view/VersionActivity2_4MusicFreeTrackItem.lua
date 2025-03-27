module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeTrackItem", package.seeall)

slot0 = class("VersionActivity2_4MusicFreeTrackItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._imageslider = gohelper.findChildImage(slot0.viewGO, "#go_normal/#image_slider")
	slot0._txtnum1 = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_num1")
	slot0._txttime1 = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_time1")
	slot0._godelstate = gohelper.findChild(slot0.viewGO, "#go_delstate")
	slot0._txtnum3 = gohelper.findChildText(slot0.viewGO, "#go_delstate/#txt_num3")
	slot0._txttime3 = gohelper.findChildText(slot0.viewGO, "#go_delstate/#txt_time3")
	slot0._goadd = gohelper.findChild(slot0.viewGO, "#go_add")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._gorecorded = gohelper.findChild(slot0.viewGO, "#go_recorded")
	slot0._imagerecordbg = gohelper.findChildImage(slot0.viewGO, "#go_recorded/#image_recordbg")
	slot0._txtnum2 = gohelper.findChildText(slot0.viewGO, "#go_recorded/#txt_num2")
	slot0._txttime2 = gohelper.findChildText(slot0.viewGO, "#go_recorded/#txt_time2")
	slot0._btnmute = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_recorded/rightbtn/#btn_mute")
	slot0._btnunmute = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_recorded/rightbtn/#btn__unmute")
	slot0._goselectframe = gohelper.findChild(slot0.viewGO, "#go_selectframe")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnmute:AddClickListener(slot0._btnmuteOnClick, slot0)
	slot0._btnunmute:AddClickListener(slot0._btnunmuteOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnmute:RemoveClickListener()
	slot0._btnunmute:RemoveClickListener()
end

function slot0._btnmuteOnClick(slot0)
	slot0:_updateMuteStatus(true)
end

function slot0._btnunmuteOnClick(slot0)
	slot0:_updateMuteStatus(false)
end

function slot0._btnclickOnClick(slot0)
	if slot0._isRecord or slot0._isPlay then
		return
	end

	if slot0._isDelStatus then
		slot0._mo:setDelSelected(not slot0._mo.isDelSelected)
		slot0:updateSelected()
		VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.TrackDelSelectedChange)

		return
	end

	if slot0._isAddStatus then
		VersionActivity2_4MusicFreeModel.instance:addTrack()
		VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.UpdateTrackList)

		return
	end

	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.ClickTrackItem, slot0._index)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goselectframe, false)
end

function slot0._editableAddEvents(slot0)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.StartRecord, slot0._onStartRecord, slot0, LuaEventSystem.Low)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.EndRecord, slot0._onEndRecord, slot0, LuaEventSystem.Low)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordPause, slot0._onRecordPause, slot0, LuaEventSystem.Low)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordContinue, slot0._onRecordContinue, slot0, LuaEventSystem.Low)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.StartPlay, slot0._onStartPlay, slot0, LuaEventSystem.Low)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.EndPlay, slot0._onEndPlay, slot0, LuaEventSystem.Low)
end

function slot0._onStartPlay(slot0)
	slot0._isPlay = true

	slot0:_updateStatus()

	if slot0._mo.recordTotalTime > 0 then
		slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.PlayFrame, slot0._onPlayFrame, slot0)
	end
end

function slot0._onEndPlay(slot0)
	slot0._isPlay = false

	slot0:_updateStatus()
	slot0:removeEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.PlayFrame, slot0._onPlayFrame, slot0)
end

function slot0._onPlayFrame(slot0, slot1)
	if slot0._mo.recordTotalTime <= slot1 then
		slot0:removeEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.PlayFrame, slot0._onPlayFrame, slot0)
	end

	slot0._imagerecordbg.fillAmount = slot1 / slot2

	if slot2 < math.ceil(slot2 - slot1) then
		slot4 = math.floor(slot2)
	end

	if slot4 <= 0 then
		slot4 = 0
	end

	slot0._txttime2.text = string.format("%s", TimeUtil.second2TimeString(slot4))
end

function slot0._onStartRecord(slot0)
	slot0._isRecord = true

	slot0:_updateStatus()

	if slot0._isSelected then
		slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordFrame, slot0._onRecordFrame, slot0)

		return
	end

	if slot0._mo.recordTotalTime > 0 then
		slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordFrame, slot0._onPlayFrame, slot0)
	end
end

function slot0._onEndRecord(slot0)
	slot0._isRecord = false

	slot0:_updateStatus()
	slot0:removeEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordFrame, slot0._onRecordFrame, slot0)
	slot0:removeEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.RecordFrame, slot0._onPlayFrame, slot0)
end

function slot0._onRecordPause(slot0)
end

function slot0._onRecordContinue(slot0)
end

function slot0._onRecordFrame(slot0, slot1)
	slot0._imageslider.fillAmount = slot1 / slot0._trackLengthConst
	slot0._txttime1.text = string.format("%s/%s", TimeUtil.second2TimeString(slot1), slot0._trackLengthConstStr)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._index = slot0._mo.index
	slot0._trackLengthConst = VersionActivity2_4MusicFreeModel.instance:getTrackLength()
	slot0._trackLengthConstStr = TimeUtil.second2TimeString(slot0._trackLengthConst)

	slot0:_updateStatus()
	slot0:_updateName(GameUtil.getRomanNums(slot0._index))
end

function slot0._updateStatus(slot0)
	if slot0._mo.status == VersionActivity2_4MusicEnum.TrackStatus.Inactive then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	slot0._isAddStatus = slot1 == VersionActivity2_4MusicEnum.TrackStatus.Add

	if slot0._isRecord and slot0._isAddStatus then
		gohelper.setActive(slot0.viewGO, false)

		return
	end

	gohelper.setActive(slot0.viewGO, true)

	slot0._isUnRecorded = slot1 == VersionActivity2_4MusicEnum.TrackStatus.UnRecorded
	slot0._isDelStatus = slot1 == VersionActivity2_4MusicEnum.TrackStatus.Del
	slot0._isFinishedStatus = slot0._mo.recordTotalTime > 0

	if slot0._index == VersionActivity2_4MusicFreeModel.instance:getSelectedTrackIndex() and slot0._isRecord and slot0._isUnRecorded then
		slot0._isFinishedStatus = false
	end

	if slot0._isDelStatus then
		slot0._isFinishedStatus = false
	end

	if slot0._isFinishedStatus then
		slot0._isUnRecorded = false
	end

	gohelper.setActive(slot0._goadd, slot0._isAddStatus)
	gohelper.setActive(slot0._godelstate, slot0._isDelStatus)
	gohelper.setActive(slot0._gonormal, slot0._isUnRecorded)
	gohelper.setActive(slot0._gorecorded, slot0._isFinishedStatus)

	if slot0._isUnRecorded then
		slot0._imageslider.fillAmount = slot0._mo.recordTotalTime / slot0._trackLengthConst
		slot0._txttime1.text = string.format("%s/%s", TimeUtil.second2TimeString(slot0._mo.recordTotalTime), slot0._trackLengthConstStr)
	end

	slot0._mo:setDelSelected(false)

	if slot0._isDelStatus then
		slot0._txttime3.text = string.format("%s/%s", TimeUtil.second2TimeString(slot0._mo.recordTotalTime), slot0._trackLengthConstStr)
	end

	if slot0._isFinishedStatus then
		slot0._imagerecordbg.fillAmount = 1
		slot0._txttime2.text = TimeUtil.second2TimeString(slot0._mo.recordTotalTime)

		slot0:_updateMuteStatus(slot0._mo.mute == VersionActivity2_4MusicEnum.MuteStatus.Open)
	end

	slot0:updateSelected()
end

function slot0._updateMuteStatus(slot0, slot1)
	gohelper.setActive(slot0._btnmute, not slot1)
	gohelper.setActive(slot0._btnunmute, slot1)
	slot0._mo:setMute(slot1)
end

function slot0._updateName(slot0, slot1)
	slot0._txtnum1.text = slot1
	slot0._txtnum2.text = slot1
	slot0._txtnum3.text = slot1
end

function slot0.updateSelected(slot0)
	if slot0._isDelStatus then
		slot0._isSelected = nil

		gohelper.setActive(slot0._goselectframe, slot0._mo.isDelSelected)

		return
	end

	slot0._isSelected = slot0._index == VersionActivity2_4MusicFreeModel.instance:getSelectedTrackIndex()

	if slot0._isPlay then
		slot0._isSelected = false
	end

	gohelper.setActive(slot0._goselectframe, slot0._isSelected)
end

function slot0.onDestroyView(slot0)
end

return slot0
