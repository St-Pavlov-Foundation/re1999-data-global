module("modules.logic.versionactivity2_1.aergusi.view.AergusiLevelView", package.seeall)

local var_0_0 = class("AergusiLevelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._gopath = gohelper.findChild(arg_1_0.viewGO, "#go_path")
	arg_1_0._goscrollcontent = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent")
	arg_1_0._gostages = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	arg_1_0._gotitle = gohelper.findChild(arg_1_0.viewGO, "#go_title")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_title/#simage_title")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "#go_title/#go_time")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "#go_title/#go_time/#txt_limittime")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_task")
	arg_1_0._gotaskAni = gohelper.findChild(arg_1_0.viewGO, "#btn_task/ani")
	arg_1_0._goreddotreward = gohelper.findChild(arg_1_0.viewGO, "#btn_task/#go_reddotreward")
	arg_1_0._btnClue = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Clue")
	arg_1_0._goeyelight = gohelper.findChild(arg_1_0.viewGO, "#btn_Clue/eye_light")
	arg_1_0._govxget = gohelper.findChild(arg_1_0.viewGO, "#btn_Clue/vx_get")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnClue:AddClickListener(arg_2_0._btnClueOnClick, arg_2_0)
	arg_2_0._btnimage_TryBtn:AddClickListener(arg_2_0._btnimage_TryBtnOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnClue:RemoveClickListener()
	arg_3_0._btnimage_TryBtn:RemoveClickListener()
end

function var_0_0._btnClueOnClick(arg_4_0)
	AergusiController.instance:openAergusiClueView()
end

function var_0_0._btntaskOnClick(arg_5_0)
	AergusiController.instance:openAergusiTaskView()
end

function var_0_0._editableInitView(arg_6_0)
	RedDotController.instance:addRedDot(arg_6_0._goreddotreward, RedDotEnum.DotNode.V2a1AergusiTaskRed, VersionActivity2_1Enum.ActivityId.Aergusi)

	arg_6_0._viewAnimator = arg_6_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._stageAnimator = arg_6_0._gostages:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._taskAnimator = arg_6_0._gotaskAni:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._scrollcontent = arg_6_0._gopath:GetComponent(gohelper.Type_LimitedScrollRect)
	arg_6_0._drag = UIDragListenerHelper.New()

	arg_6_0._drag:createByScrollRect(arg_6_0._scrollcontent)

	arg_6_0._levelItems = {}

	gohelper.setActive(arg_6_0._gotime, false)

	arg_6_0._btnimage_TryBtn = gohelper.findChildButtonWithAudio(arg_6_0.viewGO, "#go_Try/image_TryBtn")
end

function var_0_0._setInitLevelPos(arg_7_0)
	local var_7_0 = AergusiModel.instance:getMaxUnlockEpisodeIndex()
	local var_7_1 = transformhelper.getLocalPos(arg_7_0._goscrollcontent.transform)

	var_7_1 = 0.2 * (var_7_0 - 3) * AergusiEnum.LevelScrollWidth < 0 and var_7_1 or var_7_1 - 0.2 * (var_7_0 - 3) * AergusiEnum.LevelScrollWidth

	transformhelper.setLocalPos(arg_7_0._goscrollcontent.transform, var_7_1, 0, 0)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._viewCanvasGroup = arg_9_0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_9_0._viewCanvasGroup.enabled = false

	TaskDispatcher.runDelay(arg_9_0._enableCanvasgroup, arg_9_0, 0.7)
	arg_9_0:_addEvents()
	arg_9_0:_checkFirstEnter()
	arg_9_0:_refreshItems()
	arg_9_0:_refreshButtons()
	arg_9_0:_refreshDeadline()
	arg_9_0:_setInitLevelPos()
	TaskDispatcher.runRepeat(arg_9_0._refreshDeadline, arg_9_0, TimeUtil.OneMinuteSecond)
end

function var_0_0._enableCanvasgroup(arg_10_0)
	arg_10_0._viewCanvasGroup.enabled = true
end

function var_0_0._checkFirstEnter(arg_11_0)
	local var_11_0 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.Version2_1FirstTimeEnter, 0)
	local var_11_1 = AergusiModel.instance:getFirstEpisode()
	local var_11_2 = AergusiModel.instance:getEpisodeInfo(var_11_1)

	if var_11_0 == 0 and not var_11_2.passBeforeStory then
		AergusiModel.instance:setNewUnlockEpisode(var_11_1)
	end

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.Version2_1FirstTimeEnter, 1)

	local var_11_3 = AergusiModel.instance:getNewFinishEpisode()
	local var_11_4 = AergusiModel.instance:getAllClues(false)
	local var_11_5 = AergusiModel.instance:hasClueNotRead(var_11_4)

	gohelper.setActive(arg_11_0._goeyelight, var_11_3 > 0 or var_11_5)
	gohelper.setActive(arg_11_0._govxget, var_11_3 > 0)
