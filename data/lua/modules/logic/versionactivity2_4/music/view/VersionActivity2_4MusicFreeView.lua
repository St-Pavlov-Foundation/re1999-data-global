module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicFreeView", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicFreeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_FullBG")
	arg_1_0._gotopleftbtn = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleftbtn")
	arg_1_0._btnremove1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/Title/#btn_remove1")
	arg_1_0._btnremove2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/Title/#btn_remove2")
	arg_1_0._gotranscribelist = gohelper.findChild(arg_1_0.viewGO, "root/left/scroll_transcribelist/viewport/#go_transcribe_list")
	arg_1_0._txtstatetext = gohelper.findChildText(arg_1_0.viewGO, "root/left/bottom_btn/#txt_statetext")
	arg_1_0._btntranscribebtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/bottom_btn/#btn_transcribebtn")
	arg_1_0._btntranscribeagainbtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/bottom_btn/#btn_transcribe_againbtn")
	arg_1_0._btnplaybtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/bottom_btn/#btn_playbtn")
	arg_1_0._gobtngroup1 = gohelper.findChild(arg_1_0.viewGO, "root/left/bottom_btn/#go_btngroup1")
	arg_1_0._btnpause = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/bottom_btn/#go_btngroup1/#btn_pause")
	arg_1_0._btncontinue = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/bottom_btn/#go_btngroup1/#btn_continue")
	arg_1_0._btndone = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/bottom_btn/#go_btngroup1/#btn_done")
	arg_1_0._gobtngroup2 = gohelper.findChild(arg_1_0.viewGO, "root/left/bottom_btn/#go_btngroup2")
	arg_1_0._btnpause2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/bottom_btn/#go_btngroup2/#btn_pause2")
	arg_1_0._btncontinue2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/bottom_btn/#go_btngroup2/#btn_continue2")
	arg_1_0._btnstop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/bottom_btn/#go_btngroup2/#btn_stop")
	arg_1_0._gobtngroup3 = gohelper.findChild(arg_1_0.viewGO, "root/left/bottom_btn/#go_btngroup3")
	arg_1_0._btncanel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/bottom_btn/#go_btngroup3/#btn_canel")
	arg_1_0._btndel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/bottom_btn/#go_btngroup3/#btn_del")
	arg_1_0._btnaccompany = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/toprightbtn/#btn_accompany")
	arg_1_0._btncalibration = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/toprightbtn/#btn_calibration")
	arg_1_0._btnimmerse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/toprightbtn/#btn_immerse")
	arg_1_0._gomusic1 = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_music1")
	arg_1_0._gomusic2 = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_music2")
	arg_1_0._goinstruments = gohelper.findChild(arg_1_0.viewGO, "root/right/bottom/#go_instruments")
	arg_1_0._gocountdown = gohelper.findChild(arg_1_0.viewGO, "#go_countdown")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_countdown/#txt_num")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#go_left")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnremove1:AddClickListener(arg_2_0._btnremove1OnClick, arg_2_0)
	arg_2_0._btnremove2:AddClickListener(arg_2_0._btnremove2OnClick, arg_2_0)
	arg_2_0._btntranscribebtn:AddClickListener(arg_2_0._btntranscribebtnOnClick, arg_2_0)
	arg_2_0._btntranscribeagainbtn:AddClickListener(arg_2_0._btntranscribeagainbtnOnClick, arg_2_0)
	arg_2_0._btnplaybtn:AddClickListener(arg_2_0._btnplaybtnOnClick, arg_2_0)
	arg_2_0._btnpause:AddClickListener(arg_2_0._btnpauseOnClick, arg_2_0)
	arg_2_0._btncontinue:AddClickListener(arg_2_0._btncontinueOnClick, arg_2_0)
	arg_2_0._btndone:AddClickListener(arg_2_0._btndoneOnClick, arg_2_0)
	arg_2_0._btnpause2:AddClickListener(arg_2_0._btnpause2OnClick, arg_2_0)
	arg_2_0._btncontinue2:AddClickListener(arg_2_0._btncontinue2OnClick, arg_2_0)
	arg_2_0._btnstop:AddClickListener(arg_2_0._btnstopOnClick, arg_2_0)
	arg_2_0._btncanel:AddClickListener(arg_2_0._btncanelOnClick, arg_2_0)
	arg_2_0._btndel:AddClickListener(arg_2_0._btndelOnClick, arg_2_0)
	arg_2_0._btnaccompany:AddClickListener(arg_2_0._btnaccompanyOnClick, arg_2_0)
	arg_2_0._btncalibration:AddClickListener(arg_2_0._btncalibrationOnClick, arg_2_0)
	arg_2_0._btnimmerse:AddClickListener(arg_2_0._btnimmerseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnremove1:RemoveClickListener()
	arg_3_0._btnremove2:RemoveClickListener()
	arg_3_0._btntranscribebtn:RemoveClickListener()
	arg_3_0._btntranscribeagainbtn:RemoveClickListener()
	arg_3_0._btnplaybtn:RemoveClickListener()
	arg_3_0._btnpause:RemoveClickListener()
	arg_3_0._btncontinue:RemoveClickListener()
	arg_3_0._btndone:RemoveClickListener()
	arg_3_0._btnpause2:RemoveClickListener()
	arg_3_0._btncontinue2:RemoveClickListener()
	arg_3_0._btnstop:RemoveClickListener()
	arg_3_0._btncanel:RemoveClickListener()
	arg_3_0._btndel:RemoveClickListener()
	arg_3_0._btnaccompany:RemoveClickListener()
	arg_3_0._btncalibration:RemoveClickListener()
	arg_3_0._btnimmerse:RemoveClickListener()
end

function var_0_0._btnremove1OnClick(arg_4_0)
	if VersionActivity2_4MusicFreeModel.instance:getActionStatus() == VersionActivity2_4MusicEnum.ActionStatus.Del then
		return
	end

	if not VersionActivity2_4MusicFreeModel.instance:isNormalStatus() then
		return
	end

	VersionActivity2_4MusicFreeModel.instance:setActionStatus(VersionActivity2_4MusicEnum.ActionStatus.Del)
end

function var_0_0._btnremove2OnClick(arg_5_0)
	VersionActivity2_4MusicFreeModel.instance:setActionStatus(VersionActivity2_4MusicEnum.ActionStatus.Record)
end

function var_0_0._btndelOnClick(arg_6_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.MusicDelConfirm, MsgBoxEnum.BoxType.Yes_No, function()
		VersionActivity2_4MusicFreeModel.instance:delTrackSelected()
	end)
end

function var_0_0._btntranscribebtnOnClick(arg_8_0)
	arg_8_0:_checkStartRecord()
end

function var_0_0._btntranscribeagainbtnOnClick(arg_9_0)
	arg_9_0:_checkStartRecord()
end

function var_0_0._checkStartRecord(arg_10_0)
	local var_10_0 = VersionActivity2_4MusicFreeModel.instance:getTrackMo()

	if var_10_0 and var_10_0.recordTotalTime > 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.MusicReplaceConfirm, MsgBoxEnum.BoxType.Yes_No, function()
			VersionActivity2_4MusicController.instance:stopBgm()
			arg_10_0:_startCountDown(arg_10_0._startRecord, VersionActivity2_4MusicEnum.RecordStatus.Recording)
		end)

		return
	end

	VersionActivity2_4MusicController.instance:stopBgm()
	arg_10_0:_startCountDown(arg_10_0._startRecord, VersionActivity2_4MusicEnum.RecordStatus.Recording)
