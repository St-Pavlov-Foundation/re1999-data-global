module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatResultView", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicBeatResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gostoptitle = gohelper.findChild(arg_1_0.viewGO, "root/#go_stoptitle")
	arg_1_0._gofailtitle = gohelper.findChild(arg_1_0.viewGO, "root/#go_failtitle")
	arg_1_0._gosuccesstitle = gohelper.findChild(arg_1_0.viewGO, "root/#go_successtitle")
	arg_1_0._txtscorefailed = gohelper.findChildText(arg_1_0.viewGO, "root/scoregroup/#txt_scorefailed")
	arg_1_0._txtscore = gohelper.findChildText(arg_1_0.viewGO, "root/scoregroup/#txt_score")
	arg_1_0._txtmaxscore = gohelper.findChildText(arg_1_0.viewGO, "root/scoregroup/#txt_maxscore")
	arg_1_0._gocombolist = gohelper.findChild(arg_1_0.viewGO, "root/evaluatelayout/#go_combolist")
	arg_1_0._goevaluatelist = gohelper.findChild(arg_1_0.viewGO, "root/evaluatelayout/#go_evaluatelist")
	arg_1_0._btncontinuegame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btn/#btn_continuegame")
	arg_1_0._btnaccompany = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btn/#btn_accompany")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btn/#btn_restart")
	arg_1_0._btnquitgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btn/#btn_quitgame")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncontinuegame:AddClickListener(arg_2_0._btncontinuegameOnClick, arg_2_0)
	arg_2_0._btnaccompany:AddClickListener(arg_2_0._btnaccompanyOnClick, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnrestartOnClick, arg_2_0)
	arg_2_0._btnquitgame:AddClickListener(arg_2_0._btnquitgameOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncontinuegame:RemoveClickListener()
	arg_3_0._btnaccompany:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
	arg_3_0._btnquitgame:RemoveClickListener()
end

function var_0_0._btncontinuegameOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnaccompanyOnClick(arg_5_0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeAccompanyView()
end

function var_0_0._btnrestartOnClick(arg_6_0)
	VersionActivity2_4MusicController.instance:dispatchEvent(VersionActivity2_4MusicEvent.BeatModeEnd, arg_6_0._isPause)
	arg_6_0:closeThis()
end

function var_0_0._btnquitgameOnClick(arg_7_0)
	ViewMgr.instance:closeView(ViewName.VersionActivity2_4MusicBeatView)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.Bakaluoer.play_ui_diqiu_settle_accounts)
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._gradeList = VersionActivity2_4MusicBeatModel.instance:getGradleList()
	arg_10_0._episodeId = VersionActivity2_4MusicBeatModel.instance:getEpisodeId()
	arg_10_0._episodeConfig = Activity179Config.instance:getEpisodeConfig(arg_10_0._episodeId)
	arg_10_0._beatId = arg_10_0._episodeConfig.beatId
	arg_10_0._beatConfig = Activity179Config.instance:getBeatConfig(arg_10_0._beatId)
	arg_10_0._txtmaxscore.text = "/" .. arg_10_0._beatConfig.targetId
	arg_10_0._comboList = Activity179Config.instance:getComboList(arg_10_0._beatId)

	arg_10_0:_parseGradeList()

	arg_10_0._canPass = arg_10_0._beatConfig.targetId <= arg_10_0._totalScore
	arg_10_0._isPause = arg_10_0.viewParam and arg_10_0.viewParam.isPause
	arg_10_0._isForceSuccess = arg_10_0.viewParam and arg_10_0.viewParam.isForceSuccess

	if not arg_10_0._isPause then
		arg_10_0._isSuccess = arg_10_0._beatConfig.targetId <= arg_10_0._totalScore
		arg_10_0._isFail = not arg_10_0._isSuccess
	else
		arg_10_0._isSuccess = false
		arg_10_0._isFail = false
	end

	if arg_10_0._isForceSuccess then
		arg_10_0._isSuccess = true
		arg_10_0._isFail = false
	end

	gohelper.setActive(arg_10_0._btncontinuegame, arg_10_0._isPause)
	gohelper.setActive(arg_10_0._btnaccompany, arg_10_0._isPause)
	gohelper.setActive(arg_10_0._gostoptitle, arg_10_0._isPause)
	gohelper.setActive(arg_10_0._gofailtitle, arg_10_0._isFail)
	gohelper.setActive(arg_10_0._gosuccesstitle, arg_10_0._isSuccess)
	gohelper.setActive(arg_10_0._txtscore, arg_10_0._canPass)
	gohelper.setActive(arg_10_0._txtscorefailed, not arg_10_0._canPass)
end

function var_0_0._getComboConfig(arg_11_0, arg_11_1)
	for iter_11_0 = #arg_11_0._comboList, 1, -1 do
		local var_11_0 = arg_11_0._comboList[iter_11_0]

		if arg_11_1 >= var_11_0.combo or iter_11_0 == 1 then
			return var_11_0, iter_11_0
		end
	end
end

function var_0_0._parseGradeList(arg_12_0)
	arg_12_0._totalScore = 0
	arg_12_0._gradeValues = {}

	local var_12_0 = 0
	local var_12_1 = 0

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._gradeList) do
		local var_12_2 = arg_12_0._gradeValues[iter_12_1] or 0

		arg_12_0._gradeValues[iter_12_1] = var_12_2 + 1

		if iter_12_1 == VersionActivity2_4MusicEnum.BeatGrade.Miss then
			var_12_0 = 0
		else
			var_12_0 = var_12_0 + 1
			var_12_1 = math.max(var_12_1, var_12_0)
		end
	end

	local var_12_3, var_12_4 = arg_12_0:_getComboConfig(var_12_1)
	local var_12_5 = var_12_1 >= var_12_3.combo and 1 or 0
	local var_12_6 = var_12_3.score * var_12_5

	arg_12_0._totalScore = arg_12_0._totalScore + var_12_6

	arg_12_0:_addComboItem(var_12_4, var_12_1, var_12_6)

	for iter_12_2 = VersionActivity2_4MusicEnum.BeatGrade.Perfect, VersionActivity2_4MusicEnum.BeatGrade.Miss do
		local var_12_7 = arg_12_0._gradeValues[iter_12_2] or 0
		local var_12_8 = VersionActivity2_4MusicBeatModel.instance:getGradeScore(iter_12_2)

		arg_12_0._totalScore = arg_12_0._totalScore + var_12_8 * var_12_7
	end

	arg_12_0._curIndex = VersionActivity2_4MusicEnum.BeatGrade.Perfect

	TaskDispatcher.cancelTask(arg_12_0._createItem, arg_12_0)
	TaskDispatcher.runRepeat(arg_12_0._createItem, arg_12_0, 0.16)
	arg_12_0:_createItem()

	arg_12_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, arg_12_0._totalScore, 0.3, arg_12_0._scoreAnimFrame, arg_12_0._scoreAnimFinish, arg_12_0)
