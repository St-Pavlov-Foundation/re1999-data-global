module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeView", package.seeall)

slot0 = class("VersionActivity2_4MusicFreeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_FullBG")
	slot0._gotopleftbtn = gohelper.findChild(slot0.viewGO, "root/#go_topleftbtn")
	slot0._btnremove1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/Title/#btn_remove1")
	slot0._btnremove2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/Title/#btn_remove2")
	slot0._gotranscribelist = gohelper.findChild(slot0.viewGO, "root/left/scroll_transcribelist/viewport/#go_transcribe_list")
	slot0._txtstatetext = gohelper.findChildText(slot0.viewGO, "root/left/bottom_btn/#txt_statetext")
	slot0._btntranscribebtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/bottom_btn/#btn_transcribebtn")
	slot0._btntranscribeagainbtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/bottom_btn/#btn_transcribe_againbtn")
	slot0._btnplaybtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/bottom_btn/#btn_playbtn")
	slot0._gobtngroup1 = gohelper.findChild(slot0.viewGO, "root/left/bottom_btn/#go_btngroup1")
	slot0._btnpause = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/bottom_btn/#go_btngroup1/#btn_pause")
	slot0._btncontinue = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/bottom_btn/#go_btngroup1/#btn_continue")
	slot0._btndone = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/bottom_btn/#go_btngroup1/#btn_done")
	slot0._gobtngroup2 = gohelper.findChild(slot0.viewGO, "root/left/bottom_btn/#go_btngroup2")
	slot0._btnpause2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/bottom_btn/#go_btngroup2/#btn_pause2")
	slot0._btncontinue2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/bottom_btn/#go_btngroup2/#btn_continue2")
	slot0._btnstop = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/bottom_btn/#go_btngroup2/#btn_stop")
	slot0._gobtngroup3 = gohelper.findChild(slot0.viewGO, "root/left/bottom_btn/#go_btngroup3")
	slot0._btncanel = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/bottom_btn/#go_btngroup3/#btn_canel")
	slot0._btndel = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/bottom_btn/#go_btngroup3/#btn_del")
	slot0._btnaccompany = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/toprightbtn/#btn_accompany")
	slot0._btncalibration = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/toprightbtn/#btn_calibration")
	slot0._btnimmerse = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/toprightbtn/#btn_immerse")
	slot0._gomusic1 = gohelper.findChild(slot0.viewGO, "root/right/#go_music1")
	slot0._gomusic2 = gohelper.findChild(slot0.viewGO, "root/right/#go_music2")
	slot0._goinstruments = gohelper.findChild(slot0.viewGO, "root/right/bottom/#go_instruments")
	slot0._gocountdown = gohelper.findChild(slot0.viewGO, "#go_countdown")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_countdown/#txt_num")
	slot0._goleft = gohelper.findChild(slot0.viewGO, "#go_left")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnremove1:AddClickListener(slot0._btnremove1OnClick, slot0)
	slot0._btnremove2:AddClickListener(slot0._btnremove2OnClick, slot0)
	slot0._btntranscribebtn:AddClickListener(slot0._btntranscribebtnOnClick, slot0)
	slot0._btntranscribeagainbtn:AddClickListener(slot0._btntranscribeagainbtnOnClick, slot0)
	slot0._btnplaybtn:AddClickListener(slot0._btnplaybtnOnClick, slot0)
	slot0._btnpause:AddClickListener(slot0._btnpauseOnClick, slot0)
	slot0._btncontinue:AddClickListener(slot0._btncontinueOnClick, slot0)
	slot0._btndone:AddClickListener(slot0._btndoneOnClick, slot0)
	slot0._btnpause2:AddClickListener(slot0._btnpause2OnClick, slot0)
	slot0._btncontinue2:AddClickListener(slot0._btncontinue2OnClick, slot0)
	slot0._btnstop:AddClickListener(slot0._btnstopOnClick, slot0)
	slot0._btncanel:AddClickListener(slot0._btncanelOnClick, slot0)
	slot0._btndel:AddClickListener(slot0._btndelOnClick, slot0)
	slot0._btnaccompany:AddClickListener(slot0._btnaccompanyOnClick, slot0)
	slot0._btncalibration:AddClickListener(slot0._btncalibrationOnClick, slot0)
	slot0._btnimmerse:AddClickListener(slot0._btnimmerseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnremove1:RemoveClickListener()
	slot0._btnremove2:RemoveClickListener()
	slot0._btntranscribebtn:RemoveClickListener()
	slot0._btntranscribeagainbtn:RemoveClickListener()
	slot0._btnplaybtn:RemoveClickListener()
	slot0._btnpause:RemoveClickListener()
	slot0._btncontinue:RemoveClickListener()
	slot0._btndone:RemoveClickListener()
	slot0._btnpause2:RemoveClickListener()
	slot0._btncontinue2:RemoveClickListener()
	slot0._btnstop:RemoveClickListener()
	slot0._btncanel:RemoveClickListener()
	slot0._btndel:RemoveClickListener()
	slot0._btnaccompany:RemoveClickListener()
	slot0._btncalibration:RemoveClickListener()
	slot0._btnimmerse:RemoveClickListener()
end

function slot0._btnremove1OnClick(slot0)
	if VersionActivity2_4MusicFreeModel.instance:getActionStatus() == VersionActivity2_4MusicEnum.ActionStatus.Del then
		return
	end

	if not VersionActivity2_4MusicFreeModel.instance:isNormalStatus() then
		return
	end

	VersionActivity2_4MusicFreeModel.instance:setActionStatus(VersionActivity2_4MusicEnum.ActionStatus.Del)
end

function slot0._btnremove2OnClick(slot0)
	VersionActivity2_4MusicFreeModel.instance:setActionStatus(VersionActivity2_4MusicEnum.ActionStatus.Record)
end

function slot0._btndelOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.MusicDelConfirm, MsgBoxEnum.BoxType.Yes_No, function ()
		VersionActivity2_4MusicFreeModel.instance:delTrackSelected()
	end)
