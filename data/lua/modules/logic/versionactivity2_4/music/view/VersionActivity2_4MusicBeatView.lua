module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatView", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicBeatView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotopleftbtn = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleftbtn")
	arg_1_0._txtscore = gohelper.findChildText(arg_1_0.viewGO, "root/scoregroup/#txt_score")
	arg_1_0._txtmaxscore = gohelper.findChildText(arg_1_0.viewGO, "root/scoregroup/#txt_maxscore")
	arg_1_0._gocombo = gohelper.findChild(arg_1_0.viewGO, "root/#go_combo")
	arg_1_0._gostate1 = gohelper.findChild(arg_1_0.viewGO, "root/#go_combo/#go_state1")
	arg_1_0._txtnum1 = gohelper.findChildText(arg_1_0.viewGO, "root/#go_combo/#go_state1/#txt_num1")
	arg_1_0._gostate2 = gohelper.findChild(arg_1_0.viewGO, "root/#go_combo/#go_state2")
	arg_1_0._txtnum2 = gohelper.findChildText(arg_1_0.viewGO, "root/#go_combo/#go_state2/#txt_num2")
	arg_1_0._gostate3 = gohelper.findChild(arg_1_0.viewGO, "root/#go_combo/#go_state3")
	arg_1_0._txtnum3 = gohelper.findChildText(arg_1_0.viewGO, "root/#go_combo/#go_state3/#txt_num3")
	arg_1_0._btnstop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btn/#btn_stop")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btn/#btn_skip")
	arg_1_0._btnaccompany = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btn/#btn_accompany")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "root/timebg/#txt_time")
	arg_1_0._gomissclick = gohelper.findChild(arg_1_0.viewGO, "root/#go_missclick")
	arg_1_0._gobeatgrid = gohelper.findChild(arg_1_0.viewGO, "root/#go_beatgrid")
	arg_1_0._gobeatitem = gohelper.findChild(arg_1_0.viewGO, "root/#go_beatgrid/#go_beatitem")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_start")
	arg_1_0._gocountdown = gohelper.findChild(arg_1_0.viewGO, "root/#go_countdown")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "root/#go_countdown/#txt_num")
	arg_1_0._goblock = gohelper.findChild(arg_1_0.viewGO, "#go_block")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#go_left")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstop:AddClickListener(arg_2_0._btnstopOnClick, arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
	arg_2_0._btnaccompany:AddClickListener(arg_2_0._btnaccompanyOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstop:RemoveClickListener()
	arg_3_0._btnskip:RemoveClickListener()
	arg_3_0._btnaccompany:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
end

function var_0_0._btnstopOnClick(arg_4_0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicBeatResultView({
		isPause = true
	})
end

function var_0_0._btnskipOnClick(arg_5_0)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.Skip)
	StoryController.instance:playStory(arg_5_0._episodeConfig.storyAfter, nil, arg_5_0.closeThis, arg_5_0)
end

function var_0_0._btnaccompanyOnClick(arg_6_0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeAccompanyView()
end

function var_0_0._btnstartOnClick(arg_7_0)
	arg_7_0:_startCountDown(arg_7_0._startGame)
end

function var_0_0._startCountDown(arg_8_0, arg_8_1)
	arg_8_0._countDownCallback = arg_8_1

	arg_8_0:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.CountDown)

	arg_8_0._countDownNum = 3

	TaskDispatcher.cancelTask(arg_8_0._countDownHandler, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0._countDownHandler, arg_8_0, 1)
	arg_8_0:_countDownHandler()

	arg_8_0._countDownId = AudioMgr.instance:trigger(AudioEnum.Bakaluoer.play_ui_diqiu_count_down)
end

function var_0_0._countDownHandler(arg_9_0)
	if arg_9_0._countDownNum == 0 then
		arg_9_0._countDownId = nil

		TaskDispatcher.cancelTask(arg_9_0._countDownHandler, arg_9_0)
		arg_9_0._countDownCallback(arg_9_0)

		return
	end

	arg_9_0._txtnum.text = tostring(arg_9_0._countDownNum)
	arg_9_0._countDownNum = arg_9_0._countDownNum - 1
end

function var_0_0._startGame(arg_10_0)
	arg_10_0:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.Playing)

	arg_10_0._startTime = Time.time
	arg_10_0._progressTime = 0

	arg_10_0._noteView:startGame()
	VersionActivity2_4MusicController.instance:playBgm(arg_10_0._audio)
	TaskDispatcher.cancelTask(arg_10_0._updateFrame, arg_10_0)
	TaskDispatcher.runRepeat(arg_10_0._updateFrame, arg_10_0, 0)
end

function var_0_0._endGame(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._updateFrame, arg_11_0)
	arg_11_0:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.End)
	arg_11_0._noteView:endGame()
	VersionActivity2_4MusicController.instance:stopBgm()
end

function var_0_0._pauseGame(arg_12_0)
	arg_12_0._progressTime = arg_12_0._progressTime + Time.time - arg_12_0._startTime

	TaskDispatcher.cancelTask(arg_12_0._updateFrame, arg_12_0)
	VersionActivity2_4MusicController.instance:pauseBgm()
	arg_12_0._noteView:refreshNoteGroupStatus(true)
end

function var_0_0._continueGame(arg_13_0)
	arg_13_0._startTime = Time.time

	TaskDispatcher.runRepeat(arg_13_0._updateFrame, arg_13_0, 0)
	VersionActivity2_4MusicController.instance:resumeBgm()
	arg_13_0._noteView:refreshNoteGroupStatus(false)
end

