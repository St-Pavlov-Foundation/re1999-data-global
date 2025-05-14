module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatNoteView", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicBeatNoteView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocombo = gohelper.findChild(arg_1_0.viewGO, "root/#go_combo")
	arg_1_0._gostate1 = gohelper.findChild(arg_1_0.viewGO, "root/#go_combo/#go_state1")
	arg_1_0._txtnum1 = gohelper.findChildText(arg_1_0.viewGO, "root/#go_combo/#go_state1/#txt_num1")
	arg_1_0._gostate2 = gohelper.findChild(arg_1_0.viewGO, "root/#go_combo/#go_state2")
	arg_1_0._txtnum2 = gohelper.findChildText(arg_1_0.viewGO, "root/#go_combo/#go_state2/#txt_num2")
	arg_1_0._gostate3 = gohelper.findChild(arg_1_0.viewGO, "root/#go_combo/#go_state3")
	arg_1_0._txtnum3 = gohelper.findChildText(arg_1_0.viewGO, "root/#go_combo/#go_state3/#txt_num3")
	arg_1_0._gobeatitem = gohelper.findChild(arg_1_0.viewGO, "root/#go_beatgrid/#go_beatitem")
	arg_1_0._gomissclick = gohelper.findChild(arg_1_0.viewGO, "root/#go_missclick")
	arg_1_0._txtscore = gohelper.findChildText(arg_1_0.viewGO, "root/scoregroup/#txt_score")
	arg_1_0._gobeatgrid = gohelper.findChild(arg_1_0.viewGO, "root/#go_beatgrid")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._gradeValues = {}

	arg_4_0:_initStats()

	arg_4_0._uiclick = SLFramework.UGUI.UIClickListener.Get(arg_4_0._gomissclick)

	arg_4_0._uiclick:AddClickDownListener(arg_4_0._onClickDown, arg_4_0)
	arg_4_0._uiclick:AddClickUpListener(arg_4_0._onClickUp, arg_4_0)

	arg_4_0._addAnimator = gohelper.findChild(arg_4_0.viewGO, "root/scoregroup"):GetComponent("Animator")

	arg_4_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.BeatModeEnd, arg_4_0._onBeatModeEnd, arg_4_0)
	arg_4_0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.Skip, arg_4_0._onSkip, arg_4_0)
end