end

function var_0_0._startRecord(arg_12_0)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.StartRecord)
end

function var_0_0._btnplaybtnOnClick(arg_13_0)
	VersionActivity2_4MusicController.instance:stopBgm()
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.StartPlay)
end

function var_0_0._btnpauseOnClick(arg_14_0)
	arg_14_0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.RecordPause)
end

function var_0_0._btncontinueOnClick(arg_15_0)
	arg_15_0:_onContinue()
end

function var_0_0._onContinue(arg_16_0)
	arg_16_0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Recording)
	VersionActivity2_4MusicController.instance:resumeBgm()
end

function var_0_0._startCountDown(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.RecordReady, arg_17_2)

	arg_17_0._countDownCallback = arg_17_1
	arg_17_0._countDownNum = 3

	TaskDispatcher.cancelTask(arg_17_0._countDownHandler, arg_17_0)
	TaskDispatcher.runRepeat(arg_17_0._countDownHandler, arg_17_0, 1)
	arg_17_0:_countDownHandler()

	arg_17_0._countDownId = AudioMgr.instance:trigger(AudioEnum.Bakaluoer.play_ui_diqiu_count_down)
end

function var_0_0._countDownHandler(arg_18_0)
	if arg_18_0._countDownNum == 0 then
		arg_18_0._countDownId = nil

		TaskDispatcher.cancelTask(arg_18_0._countDownHandler, arg_18_0)
		arg_18_0._countDownCallback(arg_18_0)

		return
	end

	arg_18_0._txtnum.text = tostring(arg_18_0._countDownNum)
	arg_18_0._countDownNum = arg_18_0._countDownNum - 1
