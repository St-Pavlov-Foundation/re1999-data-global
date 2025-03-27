module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatView", package.seeall)

slot0 = class("VersionActivity2_4MusicBeatView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotopleftbtn = gohelper.findChild(slot0.viewGO, "root/#go_topleftbtn")
	slot0._txtscore = gohelper.findChildText(slot0.viewGO, "root/scoregroup/#txt_score")
	slot0._txtmaxscore = gohelper.findChildText(slot0.viewGO, "root/scoregroup/#txt_maxscore")
	slot0._gocombo = gohelper.findChild(slot0.viewGO, "root/#go_combo")
	slot0._gostate1 = gohelper.findChild(slot0.viewGO, "root/#go_combo/#go_state1")
	slot0._txtnum1 = gohelper.findChildText(slot0.viewGO, "root/#go_combo/#go_state1/#txt_num1")
	slot0._gostate2 = gohelper.findChild(slot0.viewGO, "root/#go_combo/#go_state2")
	slot0._txtnum2 = gohelper.findChildText(slot0.viewGO, "root/#go_combo/#go_state2/#txt_num2")
	slot0._gostate3 = gohelper.findChild(slot0.viewGO, "root/#go_combo/#go_state3")
	slot0._txtnum3 = gohelper.findChildText(slot0.viewGO, "root/#go_combo/#go_state3/#txt_num3")
	slot0._btnstop = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btn/#btn_stop")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btn/#btn_skip")
	slot0._btnaccompany = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btn/#btn_accompany")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "root/timebg/#txt_time")
	slot0._gomissclick = gohelper.findChild(slot0.viewGO, "root/#go_missclick")
	slot0._gobeatgrid = gohelper.findChild(slot0.viewGO, "root/#go_beatgrid")
	slot0._gobeatitem = gohelper.findChild(slot0.viewGO, "root/#go_beatgrid/#go_beatitem")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_start")
	slot0._gocountdown = gohelper.findChild(slot0.viewGO, "root/#go_countdown")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "root/#go_countdown/#txt_num")
	slot0._goblock = gohelper.findChild(slot0.viewGO, "#go_block")
	slot0._goleft = gohelper.findChild(slot0.viewGO, "#go_left")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstop:AddClickListener(slot0._btnstopOnClick, slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
	slot0._btnaccompany:AddClickListener(slot0._btnaccompanyOnClick, slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstop:RemoveClickListener()
	slot0._btnskip:RemoveClickListener()
	slot0._btnaccompany:RemoveClickListener()
	slot0._btnstart:RemoveClickListener()
end

function slot0._btnstopOnClick(slot0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicBeatResultView({
		isPause = true
	})
end

function slot0._btnskipOnClick(slot0)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.Skip)
	StoryController.instance:playStory(slot0._episodeConfig.storyAfter, nil, slot0.closeThis, slot0)
end

function slot0._btnaccompanyOnClick(slot0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeAccompanyView()
end

function slot0._btnstartOnClick(slot0)
	slot0:_startCountDown(slot0._startGame)
end

function slot0._startCountDown(slot0, slot1)
	slot0._countDownCallback = slot1

	slot0:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.CountDown)

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

function slot0._startGame(slot0)
	slot0:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.Playing)

	slot0._startTime = Time.time
	slot0._progressTime = 0

	slot0._noteView:startGame()
	VersionActivity2_4MusicController.instance:playBgm(slot0._audio)
	TaskDispatcher.cancelTask(slot0._updateFrame, slot0)
	TaskDispatcher.runRepeat(slot0._updateFrame, slot0, 0)
end

function slot0._endGame(slot0)
	TaskDispatcher.cancelTask(slot0._updateFrame, slot0)
	slot0:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.End)
	slot0._noteView:endGame()
	VersionActivity2_4MusicController.instance:stopBgm()
end

function slot0._pauseGame(slot0)
	slot0._progressTime = slot0._progressTime + Time.time - slot0._startTime

	TaskDispatcher.cancelTask(slot0._updateFrame, slot0)
	VersionActivity2_4MusicController.instance:pauseBgm()
	slot0._noteView:refreshNoteGroupStatus(true)
end

function slot0._continueGame(slot0)
	slot0._startTime = Time.time

	TaskDispatcher.runRepeat(slot0._updateFrame, slot0, 0)
	VersionActivity2_4MusicController.instance:resumeBgm()
	slot0._noteView:refreshNoteGroupStatus(false)
