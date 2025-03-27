module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicBeatNoteView", package.seeall)

slot0 = class("VersionActivity2_4MusicBeatNoteView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocombo = gohelper.findChild(slot0.viewGO, "root/#go_combo")
	slot0._gostate1 = gohelper.findChild(slot0.viewGO, "root/#go_combo/#go_state1")
	slot0._txtnum1 = gohelper.findChildText(slot0.viewGO, "root/#go_combo/#go_state1/#txt_num1")
	slot0._gostate2 = gohelper.findChild(slot0.viewGO, "root/#go_combo/#go_state2")
	slot0._txtnum2 = gohelper.findChildText(slot0.viewGO, "root/#go_combo/#go_state2/#txt_num2")
	slot0._gostate3 = gohelper.findChild(slot0.viewGO, "root/#go_combo/#go_state3")
	slot0._txtnum3 = gohelper.findChildText(slot0.viewGO, "root/#go_combo/#go_state3/#txt_num3")
	slot0._gobeatitem = gohelper.findChild(slot0.viewGO, "root/#go_beatgrid/#go_beatitem")
	slot0._gomissclick = gohelper.findChild(slot0.viewGO, "root/#go_missclick")
	slot0._txtscore = gohelper.findChildText(slot0.viewGO, "root/scoregroup/#txt_score")
	slot0._gobeatgrid = gohelper.findChild(slot0.viewGO, "root/#go_beatgrid")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._gradeValues = {}

	slot0:_initStats()

	slot0._uiclick = SLFramework.UGUI.UIClickListener.Get(slot0._gomissclick)

	slot0._uiclick:AddClickDownListener(slot0._onClickDown, slot0)
	slot0._uiclick:AddClickUpListener(slot0._onClickUp, slot0)

	slot0._addAnimator = gohelper.findChild(slot0.viewGO, "root/scoregroup"):GetComponent("Animator")

	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.BeatModeEnd, slot0._onBeatModeEnd, slot0)
	slot0:addEventCb(VersionActivity2_4MusicController.instance, VersionActivity2_4MusicEvent.Skip, slot0._onSkip, slot0)
end

function slot0._onBeatModeEnd(slot0, slot1)
	if not slot1 then
		return
	end

	VersionActivity2_4MusicController.instance:trackBeatView(VersionActivity2_4MusicEnum.BeatResult.Restart, slot0._totalScore, slot0:_getGradeStat())
end

function slot0._initStats(slot0)
	gohelper.setActive(slot0._gostate1, false)
	gohelper.setActive(slot0._gostate2, false)
	gohelper.setActive(slot0._gostate3, false)
end

function slot0._onClickDown(slot0)
	slot0._clickScreenPos = GamepadController.instance:getMousePosition()
end

function slot0._onClickUp(slot0)
end

function slot0.onClose(slot0)
	slot0._uiclick:RemoveClickDownListener()
	slot0._uiclick:RemoveClickUpListener()

	if not slot0._isSkipClose then
		VersionActivity2_4MusicController.instance:trackBeatView(VersionActivity2_4MusicEnum.BeatResult.Abort, slot0._totalScore, slot0:_getGradeStat())
	end
end

function slot0._onSkip(slot0)
	slot0._isSkipClose = true

	VersionActivity2_4MusicController.instance:trackBeatView(VersionActivity2_4MusicEnum.BeatResult.Abort, slot0._totalScore, slot0:_getGradeStat())
end

function slot0.onOpen(slot0)
	slot0._episodeId = slot0.viewParam
	slot0._episodeConfig = Activity179Config.instance:getEpisodeConfig(slot0._episodeId)
	slot0._beatId = slot0._episodeConfig.beatId
	slot0._beatConfig = Activity179Config.instance:getBeatConfig(slot0._beatId)
	slot0._noteGroupId = slot0._beatConfig.noteGroupId
	slot0._noteGroupList = lua_activity179_note.configDict[slot0._noteGroupId]
	slot0._noteIndex = 0
	slot0._noteHideIndex = 0
	slot0._cacheNoteList = slot0:getUserDataTb_()
	slot0._comboList = Activity179Config.instance:getComboList(slot0._beatId)
	slot0._totalScore = 0

	slot0:_initPosList()
end

function slot0.onOpenFinish(slot0)
	slot0._showTime = VersionActivity2_4MusicBeatModel.instance:getShowTime()
end

function slot0._initPosList(slot0)
	slot0._posGoList = slot0:getUserDataTb_()

	table.insert(slot0._posGoList, slot0._gobeatitem)

	for slot4 = 1, 29 do
		table.insert(slot0._posGoList, gohelper.cloneInPlace(slot0._gobeatitem))
	end
end

function slot0.openResult(slot0, slot1)
	slot0._isForceSuccess = slot1
	slot2 = slot1 or slot0._beatConfig.targetId <= slot0._totalScore

	VersionActivity2_4MusicController.instance:trackBeatView(slot2 and VersionActivity2_4MusicEnum.BeatResult.Success or VersionActivity2_4MusicEnum.BeatResult.Fail, slot0._totalScore, slot0:_getGradeStat())

	if slot2 then
		Activity179Rpc.instance:sendSet179ScoreRequest(Activity179Model.instance:getActivityId(), slot0._episodeId, slot0._beatConfig.targetId)

		if VersionActivity2_4MusicBeatModel.instance:getSuccessCount() == 0 then
			VersionActivity2_4MusicBeatModel.instance:setSuccessCount(1)
			StoryController.instance:playStory(slot0._episodeConfig.storyAfter, nil, function ()
				VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicBeatResultView({
					isForceSuccess = uv0._isForceSuccess
				})
			end)

			return
		end
	end

	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicBeatResultView({
		isForceSuccess = slot0._isForceSuccess
	})