end

function var_0_0._btndoneOnClick(arg_19_0)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.EndRecord)
end

function var_0_0._btnpause2OnClick(arg_20_0)
	arg_20_0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.PlayPause)
end

function var_0_0._btncontinue2OnClick(arg_21_0)
	arg_21_0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Playing)
	VersionActivity2_4MusicController.instance:resumeBgm()
end

function var_0_0._btncanelOnClick(arg_22_0)
	VersionActivity2_4MusicFreeModel.instance:setActionStatus(VersionActivity2_4MusicEnum.ActionStatus.Record)
end

function var_0_0._btnaccompanyOnClick(arg_23_0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeAccompanyView()
end

function var_0_0._btncalibrationOnClick(arg_24_0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeCalibrationView()
end

function var_0_0._btnimmerseOnClick(arg_25_0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeImmerseView()
end

function var_0_0._btninstrument1OnClick(arg_26_0)
	return
end

function var_0_0._btnstopOnClick(arg_27_0)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.EndPlay)
end

function var_0_0._editableInitView(arg_28_0)
	gohelper.setActive(arg_28_0._btnaccompany, false)
	VersionActivity2_4MusicFreeModel.instance:onStart()
	arg_28_0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Normal)
	arg_28_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.StartRecord, arg_28_0._onStartRecord, arg_28_0)
	arg_28_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.EndRecord, arg_28_0._onEndRecord, arg_28_0)
	arg_28_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.StartPlay, arg_28_0._onStartPlay, arg_28_0)
	arg_28_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.EndPlay, arg_28_0._onEndPlay, arg_28_0)
	arg_28_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.ActionStatusChange, arg_28_0._onActionStatusChange, arg_28_0)
	arg_28_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.TrackDelSelectedChange, arg_28_0._onTrackDelSelectedChange, arg_28_0)
	arg_28_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.UpdateSelectedTrackIndex, arg_28_0._onUpdateSelectedTrackIndex, arg_28_0)
	arg_28_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_28_0._onOpenViewCallBack, arg_28_0)
	arg_28_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_28_0._onCloseViewFinish, arg_28_0)

	arg_28_0._recordStartTime = 0
	arg_28_0._recordTotalTime = 0
	arg_28_0._txtstatetext.text = ""
end

function var_0_0._onOpenViewCallBack(arg_29_0, arg_29_1)
	if arg_29_1 == ViewName.VersionActivity2_4MusicFreeImmerseView or arg_29_1 == ViewName.VersionActivity2_4MusicFreeCalibrationView then
		return
	end

	if arg_29_0._isRecord then
		arg_29_0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.RecordPause)
	end

	if arg_29_0._isPlay then
		arg_29_0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.PlayPause)
	end
end

function var_0_0._onCloseViewFinish(arg_30_0, arg_30_1)
	return
end

function var_0_0._onUpdateSelectedTrackIndex(arg_31_0)
	arg_31_0:_updateRecordBtnStatus()
end

function var_0_0._onTrackDelSelectedChange(arg_32_0)
	local var_32_0 = VersionActivity2_4MusicFreeModel.instance:getTrackSelectedNum() > 0

	arg_32_0._btndel.button.interactable = var_32_0
end

function var_0_0._onActionStatusChange(arg_33_0)
	local var_33_0 = VersionActivity2_4MusicFreeModel.instance:getActionStatus() == VersionActivity2_4MusicEnum.ActionStatus.Del

	arg_33_0:_updateBtnStatus(var_33_0 and VersionActivity2_4MusicEnum.RecordStatus.Del or VersionActivity2_4MusicEnum.RecordStatus.Normal)
end

function var_0_0._onStartPlay(arg_34_0)
	arg_34_0._isPlay = true
	arg_34_0._recordStartTime = Time.time
	arg_34_0._recordTotalTime = 0

	arg_34_0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Playing)
	VersionActivity2_4MusicFreeModel.instance:startPlay()
	VersionActivity2_4MusicController.instance:playBgm(VersionActivity2_4MusicEnum.BgmPlay)
end

function var_0_0._onEndPlay(arg_35_0)
	arg_35_0._isPlay = false

	arg_35_0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Normal)
	VersionActivity2_4MusicFreeModel.instance:endPlay()
	VersionActivity2_4MusicController.instance:stopBgm()
	VersionActivity2_4MusicFreeModel.instance:onAccompanyStatusChange()