end

function slot0._btntranscribebtnOnClick(slot0)
	slot0:_checkStartRecord()
end

function slot0._btntranscribeagainbtnOnClick(slot0)
	slot0:_checkStartRecord()
end

function slot0._checkStartRecord(slot0)
	if VersionActivity2_4MusicFreeModel.instance:getTrackMo() and slot1.recordTotalTime > 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.MusicReplaceConfirm, MsgBoxEnum.BoxType.Yes_No, function ()
			VersionActivity2_4MusicController.instance:stopBgm()
			uv0:_startCountDown(uv0._startRecord, VersionActivity2_4MusicEnum.RecordStatus.Recording)
		end)

		return
	end

	VersionActivity2_4MusicController.instance:stopBgm()
	slot0:_startCountDown(slot0._startRecord, VersionActivity2_4MusicEnum.RecordStatus.Recording)
end

function slot0._startRecord(slot0)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.StartRecord)
end

function slot0._btnplaybtnOnClick(slot0)
	VersionActivity2_4MusicController.instance:stopBgm()
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.StartPlay)
end

function slot0._btnpauseOnClick(slot0)
	slot0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.RecordPause)
end

function slot0._btncontinueOnClick(slot0)
	slot0:_onContinue()
end

function slot0._onContinue(slot0)
	slot0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Recording)
	VersionActivity2_4MusicController.instance:resumeBgm()
end

function slot0._startCountDown(slot0, slot1, slot2)
	slot0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.RecordReady, slot2)

	slot0._countDownCallback = slot1
	slot0._countDownNum = 3

	TaskDispatcher.cancelTask(slot0._countDownHandler, slot0)
	TaskDispatcher.runRepeat(slot0._countDownHandler, slot0, 1)
	slot0:_countDownHandler()

	slot0._countDownId = AudioMgr.instance:trigger(AudioEnum.Bakaluoer.play_ui_diqiu_count_down)
end

function slot0._countDownHandler(slot0)
	if slot0._countDownNum == 0 then
		slot0._countDownId = nil

		TaskDispatcher.cancelTask(slot0._countDownHandler, slot0)
		slot0:_countDownCallback()

		return
	end

	slot0._txtnum.text = tostring(slot0._countDownNum)
	slot0._countDownNum = slot0._countDownNum - 1
end

function slot0._btndoneOnClick(slot0)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.EndRecord)
end

function slot0._btnpause2OnClick(slot0)
	slot0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.PlayPause)
end

function slot0._btncontinue2OnClick(slot0)
	slot0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Playing)
	VersionActivity2_4MusicController.instance:resumeBgm()
end

function slot0._btncanelOnClick(slot0)
	VersionActivity2_4MusicFreeModel.instance:setActionStatus(VersionActivity2_4MusicEnum.ActionStatus.Record)
end

function slot0._btnaccompanyOnClick(slot0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeAccompanyView()
end

function slot0._btncalibrationOnClick(slot0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeCalibrationView()
end

function slot0._btnimmerseOnClick(slot0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeImmerseView()
end

function slot0._btninstrument1OnClick(slot0)
end

function slot0._btnstopOnClick(slot0)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.EndPlay)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._btnaccompany, false)
	VersionActivity2_4MusicFreeModel.instance:onStart()
	slot0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Normal)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.StartRecord, slot0._onStartRecord, slot0)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.EndRecord, slot0._onEndRecord, slot0)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.StartPlay, slot0._onStartPlay, slot0)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.EndPlay, slot0._onEndPlay, slot0)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.ActionStatusChange, slot0._onActionStatusChange, slot0)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.TrackDelSelectedChange, slot0._onTrackDelSelectedChange, slot0)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.UpdateSelectedTrackIndex, slot0._onUpdateSelectedTrackIndex, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenViewCallBack, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)

	slot0._recordStartTime = 0
	slot0._recordTotalTime = 0
	slot0._txtstatetext.text = ""
