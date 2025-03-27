module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatResultView", package.seeall)

slot0 = class("VersionActivity2_4MusicBeatResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._gostoptitle = gohelper.findChild(slot0.viewGO, "root/#go_stoptitle")
	slot0._gofailtitle = gohelper.findChild(slot0.viewGO, "root/#go_failtitle")
	slot0._gosuccesstitle = gohelper.findChild(slot0.viewGO, "root/#go_successtitle")
	slot0._txtscorefailed = gohelper.findChildText(slot0.viewGO, "root/scoregroup/#txt_scorefailed")
	slot0._txtscore = gohelper.findChildText(slot0.viewGO, "root/scoregroup/#txt_score")
	slot0._txtmaxscore = gohelper.findChildText(slot0.viewGO, "root/scoregroup/#txt_maxscore")
	slot0._gocombolist = gohelper.findChild(slot0.viewGO, "root/evaluatelayout/#go_combolist")
	slot0._goevaluatelist = gohelper.findChild(slot0.viewGO, "root/evaluatelayout/#go_evaluatelist")
	slot0._btncontinuegame = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btn/#btn_continuegame")
	slot0._btnaccompany = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btn/#btn_accompany")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btn/#btn_restart")
	slot0._btnquitgame = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/btn/#btn_quitgame")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncontinuegame:AddClickListener(slot0._btncontinuegameOnClick, slot0)
	slot0._btnaccompany:AddClickListener(slot0._btnaccompanyOnClick, slot0)
	slot0._btnrestart:AddClickListener(slot0._btnrestartOnClick, slot0)
	slot0._btnquitgame:AddClickListener(slot0._btnquitgameOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncontinuegame:RemoveClickListener()
	slot0._btnaccompany:RemoveClickListener()
	slot0._btnrestart:RemoveClickListener()
	slot0._btnquitgame:RemoveClickListener()
end

function slot0._btncontinuegameOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnaccompanyOnClick(slot0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeAccompanyView()
end

function slot0._btnrestartOnClick(slot0)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.BeatModeEnd, slot0._isPause)
	slot0:closeThis()
end

function slot0._btnquitgameOnClick(slot0)
	ViewMgr.instance:closeView(ViewName.VersionActivity2_4MusicBeatView)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	AudioMgr.instance:trigger(AudioEnum.Bakaluoer.play_ui_diqiu_settle_accounts)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._gradeList = VersionActivity2_4MusicBeatModel.instance:getGradleList()
	slot0._episodeId = VersionActivity2_4MusicBeatModel.instance:getEpisodeId()
	slot0._episodeConfig = Activity179Config.instance:getEpisodeConfig(slot0._episodeId)
	slot0._beatId = slot0._episodeConfig.beatId
	slot0._beatConfig = Activity179Config.instance:getBeatConfig(slot0._beatId)
	slot0._txtmaxscore.text = "/" .. slot0._beatConfig.targetId
	slot0._comboList = Activity179Config.instance:getComboList(slot0._beatId)

	slot0:_parseGradeList()

	slot0._canPass = slot0._beatConfig.targetId <= slot0._totalScore
	slot0._isPause = slot0.viewParam and slot0.viewParam.isPause
	slot0._isForceSuccess = slot0.viewParam and slot0.viewParam.isForceSuccess

	if not slot0._isPause then
		slot0._isSuccess = slot0._beatConfig.targetId <= slot0._totalScore
		slot0._isFail = not slot0._isSuccess
	else
		slot0._isSuccess = false
		slot0._isFail = false
	end

	if slot0._isForceSuccess then
		slot0._isSuccess = true
		slot0._isFail = false
	end

	gohelper.setActive(slot0._btncontinuegame, slot0._isPause)
	gohelper.setActive(slot0._btnaccompany, slot0._isPause)
	gohelper.setActive(slot0._gostoptitle, slot0._isPause)
	gohelper.setActive(slot0._gofailtitle, slot0._isFail)
	gohelper.setActive(slot0._gosuccesstitle, slot0._isSuccess)
	gohelper.setActive(slot0._txtscore, slot0._canPass)
	gohelper.setActive(slot0._txtscorefailed, not slot0._canPass)
end

function slot0._getComboConfig(slot0, slot1)
	for slot6 = #slot0._comboList, 1, -1 do
		if slot0._comboList[slot6].combo <= slot1 or slot6 == 1 then
			return slot7, slot6
		end
	end
end

function slot0._parseGradeList(slot0)
	slot0._totalScore = 0
	slot0._gradeValues = {}
	slot1 = 0
	slot2 = 0

	for slot6, slot7 in ipairs(slot0._gradeList) do
		slot0._gradeValues[slot7] = (slot0._gradeValues[slot7] or 0) + 1

		if slot7 == VersionActivity2_4MusicEnum.BeatGrade.Miss then
			slot1 = 0
		else
			slot2 = math.max(slot2, slot1 + 1)
		end
	end

	slot3, slot4 = slot0:_getComboConfig(slot2)
	slot6 = slot3.score * (slot3.combo <= slot2 and 1 or 0)
	slot0._totalScore = slot0._totalScore + slot6

	slot0:_addComboItem(slot4, slot2, slot6)

	for slot10 = VersionActivity2_4MusicEnum.BeatGrade.Perfect, VersionActivity2_4MusicEnum.BeatGrade.Miss do
		slot0._totalScore = slot0._totalScore + VersionActivity2_4MusicBeatModel.instance:getGradeScore(slot10) * (slot0._gradeValues[slot10] or 0)
	end

	slot0._curIndex = VersionActivity2_4MusicEnum.BeatGrade.Perfect

	TaskDispatcher.cancelTask(slot0._createItem, slot0)
	TaskDispatcher.runRepeat(slot0._createItem, slot0, 0.16)
	slot0:_createItem()

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, slot0._totalScore, 0.3, slot0._scoreAnimFrame, slot0._scoreAnimFinish, slot0)
end

function slot0._scoreAnimFrame(slot0, slot1)
	slot2 = math.floor(slot1)
	slot0._txtscore.text = slot2
	slot0._txtscorefailed.text = slot2
end

function slot0._scoreAnimFinish(slot0)
	slot0._txtscore.text = slot0._totalScore
	slot0._txtscorefailed.text = slot0._totalScore
end

function slot0._createItem(slot0)
	slot0:_addGradeItem(slot0._curIndex, slot0._gradeValues[slot0._curIndex] or 0)

	slot0._curIndex = slot0._curIndex + 1

	if VersionActivity2_4MusicEnum.BeatGrade.Miss < slot0._curIndex then
		TaskDispatcher.cancelTask(slot0._createItem, slot0)
	end
end

function slot0._addComboItem(slot0, slot1, slot2, slot3)
	MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gocombolist), VersionActivity2_4MusicBeatResultComboItem):onUpdateMO(slot1, slot2, slot3)
end

function slot0._addGradeItem(slot0, slot1, slot2)
	MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._goevaluatelist), VersionActivity2_4MusicBeatResultEvaluateItem):onUpdateMO(slot1, slot2)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._createItem, slot0)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