function var_0_0._onBeatModeEnd(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	VersionActivity2_4MusicController.instance:trackBeatView(VersionActivity2_4MusicEnum.BeatResult.Restart, arg_5_0._totalScore, arg_5_0:_getGradeStat())
end

function var_0_0._initStats(arg_6_0)
	gohelper.setActive(arg_6_0._gostate1, false)
	gohelper.setActive(arg_6_0._gostate2, false)
	gohelper.setActive(arg_6_0._gostate3, false)
end

function var_0_0._onClickDown(arg_7_0)
	arg_7_0._clickScreenPos = GamepadController.instance:getMousePosition()
end

function var_0_0._onClickUp(arg_8_0)
	return
end

function var_0_0.onClose(arg_9_0)
	arg_9_0._uiclick:RemoveClickDownListener()
	arg_9_0._uiclick:RemoveClickUpListener()

	if not arg_9_0._isSkipClose then
		VersionActivity2_4MusicController.instance:trackBeatView(VersionActivity2_4MusicEnum.BeatResult.Abort, arg_9_0._totalScore, arg_9_0:_getGradeStat())
	end
end

function var_0_0._onSkip(arg_10_0)
	arg_10_0._isSkipClose = true

	VersionActivity2_4MusicController.instance:trackBeatView(VersionActivity2_4MusicEnum.BeatResult.Abort, arg_10_0._totalScore, arg_10_0:_getGradeStat())
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._episodeId = arg_11_0.viewParam
	arg_11_0._episodeConfig = Activity179Config.instance:getEpisodeConfig(arg_11_0._episodeId)
	arg_11_0._beatId = arg_11_0._episodeConfig.beatId
	arg_11_0._beatConfig = Activity179Config.instance:getBeatConfig(arg_11_0._beatId)
	arg_11_0._noteGroupId = arg_11_0._beatConfig.noteGroupId
	arg_11_0._noteGroupList = lua_activity179_note.configDict[arg_11_0._noteGroupId]
	arg_11_0._noteIndex = 0
	arg_11_0._noteHideIndex = 0
	arg_11_0._cacheNoteList = arg_11_0:getUserDataTb_()
	arg_11_0._comboList = Activity179Config.instance:getComboList(arg_11_0._beatId)
	arg_11_0._totalScore = 0

	arg_11_0:_initPosList()
end

function var_0_0.onOpenFinish(arg_12_0)
	arg_12_0._showTime = VersionActivity2_4MusicBeatModel.instance:getShowTime()
end

function var_0_0._initPosList(arg_13_0)
	arg_13_0._posGoList = arg_13_0:getUserDataTb_()

	table.insert(arg_13_0._posGoList, arg_13_0._gobeatitem)

	for iter_13_0 = 1, 29 do
		local var_13_0 = gohelper.cloneInPlace(arg_13_0._gobeatitem)

		table.insert(arg_13_0._posGoList, var_13_0)
	end
end

function var_0_0.openResult(arg_14_0, arg_14_1)
	arg_14_0._isForceSuccess = arg_14_1

	local var_14_0 = arg_14_1 or arg_14_0._totalScore >= arg_14_0._beatConfig.targetId

	VersionActivity2_4MusicController.instance:trackBeatView(var_14_0 and VersionActivity2_4MusicEnum.BeatResult.Success or VersionActivity2_4MusicEnum.BeatResult.Fail, arg_14_0._totalScore, arg_14_0:_getGradeStat())

	if var_14_0 then
		Activity179Rpc.instance:sendSet179ScoreRequest(Activity179Model.instance:getActivityId(), arg_14_0._episodeId, arg_14_0._beatConfig.targetId)

		if VersionActivity2_4MusicBeatModel.instance:getSuccessCount() == 0 then
			VersionActivity2_4MusicBeatModel.instance:setSuccessCount(1)
			StoryController.instance:playStory(arg_14_0._episodeConfig.storyAfter, nil, function()
				VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicBeatResultView({
					isForceSuccess = arg_14_0._isForceSuccess
				})
			end)

			return
		end
	end

	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicBeatResultView({
		isForceSuccess = arg_14_0._isForceSuccess
	})
end

function var_0_0.startGame(arg_16_0)
	arg_16_0._noteIndex = 0
	arg_16_0._noteHideIndex = 0
	arg_16_0._gradeList = {}

	VersionActivity2_4MusicBeatModel.instance:updateGradleList(arg_16_0._gradeList)

	arg_16_0._txtscore.text = "0"
	arg_16_0._playNoteList = arg_16_0:getUserDataTb_()
end

function var_0_0.endGame(arg_17_0)
	for iter_17_0 = #arg_17_0._playNoteList, 1, -1 do
		local var_17_0 = arg_17_0._playNoteList[iter_17_0]

		var_17_0:hide()
		table.remove(arg_17_0._playNoteList, iter_17_0)
		table.insert(arg_17_0._cacheNoteList, var_17_0)
	end

	arg_17_0._totalScore = 0
	arg_17_0._gradeValues = {}
end

function var_0_0.initNoneStatus(arg_18_0)
	arg_18_0:_initStats()

	arg_18_0._txtscore.text = "0"
end

function var_0_0._addGrad(arg_19_0, arg_19_1)
	table.insert(arg_19_0._gradeList, arg_19_1)
	VersionActivity2_4MusicBeatModel.instance:updateGradleList(arg_19_0._gradeList)

	local var_19_0 = 0

	for iter_19_0 = #arg_19_0._gradeList, 1, -1 do
		if arg_19_0._gradeList[iter_19_0] == VersionActivity2_4MusicEnum.BeatGrade.Miss then
			break
		end

		var_19_0 = var_19_0 + 1
	end

	local var_19_1 = 0

	if var_19_0 > 1 then
		local var_19_2, var_19_3 = arg_19_0:_getComboConfig(var_19_0)

		var_19_1 = var_19_3
	end

	gohelper.setActive(arg_19_0._gostate1, var_19_1 == 1)
	gohelper.setActive(arg_19_0._gostate2, var_19_1 == 2)
	gohelper.setActive(arg_19_0._gostate3, var_19_1 == 3)

	if var_19_1 ~= 0 then
		arg_19_0["_txtnum" .. var_19_1].text = VersionActivity2_4MusicEnum.times_sign .. var_19_0
	end

	local var_19_4 = arg_19_0._totalScore

	arg_19_0:_parseGradeList()

	if var_19_4 < arg_19_0._totalScore then
		arg_19_0._addAnimator:Play("add", 0, 0)
	end
end

function var_0_0._getComboConfig(arg_20_0, arg_20_1)
	for iter_20_0 = #arg_20_0._comboList, 1, -1 do
		local var_20_0 = arg_20_0._comboList[iter_20_0]

		if arg_20_1 >= var_20_0.combo or iter_20_0 == 1 then
			return var_20_0, iter_20_0
		end
	end
end

function var_0_0._parseGradeList(arg_21_0)
	arg_21_0._totalScore = 0
	arg_21_0._gradeValues = {}

	local var_21_0 = 0
	local var_21_1 = 0

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._gradeList) do
		local var_21_2 = arg_21_0._gradeValues[iter_21_1] or 0

		arg_21_0._gradeValues[iter_21_1] = var_21_2 + 1

		if iter_21_1 == VersionActivity2_4MusicEnum.BeatGrade.Miss then
			var_21_0 = 0
		else
			var_21_0 = var_21_0 + 1
			var_21_1 = math.max(var_21_1, var_21_0)
		end
	end

	local var_21_3, var_21_4 = arg_21_0:_getComboConfig(var_21_1)
	local var_21_5 = var_21_1 >= var_21_3.combo and 1 or 0
	local var_21_6 = var_21_3.score * var_21_5

	arg_21_0._totalScore = arg_21_0._totalScore + var_21_6

	for iter_21_2 = VersionActivity2_4MusicEnum.BeatGrade.Perfect, VersionActivity2_4MusicEnum.BeatGrade.Cool do
		local var_21_7 = arg_21_0._gradeValues[iter_21_2] or 0
		local var_21_8 = VersionActivity2_4MusicBeatModel.instance:getGradeScore(iter_21_2)

		arg_21_0._totalScore = arg_21_0._totalScore + var_21_8 * var_21_7
	end

	arg_21_0._txtscore.text = arg_21_0._totalScore