end

function var_0_0._refreshButtons(arg_12_0)
	local var_12_0 = AergusiModel.instance:getFirstEpisode()
	local var_12_1 = AergusiModel.instance:isEpisodePassed(var_12_0)

	gohelper.setActive(arg_12_0._btnClue.gameObject, var_12_1)

	local var_12_2 = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a1AergusiTaskRed, VersionActivity2_1Enum.ActivityId.Aergusi)

	gohelper.setActive(arg_12_0._gotaskAni, var_12_2)

	if var_12_2 then
		arg_12_0._taskAnimator:Play("loop", 0, 0)
	end
end

function var_0_0._refreshItems(arg_13_0)
	local var_13_0 = AergusiModel.instance:getEpisodeInfos()
	local var_13_1 = arg_13_0.viewContainer:getSetting().otherRes[1]

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if not arg_13_0._levelItems[iter_13_1.episodeId] then
			local var_13_2 = gohelper.findChild(arg_13_0._gostages, "stage" .. iter_13_0)
			local var_13_3 = arg_13_0:getResInst(var_13_1, var_13_2)

			arg_13_0._levelItems[iter_13_1.episodeId] = AergusiLevelItem.New()

			arg_13_0._levelItems[iter_13_1.episodeId]:init(var_13_3)
		end

		arg_13_0._levelItems[iter_13_1.episodeId]:refreshItem(iter_13_1, iter_13_0)
	end
end

function var_0_0._refreshDeadline(arg_14_0)
	arg_14_0._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_1Enum.ActivityId.Aergusi)
end

function var_0_0._onEnterEpisode(arg_15_0, arg_15_1)
	arg_15_0._isRestart = false

	AergusiModel.instance:setCurEpisode(arg_15_1)

	arg_15_0._config = AergusiConfig.instance:getEpisodeConfig(nil, arg_15_1)
	arg_15_0._isEpisodePassed = AergusiModel.instance:isEpisodePassed(arg_15_0._config.episodeId)

	arg_15_0:_startEnterGame()
end

function var_0_0._startEnterGame(arg_16_0)
	if AergusiModel.instance:isStoryEpisode(arg_16_0._config.episodeId) then
		arg_16_0:_enterBeforeStory()
	else
		Activity163Rpc.instance:sendAct163StartEvidenceRequest(arg_16_0._config.activityId, arg_16_0._config.episodeId, arg_16_0._enterBeforeStory, arg_16_0)
	end
end

function var_0_0._enterBeforeStory(arg_17_0)
	if arg_17_0._config.beforeStoryId > 0 and not arg_17_0._isRestart then
		local var_17_0 = {}

		if not StoryModel.instance:isStoryFinished(arg_17_0._config.beforeStoryId) then
			var_17_0.skipMessageId = MessageBoxIdDefine.Act163StorySkip
		end

		StoryController.instance:playStory(arg_17_0._config.beforeStoryId, var_17_0, arg_17_0._enterEvidence, arg_17_0)
	else
		arg_17_0:_enterEvidence()
	end
end

function var_0_0._enterEvidence(arg_18_0)
	if not AergusiModel.instance:isStoryEpisode(arg_18_0._config.episodeId) then
		local var_18_0 = {
			episodeId = arg_18_0._config.episodeId,
			callback = arg_18_0._enterAfterStory,
			callbackObj = arg_18_0
		}

		AergusiController.instance:openAergusiDialogView(var_18_0)
	else
		TaskDispatcher.runDelay(arg_18_0._episodeFinished, arg_18_0, 0.5)
		arg_18_0:_enterAfterStory()
	end
end

function var_0_0._onRestartEvidence(arg_19_0)
	arg_19_0._isRestart = true

	arg_19_0:_startEnterGame()
end