end

function var_0_0._onStartRecord(arg_36_0)
	arg_36_0._isRecord = true
	arg_36_0._recordStartTime = Time.time
	arg_36_0._recordTotalTime = 0
	arg_36_0._skipTrackMap = {}
	arg_36_0._skipTrackMap[VersionActivity2_4MusicFreeModel.instance:getSelectedTrackIndex()] = true

	arg_36_0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.Recording)
	VersionActivity2_4MusicFreeModel.instance:startRecord()
	VersionActivity2_4MusicController.instance:playBgm(VersionActivity2_4MusicEnum.BgmPlay)
end

function var_0_0._onEndRecord(arg_37_0)
	arg_37_0._isRecord = false

	VersionActivity2_4MusicFreeModel.instance:endRecord()
	arg_37_0:_updateBtnStatus(VersionActivity2_4MusicEnum.RecordStatus.NormalAfterRecord)
	VersionActivity2_4MusicController.instance:stopBgm()
	VersionActivity2_4MusicFreeModel.instance:onAccompanyStatusChange()

	local var_37_0 = Activity179Config.instance:getFreeEpisodeId()

	Activity179Rpc.instance:sendSet179ScoreRequest(Activity179Model.instance:getActivityId(), var_37_0, 0)
end

function var_0_0._updateRecordBtnStatus(arg_38_0)
	local var_38_0 = VersionActivity2_4MusicFreeModel.instance:getStatus()
	local var_38_1 = var_38_0 == VersionActivity2_4MusicEnum.RecordStatus.Normal
	local var_38_2 = var_38_0 == VersionActivity2_4MusicEnum.RecordStatus.NormalAfterRecord
	local var_38_3 = var_38_1 or var_38_2
	local var_38_4 = VersionActivity2_4MusicFreeModel.instance:getTrackMo()

	gohelper.setActive(arg_38_0._btntranscribebtn, var_38_3 and var_38_4 and var_38_4.recordTotalTime <= 0)
	gohelper.setActive(arg_38_0._btntranscribeagainbtn, var_38_3 and var_38_4 and var_38_4.recordTotalTime > 0)
end

function var_0_0._updateBtnStatus(arg_39_0, arg_39_1, arg_39_2)
	VersionActivity2_4MusicFreeModel.instance:setStatus(arg_39_1)

	local var_39_0 = arg_39_1 == VersionActivity2_4MusicEnum.RecordStatus.Normal
	local var_39_1 = arg_39_1 == VersionActivity2_4MusicEnum.RecordStatus.NormalAfterRecord
	local var_39_2 = var_39_0 or var_39_1
	local var_39_3 = arg_39_1 == VersionActivity2_4MusicEnum.RecordStatus.RecordReady
	local var_39_4 = arg_39_1 == VersionActivity2_4MusicEnum.RecordStatus.Recording or arg_39_2 == VersionActivity2_4MusicEnum.RecordStatus.Recording
	local var_39_5 = arg_39_1 == VersionActivity2_4MusicEnum.RecordStatus.RecordPause
	local var_39_6 = var_39_4 or var_39_5
	local var_39_7 = arg_39_1 == VersionActivity2_4MusicEnum.RecordStatus.Playing
	local var_39_8 = arg_39_1 == VersionActivity2_4MusicEnum.RecordStatus.PlayPause
	local var_39_9 = var_39_7 or var_39_8
	local var_39_10 = arg_39_1 == VersionActivity2_4MusicEnum.RecordStatus.Del

	arg_39_0:_updateRecordBtnStatus()
	gohelper.setActive(arg_39_0._btnplaybtn, var_39_2)
	gohelper.setActive(arg_39_0._gobtngroup1, var_39_6)
	gohelper.setActive(arg_39_0._gobtngroup2, var_39_9)
	gohelper.setActive(arg_39_0._gobtngroup3, var_39_10)
	gohelper.setActive(arg_39_0._gocountdown, var_39_3)
	gohelper.setActive(arg_39_0._btnremove2, var_39_10)
	gohelper.setActive(arg_39_0._btnremove1, not var_39_10)
	gohelper.setActive(arg_39_0._btndel, var_39_10)

	if var_39_2 then
		arg_39_0._btnplaybtn.button.interactable = VersionActivity2_4MusicFreeModel.instance:anyOneHasRecorded()
	end

	arg_39_0._txtstatetext.text = ""

	if var_39_3 then
		arg_39_0._txtstatetext.text = luaLang("MusicRecordReady")
	end

	if arg_39_1 == VersionActivity2_4MusicEnum.RecordStatus.Recording then
		arg_39_0._txtstatetext.text = luaLang("MusicRecording")
	end

	if var_39_5 then
		arg_39_0._txtstatetext.text = luaLang("MusicRecordPause")
	end

	if var_39_7 then
		arg_39_0._txtstatetext.text = luaLang("MusicPlaying")
	end

	if var_39_8 then
		arg_39_0._txtstatetext.text = luaLang("MusicPlayPause")
	end

	if var_39_10 then
		arg_39_0:_onTrackDelSelectedChange()
	end

	if var_39_6 then
		gohelper.setActive(arg_39_0._btnpause, var_39_4)
		gohelper.setActive(arg_39_0._btncontinue, var_39_5)
	end

	if var_39_9 then
		gohelper.setActive(arg_39_0._btnpause2, var_39_7)
		gohelper.setActive(arg_39_0._btncontinue2, var_39_8)
	end

	arg_39_0:_recordOnStatusChange(arg_39_1)
	arg_39_0:_bgmOnStatusChange(arg_39_1)