end

function var_0_0._getGradeStat(arg_22_0)
	arg_22_0._gradeStat = arg_22_0._gradeStat or {}

	for iter_22_0 = VersionActivity2_4MusicEnum.BeatGrade.Perfect, VersionActivity2_4MusicEnum.BeatGrade.Miss do
		local var_22_0 = arg_22_0._gradeValues[iter_22_0] or 0

		arg_22_0._gradeStat[VersionActivity2_4MusicEnum.BeatGradeStatName[iter_22_0]] = var_22_0
	end

	return arg_22_0._gradeStat
end

function var_0_0.refreshNoteGroupStatus(arg_23_0, arg_23_1)
	for iter_23_0 = #arg_23_0._playNoteList, 1, -1 do
		local var_23_0 = arg_23_0._playNoteList[iter_23_0]

		if arg_23_1 then
			var_23_0:pause()
		else
			var_23_0:resume()
		end
	end
end

function var_0_0.updateNoteGroup(arg_24_0, arg_24_1)
	local var_24_0

	if arg_24_0._clickScreenPos then
		local var_24_1 = recthelper.screenPosToAnchorPos(arg_24_0._clickScreenPos, arg_24_0._gobeatgrid.transform)

		arg_24_0._clickScreenPos = nil

		for iter_24_0 = #arg_24_0._playNoteList, 1, -1 do
			local var_24_2 = arg_24_0._playNoteList[iter_24_0]

			if not var_24_2:getGrade() then
				local var_24_3 = Vector2.Distance(var_24_1, var_24_2.viewGO.transform.parent.anchoredPosition)

				if not var_24_0 then
					var_24_0 = var_24_2
					var_24_0._distance = var_24_3
				elseif var_24_3 < var_24_0._distance then
					var_24_0 = var_24_2
					var_24_0._distance = var_24_3
				end
			end
		end
	end

	for iter_24_1 = #arg_24_0._playNoteList, 1, -1 do
		local var_24_4 = arg_24_0._playNoteList[iter_24_1]

		var_24_4:updateFrame(arg_24_1)

		if var_24_4:timeout(arg_24_1) then
			var_24_4:setTimeoutMiss()
		end

		if var_24_4:disappear(arg_24_1) then
			var_24_4:hide()
			table.remove(arg_24_0._playNoteList, iter_24_1)
			table.insert(arg_24_0._cacheNoteList, var_24_4)
		end

		if var_24_4 == var_24_0 then
			var_24_4:setMiss()
		end

		local var_24_5 = var_24_4:getGrade()

		if var_24_5 and not var_24_4:isSubmitted() then
			var_24_4:setSubmit()
			arg_24_0:_addGrad(var_24_5)
		end
	end

	arg_24_0._isClickDown = false

	local var_24_6 = Activity179Model.instance:getCalibration()

	for iter_24_2 = arg_24_0._noteIndex + 1, #arg_24_0._noteGroupList do
		local var_24_7 = arg_24_0._noteGroupList[iter_24_2]

		if arg_24_1 >= var_24_7.time - var_24_6 + arg_24_0._showTime then
			arg_24_0._noteIndex = iter_24_2

			if var_24_7.buttonId > 0 then
				arg_24_0:_addNote(var_24_7, arg_24_1)
			end
		end
	end

	for iter_24_3 = arg_24_0._noteHideIndex + 1, #arg_24_0._noteGroupList do
		local var_24_8 = arg_24_0._noteGroupList[iter_24_3]

		if arg_24_1 >= var_24_8.time then
			arg_24_0._noteHideIndex = iter_24_3

			AudioMgr.instance:trigger(var_24_8.eventName)
		else
			break
		end
	end
end

function var_0_0._addNote(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0:_getNoteItem()

	var_25_0:onUpdateMO(arg_25_1, arg_25_0._posGoList[arg_25_1.buttonId], arg_25_2)
	table.insert(arg_25_0._playNoteList, var_25_0)
end

function var_0_0._getNoteItem(arg_26_0)
	local var_26_0 = table.remove(arg_26_0._cacheNoteList)

	if var_26_0 then
		return var_26_0
	end

	local var_26_1 = arg_26_0.viewContainer:getSetting().otherRes[1]
	local var_26_2 = arg_26_0:getResInst(var_26_1)

	return (MonoHelper.addNoUpdateLuaComOnceToGo(var_26_2, VersionActivity2_4MusicBeatItem))
end

return var_0_0