end

function var_0_0._scoreAnimFrame(arg_13_0, arg_13_1)
	local var_13_0 = math.floor(arg_13_1)

	arg_13_0._txtscore.text = var_13_0
	arg_13_0._txtscorefailed.text = var_13_0
end

function var_0_0._scoreAnimFinish(arg_14_0)
	arg_14_0._txtscore.text = arg_14_0._totalScore
	arg_14_0._txtscorefailed.text = arg_14_0._totalScore
end

function var_0_0._createItem(arg_15_0)
	local var_15_0 = arg_15_0._gradeValues[arg_15_0._curIndex] or 0

	arg_15_0:_addGradeItem(arg_15_0._curIndex, var_15_0)

	arg_15_0._curIndex = arg_15_0._curIndex + 1

	if arg_15_0._curIndex > VersionActivity2_4MusicEnum.BeatGrade.Miss then
		TaskDispatcher.cancelTask(arg_15_0._createItem, arg_15_0)
	end
end

function var_0_0._addComboItem(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0.viewContainer:getSetting().otherRes[1]
	local var_16_1 = arg_16_0:getResInst(var_16_0, arg_16_0._gocombolist)

	MonoHelper.addNoUpdateLuaComOnceToGo(var_16_1, VersionActivity2_4MusicBeatResultComboItem):onUpdateMO(arg_16_1, arg_16_2, arg_16_3)
end

function var_0_0._addGradeItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.viewContainer:getSetting().otherRes[2]
	local var_17_1 = arg_17_0:getResInst(var_17_0, arg_17_0._goevaluatelist)

	MonoHelper.addNoUpdateLuaComOnceToGo(var_17_1, VersionActivity2_4MusicBeatResultEvaluateItem):onUpdateMO(arg_17_1, arg_17_2)
end

function var_0_0.onClose(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._createItem, arg_18_0)

	if arg_18_0._tweenId then
		ZProj.TweenHelper.KillById(arg_18_0._tweenId)

		arg_18_0._tweenId = nil
	end
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0