end

function slot0._updateFrame(slot0)
	slot1 = slot0._progressTime + Time.time - slot0._startTime

	slot0:_updateTime(slot1)
	slot0._noteView:updateNoteGroup(slot1)

	if slot0._totalTime <= slot1 then
		slot0._noteView:openResult()
		slot0:_endGame()

		return
	end

	if SLFramework.FrameworkSettings.IsEditor and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.W) then
		slot0._noteView:openResult(true)
		slot0:_endGame()
	end
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._episodeId = slot0.viewParam

	VersionActivity2_4MusicBeatModel.instance:onStart(slot0._episodeId)
	VersionActivity2_4MusicController.instance:onEnterBeatView(slot0._episodeId)

	slot0._noteView = slot0.viewContainer:getNoteView()
	slot0._episodeConfig = Activity179Config.instance:getEpisodeConfig(slot0._episodeId)
	slot0._beatConfig = Activity179Config.instance:getBeatConfig(slot0._episodeConfig.beatId)
	slot0._txtmaxscore.text = "/" .. slot0._beatConfig.targetId
	slot0._audio = slot0._beatConfig.resouce
	slot0._totalTime = slot0._beatConfig.time
	slot0._progressTime = 0

	slot0:_updateTime(0)
	slot0:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.None)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.BeatModeEnd, slot0._onBeatModeEnd, slot0)
end

function slot0._onBeatModeEnd(slot0)
	slot0:_endGame()
end

function slot0._onOpenView(slot0, slot1)
	if ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	if slot0._status == VersionActivity2_4MusicEnum.BeatStatus.Playing then
		slot0:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.Pause)
		slot0:_pauseGame()

		return
	end

	if slot0._status == VersionActivity2_4MusicEnum.BeatStatus.CountDown then
		TaskDispatcher.cancelTask(slot0._countDownHandler, slot0)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	if slot0._status == VersionActivity2_4MusicEnum.BeatStatus.End then
		slot0:_updateTime(0)
		slot0:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.None)
		slot0._noteView:initNoneStatus()
	end

	if slot0._status == VersionActivity2_4MusicEnum.BeatStatus.Pause then
		slot0:_startCountDown(function ()
			uv0:_updateStatus(VersionActivity2_4MusicEnum.BeatStatus.Playing)
			uv0:_continueGame()
		end)

		return
	end

	if slot0._status == VersionActivity2_4MusicEnum.BeatStatus.CountDown then
		TaskDispatcher.runRepeat(slot0._countDownHandler, slot0, 1)
	end
end

function slot0.isCountDown(slot0)
	return slot0._status == VersionActivity2_4MusicEnum.BeatStatus.CountDown
end

function slot0.isPlaying(slot0)
	return slot0._status ~= VersionActivity2_4MusicEnum.BeatStatus.None
end

function slot0._updateStatus(slot0, slot1)
	slot0._status = slot1

	slot0:_updateBtnStatus()
end

function slot0._updateBtnStatus(slot0)
	slot0._hasFinished = Activity179Model.instance:episodeIsFinished(slot0._episodeId)
	slot1 = slot0._status == VersionActivity2_4MusicEnum.BeatStatus.None
	slot2 = slot0._status == VersionActivity2_4MusicEnum.BeatStatus.CountDown
	slot3 = slot0._status == VersionActivity2_4MusicEnum.BeatStatus.Playing
	slot4 = slot0._status == VersionActivity2_4MusicEnum.BeatStatus.End

	gohelper.setActive(slot0._btnstart, slot1)
	gohelper.setActive(slot0._btnaccompany, slot1 or slot3 or slot4)
	gohelper.setActive(slot0._btnskip, slot1 and slot0._hasFinished)
	gohelper.setActive(slot0._btnstop, slot3 or slot4)
	gohelper.setActive(slot0._gocountdown, slot2)
	gohelper.setActive(slot0._goblock, slot2)
end

function slot0._updateTime(slot0, slot1)
	if slot0._totalTime - slot1 < 0 then
		slot2 = 0
	end

	slot0._txttime.text = TimeUtil.second2TimeString(slot2)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish)

	if slot0._countDownId then
		AudioMgr.instance:stopPlayingID(slot0._countDownId)

		slot0._countDownId = nil
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._countDownHandler, slot0)
	TaskDispatcher.cancelTask(slot0._updateFrame, slot0)
end

return slot0