end

function var_0_0._bgmOnStatusChange(arg_40_0, arg_40_1)
	if arg_40_1 == VersionActivity2_4MusicEnum.RecordStatus.RecordPause or arg_40_1 == VersionActivity2_4MusicEnum.RecordStatus.PlayPause then
		VersionActivity2_4MusicController.instance:pauseBgm()
	end
end

function var_0_0._recordOnStatusChange(arg_41_0, arg_41_1)
	TaskDispatcher.cancelTask(arg_41_0._onRecordingFrame, arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0._playFrame, arg_41_0)

	if arg_41_1 == VersionActivity2_4MusicEnum.RecordStatus.Recording then
		arg_41_0._recordStartTime = Time.time

		TaskDispatcher.runRepeat(arg_41_0._onRecordingFrame, arg_41_0, 0)
	elseif arg_41_1 == VersionActivity2_4MusicEnum.RecordStatus.RecordPause then
		arg_41_0._recordTotalTime = arg_41_0._recordTotalTime + (Time.time - arg_41_0._recordStartTime)
	end

	if arg_41_1 == VersionActivity2_4MusicEnum.RecordStatus.Playing then
		arg_41_0._recordStartTime = Time.time

		TaskDispatcher.runRepeat(arg_41_0._playFrame, arg_41_0, 0)
	elseif arg_41_1 == VersionActivity2_4MusicEnum.RecordStatus.PlayPause then
		arg_41_0._recordTotalTime = arg_41_0._recordTotalTime + (Time.time - arg_41_0._recordStartTime)
	end
end

function var_0_0._onRecordingFrame(arg_42_0)
	local var_42_0 = Time.time - arg_42_0._recordStartTime
	local var_42_1 = arg_42_0._recordTotalTime + var_42_0

	VersionActivity2_4MusicFreeModel.instance:setRecordProgressTime(var_42_1)

	if VersionActivity2_4MusicFreeModel.instance:timeout(var_42_1) then
		VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.EndRecord)

		return
	end

	VersionActivity2_4MusicFreeModel.instance:playTrackList(arg_42_0._skipTrackMap)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.RecordFrame, var_42_1)
end

function var_0_0._playFrame(arg_43_0)
	local var_43_0 = Time.time - arg_43_0._recordStartTime
	local var_43_1 = arg_43_0._recordTotalTime + var_43_0

	VersionActivity2_4MusicFreeModel.instance:setRecordProgressTime(var_43_1)

	if VersionActivity2_4MusicFreeModel.instance:playTrackList() then
		VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.EndPlay)

		return
	end

	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.PlayFrame, var_43_1)
end

function var_0_0.onUpdateParam(arg_44_0)
	return
end

function var_0_0.onOpen(arg_45_0)
	return
end

function var_0_0.onClose(arg_46_0)
	if arg_46_0._countDownId then
		AudioMgr.instance:stopPlayingID(arg_46_0._countDownId)

		arg_46_0._countDownId = nil
	end

	TaskDispatcher.cancelTask(arg_46_0._onRecordingFrame, arg_46_0)
	TaskDispatcher.cancelTask(arg_46_0._playFrame, arg_46_0)
	TaskDispatcher.cancelTask(arg_46_0._countDownHandler, arg_46_0)
	VersionActivity2_4MusicFreeModel.instance:onEnd()
end

function var_0_0.onDestroyView(arg_47_0)
	return
end

return var_0_0