end

function slot0._onOpenViewCallBack(slot0, slot1)
	if slot1 == ViewName.VersionActivity2_4MusicFreeImmerseView or slot1 == ViewName.VersionActivity2_4MusicFreeCalibrationView then
		return
	end

	if slot0._isRecord then
		slot0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.RecordPause)
	end

	if slot0._isPlay then
		slot0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.PlayPause)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
end

function slot0._onUpdateSelectedTrackIndex(slot0)
	slot0:_updateRecordBtnStatus()
end

function slot0._onTrackDelSelectedChange(slot0)
	slot0._btndel.button.interactable = VersionActivity2_4MusicFreeModel.instance:getTrackSelectedNum() > 0
end

function slot0._onActionStatusChange(slot0)
	slot0:_updateBtnStatus(VersionActivity2_4MusicFreeModel.instance:getActionStatus() == VersionActivity2_4MusicEnum.ActionStatus.Del and VersionActivity2_4MusicEnum.RecordStatus.Del or VersionActivity2_4MusicEnum.RecordStatus.Normal)
end

function slot0._onStartPlay(slot0)
	slot0._isPlay = true
	slot0._recordStartTime = Time.time
	slot0._recordTotalTime = 0

	slot0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Playing)
	VersionActivity2_4MusicFreeModel.instance:startPlay()
	VersionActivity2_4MusicController.instance:playBgm(VersionActivity2_4MusicEnum.BgmPlay)
end

function slot0._onEndPlay(slot0)
	slot0._isPlay = false

	slot0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Normal)
	VersionActivity2_4MusicFreeModel.instance:endPlay()
	VersionActivity2_4MusicController.instance:stopBgm()
	VersionActivity2_4MusicFreeModel.instance:onAccompanyStatusChange()
end

function slot0._onStartRecord(slot0)
	slot0._isRecord = true
	slot0._recordStartTime = Time.time
	slot0._recordTotalTime = 0
	slot0._skipTrackMap = {
		[VersionActivity2_4MusicFreeModel.instance:getSelectedTrackIndex()] = true
	}

	slot0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Recording)
	VersionActivity2_4MusicFreeModel.instance:startRecord()
	VersionActivity2_4MusicController.instance:playBgm(VersionActivity2_4MusicEnum.BgmPlay)
end

function slot0._onEndRecord(slot0)
	slot0._isRecord = false

	VersionActivity2_4MusicFreeModel.instance:endRecord()
	slot0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.NormalAfterRecord)
	VersionActivity2_4MusicController.instance:stopBgm()
	VersionActivity2_4MusicFreeModel.instance:onAccompanyStatusChange()
	Activity179Rpc.instance:sendSet179ScoreRequest(Activity179Model.instance:getActivityId(), Activity179Config.instance:getFreeEpisodeId(), 0)
end

function slot0._updateRecordBtnStatus(slot0)
	slot4 = VersionActivity2_4MusicFreeModel.instance:getStatus() == VersionActivity2_4MusicEnum.RecordStatus.Normal or slot1 == VersionActivity2_4MusicEnum.RecordStatus.NormalAfterRecord
	slot5 = VersionActivity2_4MusicFreeModel.instance:getTrackMo()

	gohelper.setActive(slot0._btntranscribebtn, slot4 and slot5 and slot5.recordTotalTime <= 0)
	gohelper.setActive(slot0._btntranscribeagainbtn, slot4 and slot5 and slot5.recordTotalTime > 0)
end

