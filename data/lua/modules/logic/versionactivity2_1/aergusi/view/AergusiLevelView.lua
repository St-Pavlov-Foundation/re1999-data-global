module("modules.logic.versionactivity2_1.aergusi.view.AergusiLevelView", package.seeall)

slot0 = class("AergusiLevelView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._gopath = gohelper.findChild(slot0.viewGO, "#go_path")
	slot0._goscrollcontent = gohelper.findChild(slot0.viewGO, "#go_path/#go_scrollcontent")
	slot0._gostages = gohelper.findChild(slot0.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	slot0._gotitle = gohelper.findChild(slot0.viewGO, "#go_title")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#go_title/#simage_title")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "#go_title/#go_time")
	slot0._txtlimittime = gohelper.findChildText(slot0.viewGO, "#go_title/#go_time/#txt_limittime")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_task")
	slot0._gotaskAni = gohelper.findChild(slot0.viewGO, "#btn_task/ani")
	slot0._goreddotreward = gohelper.findChild(slot0.viewGO, "#btn_task/#go_reddotreward")
	slot0._btnClue = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Clue")
	slot0._goeyelight = gohelper.findChild(slot0.viewGO, "#btn_Clue/eye_light")
	slot0._govxget = gohelper.findChild(slot0.viewGO, "#btn_Clue/vx_get")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
	slot0._btnClue:AddClickListener(slot0._btnClueOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntask:RemoveClickListener()
	slot0._btnClue:RemoveClickListener()
end

function slot0._btnClueOnClick(slot0)
	AergusiController.instance:openAergusiClueView()
end

function slot0._btntaskOnClick(slot0)
	AergusiController.instance:openAergusiTaskView()
end

function slot0._editableInitView(slot0)
	RedDotController.instance:addRedDot(slot0._goreddotreward, RedDotEnum.DotNode.V2a1AergusiTaskRed, VersionActivity2_1Enum.ActivityId.Aergusi)

	slot0._viewAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._stageAnimator = slot0._gostages:GetComponent(typeof(UnityEngine.Animator))
	slot0._taskAnimator = slot0._gotaskAni:GetComponent(typeof(UnityEngine.Animator))
	slot0._scrollcontent = slot0._gopath:GetComponent(gohelper.Type_LimitedScrollRect)
	slot0._drag = UIDragListenerHelper.New()

	slot0._drag:createByScrollRect(slot0._scrollcontent)

	slot0._levelItems = {}
end

function slot0._setInitLevelPos(slot0)
	slot2 = transformhelper.getLocalPos(slot0._goscrollcontent.transform)

	transformhelper.setLocalPos(slot0._goscrollcontent.transform, 0.2 * (AergusiModel.instance:getMaxUnlockEpisodeIndex() - 3) * AergusiEnum.LevelScrollWidth < 0 and slot2 or slot2 - 0.2 * (slot1 - 3) * AergusiEnum.LevelScrollWidth, 0, 0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._viewCanvasGroup = slot0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._viewCanvasGroup.enabled = false

	TaskDispatcher.runDelay(slot0._enableCanvasgroup, slot0, 0.7)
	slot0:_addEvents()
	slot0:_checkFirstEnter()
	slot0:_refreshItems()
	slot0:_refreshButtons()
	slot0:_refreshDeadline()
	slot0:_setInitLevelPos()
	TaskDispatcher.runRepeat(slot0._refreshDeadline, slot0, TimeUtil.OneMinuteSecond)
end

function slot0._enableCanvasgroup(slot0)
	slot0._viewCanvasGroup.enabled = true
end

function slot0._checkFirstEnter(slot0)
	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.Version2_1FirstTimeEnter, 0) == 0 and not AergusiModel.instance:getEpisodeInfo(AergusiModel.instance:getFirstEpisode()).passBeforeStory then
		AergusiModel.instance:setNewUnlockEpisode(slot2)
	end

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.Version2_1FirstTimeEnter, 1)
	gohelper.setActive(slot0._goeyelight, AergusiModel.instance:getNewFinishEpisode() > 0 or AergusiModel.instance:hasClueNotRead(AergusiModel.instance:getAllClues(false)))
	gohelper.setActive(slot0._govxget, slot4 > 0)
end

function slot0._refreshButtons(slot0)
	gohelper.setActive(slot0._btnClue.gameObject, AergusiModel.instance:isEpisodePassed(AergusiModel.instance:getFirstEpisode()))

	slot3 = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a1AergusiTaskRed, VersionActivity2_1Enum.ActivityId.Aergusi)

	gohelper.setActive(slot0._gotaskAni, slot3)

	if slot3 then
		slot0._taskAnimator:Play("loop", 0, 0)
	end
end

function slot0._refreshItems(slot0)
	for slot6, slot7 in ipairs(AergusiModel.instance:getEpisodeInfos()) do
		if not slot0._levelItems[slot7.episodeId] then
			slot0._levelItems[slot7.episodeId] = AergusiLevelItem.New()

			slot0._levelItems[slot7.episodeId]:init(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], gohelper.findChild(slot0._gostages, "stage" .. slot6)))
		end

		slot0._levelItems[slot7.episodeId]:refreshItem(slot7, slot6)
	end
end

function slot0._refreshDeadline(slot0)
	slot0._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_1Enum.ActivityId.Aergusi)
end