function var_0_0._updateFrame(arg_14_0)
	local var_14_0 = arg_14_0._progressTime + (Time.time - arg_14_0._startTime)

	arg_14_0:_updateTime(var_14_0)
	arg_14_0._noteView:updateNoteGroup(var_14_0)

	if var_14_0 >= arg_14_0._totalTime then
		arg_14_0._noteView:openResult()
		arg_14_0:_endGame()

		return
	end

	if SLFramework.FrameworkSettings.IsEditor and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
		arg_14_0._noteView:openResult(true)
		arg_14_0:_endGame()
	end
end

function var_0_0._editableInitView(arg_15_0)
	return
end

function var_0_0.onUpdateParam(arg_16_0)
	return
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0._episodeId = arg_17_0.viewParam

	VersionActivity2_4MusicBeatModel.instance:onStart(arg_17_0._episodeId)
	VersionActivity2_4MusicController.instance:onEnterBeatView(arg_17_0._episodeId)

	arg_17_0._noteView = arg_17_0.viewContainer:getNoteView()
	arg_17_0._episodeConfig = Activity179Config.instance:getEpisodeConfig(arg_17_0._episodeId)

	local var_17_0 = arg_17_0._episodeConfig.beatId

	arg_17_0._beatConfig = Activity179Config.instance:getBeatConfig(var_17_0)
	arg_17_0._txtmaxscore.text = "/" .. arg_17_0._beatConfig.targetId
	arg_17_0._audio = arg_17_0._beatConfig.resouce
	arg_17_0._totalTime = arg_17_0._beatConfig.time
	arg_17_0._progressTime = 0

	arg_17_0:_updateTime(0)
	arg_17_0:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.None)
	arg_17_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_17_0._onOpenView, arg_17_0)
	arg_17_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_17_0._onCloseViewFinish, arg_17_0)
	arg_17_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.BeatModeEnd, arg_17_0._onBeatModeEnd, arg_17_0)
end

function var_0_0._onBeatModeEnd(arg_18_0)
	arg_18_0:_endGame()
end

function var_0_0._onOpenView(arg_19_0, arg_19_1)
	if ViewHelper.instance:checkViewOnTheTop(arg_19_0.viewName) then
		return
	end

	if arg_19_0._status == VersionActivity2_4MusicEnum.BeatStatus.Playing then
		arg_19_0:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.Pause)
		arg_19_0:_pauseGame()

		return
	end

	if arg_19_0._status == VersionActivity2_4MusicEnum.BeatStatus.CountDown then
		TaskDispatcher.cancelTask(arg_19_0._countDownHandler, arg_19_0)
	end
end

function var_0_0._onCloseViewFinish(arg_20_0, arg_20_1)
	if not ViewHelper.instance:checkViewOnTheTop(arg_20_0.viewName) then
		return
	end

	if arg_20_0._status == VersionActivity2_4MusicEnum.BeatStatus.End then
		arg_20_0:_updateTime(0)
		arg_20_0:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.None)
		arg_20_0._noteView:initNoneStatus()
	end

	if arg_20_0._status == VersionActivity2_4MusicEnum.BeatStatus.Pause then
		arg_20_0:_startCountDown(function()
			arg_20_0:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.Playing)
			arg_20_0:_continueGame()
		end)

		return
	end

	if arg_20_0._status == VersionActivity2_4MusicEnum.BeatStatus.CountDown then
		TaskDispatcher.runRepeat(arg_20_0._countDownHandler, arg_20_0, 1)
	end
end

function var_0_0.isCountDown(arg_22_0)
	return arg_22_0._status == VersionActivity2_4MusicEnum.BeatStatus.CountDown
end

function var_0_0.isPlaying(arg_23_0)
	return arg_23_0._status ~= VersionActivity2_4MusicEnum.BeatStatus.None
end

function var_0_0._updateStatus(arg_24_0, arg_24_1)
	arg_24_0._status = arg_24_1

	arg_24_0:_updateBtnStatus()
end

function var_0_0._updateBtnStatus(arg_25_0)
	arg_25_0._hasFinished = Activity179Model.instance:episodeIsFinished(arg_25_0._episodeId)

	local var_25_0 = arg_25_0._status == VersionActivity2_4MusicEnum.BeatStatus.None
	local var_25_1 = arg_25_0._status == VersionActivity2_4MusicEnum.BeatStatus.CountDown
	local var_25_2 = arg_25_0._status == VersionActivity2_4MusicEnum.BeatStatus.Playing
	local var_25_3 = arg_25_0._status == VersionActivity2_4MusicEnum.BeatStatus.End

	gohelper.setActive(arg_25_0._btnstart, var_25_0)
	gohelper.setActive(arg_25_0._btnaccompany, var_25_0 or var_25_2 or var_25_3)
	gohelper.setActive(arg_25_0._btnskip, var_25_0 and arg_25_0._hasFinished)
	gohelper.setActive(arg_25_0._btnstop, var_25_2 or var_25_3)
	gohelper.setActive(arg_25_0._gocountdown, var_25_1)
	gohelper.setActive(arg_25_0._goblock, var_25_1)
end

function var_0_0._updateTime(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._totalTime - arg_26_1

	if var_26_0 < 0 then
		var_26_0 = 0
	end

	arg_26_0._txttime.text = TimeUtil.second2TimeString(var_26_0)
end

function var_0_0.onClose(arg_27_0)
	arg_27_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_27_0._onOpenView)
	arg_27_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_27_0._onCloseViewFinish)

	if arg_27_0._countDownId then
		AudioMgr.instance:stopPlayingID(arg_27_0._countDownId)

		arg_27_0._countDownId = nil
	end
end

function var_0_0.onDestroyView(arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._countDownHandler, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._updateFrame, arg_28_0)
end

return var_0_0