end

function slot0.startGame(slot0)
	slot0._noteIndex = 0
	slot0._noteHideIndex = 0
	slot0._gradeList = {}

	VersionActivity2_4MusicBeatModel.instance:updateGradleList(slot0._gradeList)

	slot0._txtscore.text = "0"
	slot0._playNoteList = slot0:getUserDataTb_()
end

function slot0.endGame(slot0)
	for slot4 = #slot0._playNoteList, 1, -1 do
		slot5 = slot0._playNoteList[slot4]

		slot5:hide()
		table.remove(slot0._playNoteList, slot4)
		table.insert(slot0._cacheNoteList, slot5)
	end

	slot0._totalScore = 0
	slot0._gradeValues = {}
end

function slot0.initNoneStatus(slot0)
	slot0:_initStats()

	slot0._txtscore.text = "0"
end

function slot0._addGrad(slot0, slot1)
	table.insert(slot0._gradeList, slot1)
	VersionActivity2_4MusicBeatModel.instance:updateGradleList(slot0._gradeList)

	slot2 = 0

	for slot6 = #slot0._gradeList, 1, -1 do
		if slot0._gradeList[slot6] == VersionActivity2_4MusicEnum.BeatGrade.Miss then
			break
		end

		slot2 = slot2 + 1
	end

	slot3 = 0

	if slot2 > 1 then
		slot4, slot3 = slot0:_getComboConfig(slot2)
	end

	gohelper.setActive(slot0._gostate1, slot3 == 1)
	gohelper.setActive(slot0._gostate2, slot3 == 2)
	gohelper.setActive(slot0._gostate3, slot3 == 3)

	if slot3 ~= 0 then
		slot0["_txtnum" .. slot3].text = VersionActivity2_4MusicEnum.times_sign .. slot2
	end

	slot0:_parseGradeList()

	if slot0._totalScore < slot0._totalScore then
		slot0._addAnimator:Play("add", 0, 0)
	end
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
	slot0._totalScore = slot0._totalScore + slot3.score * (slot3.combo <= slot2 and 1 or 0)

	for slot10 = VersionActivity2_4MusicEnum.BeatGrade.Perfect, VersionActivity2_4MusicEnum.BeatGrade.Cool do
		slot0._totalScore = slot0._totalScore + VersionActivity2_4MusicBeatModel.instance:getGradeScore(slot10) * (slot0._gradeValues[slot10] or 0)
	end

	slot0._txtscore.text = slot0._totalScore
end

function slot0._getGradeStat(slot0)
	slot0._gradeStat = slot0._gradeStat or {}

	for slot4 = VersionActivity2_4MusicEnum.BeatGrade.Perfect, VersionActivity2_4MusicEnum.BeatGrade.Miss do
		slot0._gradeStat[VersionActivity2_4MusicEnum.BeatGradeStatName[slot4]] = slot0._gradeValues[slot4] or 0
	end

	return slot0._gradeStat
end

function slot0.refreshNoteGroupStatus(slot0, slot1)
	for slot5 = #slot0._playNoteList, 1, -1 do
		if slot1 then
			slot0._playNoteList[slot5]:pause()
		else
			slot6:resume()
		end
	end
end

function slot0.updateNoteGroup(slot0, slot1)
	slot2 = nil

	if slot0._clickScreenPos then
		slot0._clickScreenPos = nil

		for slot7 = #slot0._playNoteList, 1, -1 do
			if not slot0._playNoteList[slot7]:getGrade() then
				if not slot2 then
					slot8._distance = Vector2.Distance(recthelper.screenPosToAnchorPos(slot0._clickScreenPos, slot0._gobeatgrid.transform), slot8.viewGO.transform.parent.anchoredPosition)
				elseif slot9 < slot2._distance then
					slot8._distance = slot9
				end
			end
		end
	end

	for slot6 = #slot0._playNoteList, 1, -1 do
		slot7 = slot0._playNoteList[slot6]

		slot7:updateFrame(slot1)

		if slot7:timeout(slot1) then
			slot7:setTimeoutMiss()
		end

		if slot7:disappear(slot1) then
			slot7:hide()
			table.remove(slot0._playNoteList, slot6)
			table.insert(slot0._cacheNoteList, slot7)
		end

		if slot7 == slot2 then
			slot7:setMiss()
		end

		if slot7:getGrade() and not slot7:isSubmitted() then
			slot7:setSubmit()
			slot0:_addGrad(slot8)
		end
	end

	slot0._isClickDown = false

	for slot8 = slot0._noteIndex + 1, #slot0._noteGroupList do
		if slot1 >= slot0._noteGroupList[slot8].time - Activity179Model.instance:getCalibration() + slot0._showTime then
			slot0._noteIndex = slot8

			if slot9.buttonId > 0 then
				slot0:_addNote(slot9, slot1)
			end
		end
	end

	for slot9 = slot0._noteHideIndex + 1, #slot0._noteGroupList do
		if slot0._noteGroupList[slot9].time <= slot1 then
			slot0._noteHideIndex = slot9

			AudioMgr.instance:trigger(slot10.eventName)
		else
			break
		end
	end
end

function slot0._addNote(slot0, slot1, slot2)
	slot3 = slot0:_getNoteItem()

	slot3:onUpdateMO(slot1, slot0._posGoList[slot1.buttonId], slot2)
	table.insert(slot0._playNoteList, slot3)
end

function slot0._getNoteItem(slot0)
	if table.remove(slot0._cacheNoteList) then
		return slot1
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1]), VersionActivity2_4MusicBeatItem)
end

return slot0