function var_0_0._enterAfterStory(arg_20_0)
	if arg_20_0._config.afterStoryId > 0 then
		local var_20_0 = {}

		if not StoryModel.instance:isStoryFinished(arg_20_0._config.afterStoryId) then
			var_20_0.skipMessageId = MessageBoxIdDefine.Act163StorySkip
		end

		StoryController.instance:playStory(arg_20_0._config.afterStoryId, var_20_0, arg_20_0._afterStoryFinished, arg_20_0)
	else
		arg_20_0:_episodeFinished()
	end
end

function var_0_0._afterStoryFinished(arg_21_0)
	TaskDispatcher.runDelay(arg_21_0._episodeFinished, arg_21_0, 0.5)
end

function var_0_0._episodeFinished(arg_22_0)
	if not arg_22_0._isEpisodePassed then
		AergusiModel.instance:setNewFinishEpisode(arg_22_0._config.episodeId)

		local var_22_0 = AergusiModel.instance:getEpisodeNextEpisode(arg_22_0._config.episodeId)

		if var_22_0 > 0 then
			AergusiModel.instance:setNewUnlockEpisode(var_22_0)
		end
	end

	arg_22_0._viewAnimator:Play("open", 0, 0)
	arg_22_0._stageAnimator:Play("open", 0, 0)

	arg_22_0._viewCanvasGroup.enabled = false

	arg_22_0:_setInitLevelPos()
	TaskDispatcher.runDelay(arg_22_0._backLevel, arg_22_0, 0.7)
end

function var_0_0._backLevel(arg_23_0)
	arg_23_0._viewCanvasGroup.enabled = true

	arg_23_0:_checkFirstEnter()
	arg_23_0:_refreshItems()
	arg_23_0:_refreshButtons()
end

function var_0_0._onOperationFinished(arg_24_0)
	arg_24_0:_refreshItems()
	arg_24_0:_refreshButtons()
end

function var_0_0._addEvents(arg_25_0)
	AergusiController.instance:registerCallback(AergusiEvent.EnterEpisode, arg_25_0._onEnterEpisode, arg_25_0)
	AergusiController.instance:registerCallback(AergusiEvent.EvidenceFinished, arg_25_0._enterAfterStory, arg_25_0)
	AergusiController.instance:registerCallback(AergusiEvent.StartOperation, arg_25_0._onOperationFinished, arg_25_0)
	AergusiController.instance:registerCallback(AergusiEvent.RestartEvidence, arg_25_0._onRestartEvidence, arg_25_0)
	AergusiController.instance:registerCallback(AergusiEvent.OnClueReadUpdate, arg_25_0._refreshButtons, arg_25_0)
	arg_25_0._drag:registerCallback(arg_25_0._drag.EventBegin, arg_25_0._onDragBegin, arg_25_0)
	arg_25_0._drag:registerCallback(arg_25_0._drag.EventEnd, arg_25_0._onDragEnd, arg_25_0)
end

function var_0_0._onDragBegin(arg_26_0)
	arg_26_0._positionX = transformhelper.getPos(arg_26_0._goscrollcontent.transform)

	AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_slide)
end

function var_0_0._onDragEnd(arg_27_0)
	if transformhelper.getPos(arg_27_0._goscrollcontent.transform) < arg_27_0._positionX then
		arg_27_0._stageAnimator:Play("slipleft", 0, 0)
	else
		arg_27_0._stageAnimator:Play("slipright", 0, 0)
	end
end

function var_0_0._removeEvents(arg_28_0)
	arg_28_0._drag:release()
	AergusiController.instance:unregisterCallback(AergusiEvent.EnterEpisode, arg_28_0._onEnterEpisode, arg_28_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.EvidenceFinished, arg_28_0._enterAfterStory, arg_28_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.StartOperation, arg_28_0._onOperationFinished, arg_28_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.RestartEvidence, arg_28_0._onRestartEvidence, arg_28_0)
	AergusiController.instance:unregisterCallback(AergusiEvent.OnClueReadUpdate, arg_28_0._refreshButtons, arg_28_0)
end

function var_0_0.onClose(arg_29_0)
	arg_29_0._viewCanvasGroup.enabled = false

	arg_29_0:_removeEvents()
end

function var_0_0.onDestroyView(arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._refreshDeadline, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._backLevel, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._episodeFinished, arg_30_0)

	if arg_30_0._levelItems then
		for iter_30_0, iter_30_1 in pairs(arg_30_0._levelItems) do
			iter_30_1:destroy()
		end

		arg_30_0._levelItems = nil
	end
end

local var_0_1 = 10012118

function var_0_0._btnimage_TryBtnOnClick(arg_31_0)
	GameFacade.jump(var_0_1)
end

return var_0_0