function slot0._onEnterEpisode(slot0, slot1)
	slot0._isRestart = false

	AergusiModel.instance:setCurEpisode(slot1)

	slot0._config = AergusiConfig.instance:getEpisodeConfig(nil, slot1)
	slot0._isEpisodePassed = AergusiModel.instance:isEpisodePassed(slot0._config.episodeId)

	slot0:_startEnterGame()
end

function slot0._startEnterGame(slot0)
	if AergusiModel.instance:isStoryEpisode(slot0._config.episodeId) then
		slot0:_enterBeforeStory()
	else
		Activity163Rpc.instance:sendAct163StartEvidenceRequest(slot0._config.activityId, slot0._config.episodeId, slot0._enterBeforeStory, slot0)
	end
end

function slot0._enterBeforeStory(slot0)
	if slot0._config.beforeStoryId > 0 and not slot0._isRestart then
		if not StoryModel.instance:isStoryFinished(slot0._config.beforeStoryId) then
			-- Nothing
		end

		StoryController.instance:playStory(slot0._config.beforeStoryId, {
			skipMessageId = MessageBoxIdDefine.Act163StorySkip
		}, slot0._enterEvidence, slot0)
	else
		slot0:_enterEvidence()
	end
end

function slot0._enterEvidence(slot0)
	if not AergusiModel.instance:isStoryEpisode(slot0._config.episodeId) then
		AergusiController.instance:openAergusiDialogView({
			episodeId = slot0._config.episodeId,
			callback = slot0._enterAfterStory,
			callbackObj = slot0
		})
	else
		TaskDispatcher.runDelay(slot0._episodeFinished, slot0, 0.5)
		slot0:_enterAfterStory()
	end
end

function slot0._onRestartEvidence(slot0)
	slot0._isRestart = true

	slot0:_startEnterGame()
end

function slot0._enterAfterStory(slot0)
	if slot0._config.afterStoryId > 0 then
		if not StoryModel.instance:isStoryFinished(slot0._config.afterStoryId) then
			-- Nothing
		end

		StoryController.instance:playStory(slot0._config.afterStoryId, {
			skipMessageId = MessageBoxIdDefine.Act163StorySkip
		}, slot0._afterStoryFinished, slot0)
	else
		slot0:_episodeFinished()
	end
end

function slot0._afterStoryFinished(slot0)
	TaskDispatcher.runDelay(slot0._episodeFinished, slot0, 0.5)
end

function slot0._episodeFinished(slot0)
	if not slot0._isEpisodePassed then
		AergusiModel.instance:setNewFinishEpisode(slot0._config.episodeId)

		if AergusiModel.instance:getEpisodeNextEpisode(slot0._config.episodeId) > 0 then
			AergusiModel.instance:setNewUnlockEpisode(slot1)
		end
	end

	slot0._viewAnimator:Play("open", 0, 0)
	slot0._stageAnimator:Play("open", 0, 0)

	slot0._viewCanvasGroup.enabled = false

	slot0:_setInitLevelPos()
	TaskDispatcher.runDelay(slot0._backLevel, slot0, 0.7)
end

function slot0._backLevel(slot0)
	slot0._viewCanvasGroup.enabled = true

	slot0:_checkFirstEnter()
	slot0:_refreshItems()
	slot0:_refreshButtons()
end

function slot0._onOperationFinished(slot0)
	slot0:_refreshItems()
	slot0:_refreshButtons()
end

function slot0._addEvents(slot0)
	AergusiController.instance:registerCallback(AergusiEvent.EnterEpisode, slot0._onEnterEpisode, slot0)
	AergusiController.instance:registerCallback(AergusiEvent.EvidenceFinished, slot0._enterAfterStory, slot0)
	AergusiController.instance:registerCallback(AergusiEvent.StartOperation, slot0._onOperationFinished, slot0)
	AergusiController.instance:registerCallback(AergusiEvent.RestartEvidence, slot0._onRestartEvidence, slot0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClueReadUpdate, slot0._refreshButtons, slot0)
	slot0._drag:registerCallback(slot0._drag.EventBegin, slot0._onDragBegin, slot0)
	slot0._drag:registerCallback(slot0._drag.EventEnd, slot0._onDragEnd, slot0)
end

function slot0._onDragBegin(slot0)
	slot0._positionX = transformhelper.getPos(slot0._goscrollcontent.transform)

	AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_slide)
end

function slot0._onDragEnd(slot0)
	if transformhelper.getPos(slot0._goscrollcontent.transform) < slot0._positionX then
		slot0._stageAnimator:Play("slipleft", 0, 0)
	else
		slot0._stageAnimator:Play("slipright", 0, 0)
	end
end

function slot0._removeEvents(slot0)
	slot0._drag:release()
	AergusiController.instance:unregisterCallback(AergusiEvent.EnterEpisode, slot0._onEnterEpisode, slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.EvidenceFinished, slot0._enterAfterStory, slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.StartOperation, slot0._onOperationFinished, slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.RestartEvidence, slot0._onRestartEvidence, slot0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClueReadUpdate, slot0._refreshButtons, slot0)
end

function slot0.onClose(slot0)
	slot0._viewCanvasGroup.enabled = false

	slot0:_removeEvents()
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._refreshDeadline, slot0)
	TaskDispatcher.cancelTask(slot0._backLevel, slot0)
	TaskDispatcher.cancelTask(slot0._episodeFinished, slot0)

	if slot0._levelItems then
		for slot4, slot5 in pairs(slot0._levelItems) do
			slot5:destroy()
		end

		slot0._levelItems = nil
	end
end

return slot0