function slot0._updateBtnStatus(slot0, slot1, slot2)
	VersionActivity2_4MusicFreeModel.instance:setStatus(slot1)

	slot5 = slot1 == VersionActivity2_4MusicEnum.RecordStatus.Normal or slot1 == VersionActivity2_4MusicEnum.RecordStatus.NormalAfterRecord
	slot13 = slot1 == VersionActivity2_4MusicEnum.RecordStatus.Del

	slot0:_updateRecordBtnStatus()
	gohelper.setActive(slot0._btnplaybtn, slot5)
	gohelper.setActive(slot0._gobtngroup1, slot1 == VersionActivity2_4MusicEnum.RecordStatus.Recording or slot2 == VersionActivity2_4MusicEnum.RecordStatus.Recording or slot1 == VersionActivity2_4MusicEnum.RecordStatus.RecordPause)
	gohelper.setActive(slot0._gobtngroup2, slot1 == VersionActivity2_4MusicEnum.RecordStatus.Playing or slot1 == VersionActivity2_4MusicEnum.RecordStatus.PlayPause)
	gohelper.setActive(slot0._gobtngroup3, slot13)
	gohelper.setActive(slot0._gocountdown, slot1 == VersionActivity2_4MusicEnum.RecordStatus.RecordReady)
	gohelper.setActive(slot0._btnremove2, slot13)
	gohelper.setActive(slot0._btnremove1, not slot13)
	gohelper.setActive(slot0._btndel, slot13)

	if slot5 then
		slot0._btnplaybtn.button.interactable = VersionActivity2_4MusicFreeModel.instance:anyOneHasRecorded()
	end

	slot0._txtstatetext.text = ""

	if slot6 then
		slot0._txtstatetext.text = luaLang("MusicRecordReady")
	end

	if slot1 == VersionActivity2_4MusicEnum.RecordStatus.Recording then
		slot0._txtstatetext.text = luaLang("MusicRecording")
	end

	if slot8 then
		slot0._txtstatetext.text = luaLang("MusicRecordPause")
	end

	if slot10 then
		slot0._txtstatetext.text = luaLang("MusicPlaying")
	end

	if slot11 then
		slot0._txtstatetext.text = luaLang("MusicPlayPause")
	end

	if slot13 then
		slot0:_onTrackDelSelectedChange()
	end

	if slot9 then
		gohelper.setActive(slot0._btnpause, slot7)
		gohelper.setActive(slot0._btncontinue, slot8)
	end

	if slot12 then
		gohelper.setActive(slot0._btnpause2, slot10)
		gohelper.setActive(slot0._btncontinue2, slot11)
	end

	slot0:_recordOnStatusChange(slot1)
	slot0:_bgmOnStatusChange(slot1)
end

function slot0._bgmOnStatusChange(slot0, slot1)
	if slot1 == VersionActivity2_4MusicEnum.RecordStatus.RecordPause or slot1 == VersionActivity2_4MusicEnum.RecordStatus.PlayPause then
		VersionActivity2_4MusicController.instance:pauseBgm()
	end
end

function slot0._recordOnStatusChange(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._onRecordingFrame, slot0)
	TaskDispatcher.cancelTask(slot0._playFrame, slot0)

	if slot1 == VersionActivity2_4MusicEnum.RecordStatus.Recording then
		slot0._recordStartTime = Time.time

		TaskDispatcher.runRepeat(slot0._onRecordingFrame, slot0, 0)
	elseif slot1 == VersionActivity2_4MusicEnum.RecordStatus.RecordPause then
		slot0._recordTotalTime = slot0._recordTotalTime + Time.time - slot0._recordStartTime
	end

	if slot1 == VersionActivity2_4MusicEnum.RecordStatus.Playing then
		slot0._recordStartTime = Time.time

		TaskDispatcher.runRepeat(slot0._playFrame, slot0, 0)
	elseif slot1 == VersionActivity2_4MusicEnum.RecordStatus.PlayPause then
		slot0._recordTotalTime = slot0._recordTotalTime + Time.time - slot0._recordStartTime
	end
end

function slot0._onRecordingFrame(slot0)
	slot2 = slot0._recordTotalTime + Time.time - slot0._recordStartTime

	VersionActivity2_4MusicFreeModel.instance:setRecordProgressTime(slot2)

	if VersionActivity2_4MusicFreeModel.instance:timeout(slot2) then
		VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.EndRecord)

		return
	end

	VersionActivity2_4MusicFreeModel.instance:playTrackList(slot0._skipTrackMap)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.RecordFrame, slot2)
end

function slot0._playFrame(slot0)
	VersionActivity2_4MusicFreeModel.instance:setRecordProgressTime(slot0._recordTotalTime + Time.time - slot0._recordStartTime)

	if VersionActivity2_4MusicFreeModel.instance:playTrackList() then
		VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.EndPlay)

		return
	end

	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.PlayFrame, slot2)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
	if slot0._countDownId then
		AudioMgr.instance:stopPlayingID(slot0._countDownId)

		slot0._countDownId = nil
	end

	TaskDispatcher.cancelTask(slot0._onRecordingFrame, slot0)
	TaskDispatcher.cancelTask(slot0._playFrame, slot0)
	TaskDispatcher.cancelTask(slot0._countDownHandler, slot0)
	VersionActivity2_4MusicFreeModel.instance:onEnd()
end

function slot0.onDestroyView(slot0)
end

return slot0
