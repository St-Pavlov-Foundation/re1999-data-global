module("modules.logic.versionactivity2_5.liangyue.view.LiangYueLevelView", package.seeall)

local var_0_0 = class("LiangYueLevelView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._gostoryPath = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath")
	arg_1_0._gostoryScroll = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll")
	arg_1_0._gostoryStages = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	arg_1_0._goTitle = gohelper.findChild(arg_1_0.viewGO, "#go_Title")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Title/#simage_title")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "#go_Title/#go_time")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "#go_Title/#go_time/#txt_limittime")
	arg_1_0._btnPlayBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Title/#btn_PlayBtn")
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Task")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_Task/#go_reddot")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._scrollStory = gohelper.findChildScrollRect(arg_1_0._gostoryPath, "")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnPlayBtn:AddClickListener(arg_2_0._btnPlayBtnOnClick, arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0._btnTaskOnClick, arg_2_0)
	arg_2_0._drag:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
	arg_2_0._touch:AddClickDownListener(arg_2_0._onClickDown, arg_2_0)
	arg_2_0:addEventCb(LiangYueController.instance, LiangYueEvent.OnFinishEpisode, arg_2_0.onEpisodeFinish, arg_2_0)
	arg_2_0:addEventCb(LiangYueController.instance, LiangYueEvent.OnClickStoryItem, arg_2_0.onClickStoryItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnPlayBtn:RemoveClickListener()
	arg_3_0._btnTask:RemoveClickListener()
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0._touch:RemoveClickDownListener()
	arg_3_0._scrollStory:RemoveOnValueChanged()
	arg_3_0:removeEventCb(LiangYueController.instance, LiangYueEvent.OnFinishEpisode, arg_3_0.onEpisodeFinish, arg_3_0)
	arg_3_0:removeEventCb(LiangYueController.instance, LiangYueEvent.OnClickStoryItem, arg_3_0.onClickStoryItem, arg_3_0)
end

function var_0_0._btnPlayBtnOnClick(arg_4_0)
	return
end

function var_0_0._btnTaskOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.LiangYueTaskView)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._actId = VersionActivity2_5Enum.ActivityId.LiangYue
	arg_6_0._taskAnimator = arg_6_0._btnTask.gameObject:GetComponentInChildren(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(arg_6_0._goreddot, RedDotEnum.DotNode.V2a5_Act184Task, nil, arg_6_0._refreshRedDot, arg_6_0)
	arg_6_0:_initLevelItem()

	local var_6_0 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)

	arg_6_0._offsetX = (var_6_0 - -300) / 2
	arg_6_0.minContentAnchorX = -4760 + var_6_0
	arg_6_0._bgWidth = recthelper.getWidth(arg_6_0._simageFullBG.transform)
	arg_6_0._minBgPositionX = BootNativeUtil.getDisplayResolution() - arg_6_0._bgWidth
	arg_6_0._maxBgPositionX = 0
	arg_6_0._bgPositonMaxOffsetX = math.abs(arg_6_0._maxBgPositionX - arg_6_0._minBgPositionX)
	arg_6_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_6_0._gostoryPath)
	arg_6_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_6_0._gostoryPath)
	arg_6_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_6_0._gostoryPath, DungeonMapEpisodeAudio, arg_6_0._scrollStory)
	arg_6_0._pathAnimator = gohelper.findChildAnim(arg_6_0.viewGO, "#go_storyPath/#go_storyScroll/path/path_2")
end

function var_0_0._initLevelItem(arg_7_0)
	arg_7_0._levelItemList = {}

	local var_7_0 = arg_7_0._gostoryStages.transform
	local var_7_1 = var_7_0.childCount

	for iter_7_0 = 1, var_7_1 do
		local var_7_2 = var_7_0:GetChild(iter_7_0 - 1)
		local var_7_3 = string.format("item_%s", iter_7_0)
		local var_7_4 = arg_7_0:getResInst(arg_7_0.viewContainer._viewSetting.otherRes[1], var_7_2.gameObject, var_7_3)
		local var_7_5 = MonoHelper.addLuaComOnceToGo(var_7_4, LiangYueLevelItem)

		var_7_5:onInit(var_7_4)
		table.insert(arg_7_0._levelItemList, var_7_5)
	end
end

function var_0_0._refreshRedDot(arg_8_0, arg_8_1)
	arg_8_1:defaultRefreshDot()

	local var_8_0 = arg_8_1.show

	arg_8_0._taskAnimator:Play(var_8_0 and "loop" or "idle")
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	TaskDispatcher.runRepeat(arg_10_0.updateTime, arg_10_0, TimeUtil.OneMinuteSecond)
	arg_10_0:updateTime()
	arg_10_0:refreshUI()

	if arg_10_0:_checkFirstEnter() then
		arg_10_0._levelItemList[1]:setLockState()
		arg_10_0:_lockScreen(true)
		TaskDispatcher.runDelay(arg_10_0._playFirstUnlock, arg_10_0, 0.8)
	end
end

function var_0_0._playFirstUnlock(arg_11_0)
	local var_11_0 = LiangYueConfig.instance:getFirstEpisodeId()

	if var_11_0 then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0._levelItemList) do
			if iter_11_1.episodeId == var_11_0.episodeId then
				iter_11_1:refreshUI()
				iter_11_1:refreshStoryState(false)
				iter_11_1:playEpisodeAnim(LiangYueEnum.EpisodeAnim.Unlock, 0)
				AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_wangshi_argus_level_open)
				TaskDispatcher.runDelay(arg_11_0.onPlayUnlockAnimEnd, arg_11_0, 1)

				return
			end
		end
	end

	arg_11_0:_lockScreen(false)
end

function var_0_0._checkFirstEnter(arg_12_0)
	local var_12_0 = arg_12_0._levelItemList[2]

	if var_12_0 and not var_12_0.isPreFinish then
		local var_12_1 = string.format("ActLiangYueFirstEnter_%s", PlayerModel.instance:getMyUserId())

		if PlayerPrefsHelper.getNumber(var_12_1, 0) == 0 then
			PlayerPrefsHelper.setNumber(var_12_1, 1)

			return true
		end
	end

	return false
end

function var_0_0.refreshUI(arg_13_0)
	local var_13_0 = LiangYueConfig.instance:getNoGameEpisodeList(arg_13_0._actId)

	if #var_13_0 ~= #arg_13_0._levelItemList then
		logError("levelItem Count not match")

		return
	end

	local var_13_1 = 1
	local var_13_2

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._levelItemList) do
		local var_13_3 = var_13_0[iter_13_0]

		iter_13_1:setInfo(iter_13_0, var_13_3)

		if LiangYueModel.instance:isEpisodeFinish(arg_13_0._actId, var_13_3.preEpisodeId) then
			var_13_1 = iter_13_0
			var_13_2 = var_13_3.episodeId
		end
	end

	arg_13_0:_focusStoryItem(var_13_1, var_13_2, false, false, true)
	arg_13_0:_playPathAnim(var_13_1, false)

	if var_13_2 ~= nil then
		TaskDispatcher.runDelay(arg_13_0.delaySendEpisodeUnlockEvent, arg_13_0, 0.01)
	end
end

function var_0_0.delaySendEpisodeUnlockEvent(arg_14_0)
	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnEpisodeUnlock, arg_14_0._currentEpisodeId)
	logNormal("OnEpisodeUnlock episodeId: " .. arg_14_0._currentEpisodeId)
end

function var_0_0._onDragBegin(arg_15_0)
	arg_15_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEnd(arg_16_0)
	arg_16_0._audioScroll:onDragEnd()
end

function var_0_0._onScrollValueChanged(arg_17_0)
	return
end

function var_0_0._onClickDown(arg_18_0)
	arg_18_0._audioScroll:onClickDown()
end

function var_0_0._initBgPosition(arg_19_0)
	local var_19_0 = -arg_19_0._scrollStory.horizontalNormalizedPosition * arg_19_0._bgPositonMaxOffsetX
	local var_19_1 = Mathf.Clamp(var_19_0, arg_19_0._minBgPositionX, arg_19_0._maxBgPositionX)

	recthelper.setAnchorX(arg_19_0._simageFullBG.transform, var_19_1)
end

function var_0_0._playPathAnim(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 > 1 then
		arg_20_0._pathAnimator.speed = 1

		local var_20_0 = string.format("go%s", Mathf.Clamp(arg_20_1 - 1, 1, #arg_20_0._levelItemList - 1))

		arg_20_0._pathAnimator:Play(var_20_0, 0, arg_20_2 and 0 or 1)
	else
		arg_20_0._pathAnimator.speed = 0

		arg_20_0._pathAnimator:Play("go1", -1, 0)
	end
end

function var_0_0.onClickStoryItem(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_0:_focusStoryItem(arg_21_1, arg_21_2, arg_21_3, true)
end

function var_0_0._focusStoryItem(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	arg_22_0._currentEpisodeId = arg_22_2
	arg_22_0._currentIndex = arg_22_1

	local var_22_0 = arg_22_0._levelItemList[arg_22_1]
	local var_22_1 = recthelper.getAnchorX(var_22_0._go.transform.parent)
	local var_22_2 = arg_22_0._offsetX - var_22_1

	if var_22_2 > 0 then
		var_22_2 = 0
	elseif var_22_2 < arg_22_0.minContentAnchorX then
		var_22_2 = arg_22_0.minContentAnchorX
	end

	if arg_22_5 then
		recthelper.setAnchorX(arg_22_0._gostoryScroll.transform, var_22_2)
	elseif arg_22_4 then
		ZProj.TweenHelper.DOAnchorPosX(arg_22_0._gostoryScroll.transform, var_22_2, LiangYueEnum.FocusItemMoveDuration, arg_22_0.onFocusEnd, arg_22_0, {
			arg_22_2,
			arg_22_3
		})
	else
		ZProj.TweenHelper.DOAnchorPosX(arg_22_0._gostoryScroll.transform, var_22_2, LiangYueEnum.FocusItemMoveDuration)
	end
end

function var_0_0.onFocusEnd(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1[1]
	local var_23_1 = arg_23_1[2]
	local var_23_2 = arg_23_0._actId
	local var_23_3 = LiangYueConfig.instance:getEpisodeConfigByActAndId(var_23_2, var_23_0)

	if var_23_1 then
		LiangYueController.instance:openGameView(var_23_2, var_23_0)

		return
	end

	local var_23_4 = var_23_3.storyId

	if LiangYueModel.instance:isEpisodeFinish(var_23_2, var_23_0) then
		StoryController.instance:playStory(var_23_4)

		return
	end

	local var_23_5 = {}

	var_23_5.mark = true
	var_23_5.episodeId = var_23_0

	StoryController.instance:playStory(var_23_4, var_23_5, arg_23_0.onStoryFinished, arg_23_0)
end

function var_0_0.onStoryFinished(arg_24_0)
	LiangYueController.instance:finishEpisode(arg_24_0._actId, arg_24_0._currentEpisodeId)
end

function var_0_0.onEpisodeFinish(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0._actId ~= arg_25_1 then
		return
	end

	arg_25_0._finishEpisodeId = arg_25_2

	local var_25_0 = LiangYueConfig.instance:getEpisodeConfigByActAndId(arg_25_1, arg_25_2)

	arg_25_0._finishEpisodeConfig = var_25_0

	if not (var_25_0.puzzleId == 0) then
		arg_25_0._listenView = ViewName.LiangYueGameView

		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_25_0.onCloseViewFinish, arg_25_0)
	else
		arg_25_0:_lockScreen(true)
		TaskDispatcher.runDelay(arg_25_0.forceCloseMask, arg_25_0, 10)
		TaskDispatcher.runDelay(arg_25_0.onPlayFinishAnim, arg_25_0, 1.93)
	end
end

function var_0_0.onCloseViewFinish(arg_26_0, arg_26_1)
	if arg_26_1 ~= arg_26_0._listenView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_26_0.onCloseViewFinish, arg_26_0)
	arg_26_0:_lockScreen(true)
	TaskDispatcher.runDelay(arg_26_0.forceCloseMask, arg_26_0, 10)
	TaskDispatcher.runDelay(arg_26_0.onPlayFinishAnim, arg_26_0, 0.73)
end

function var_0_0.onPlayFinishAnim(arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0.onPlayFinishAnim, arg_27_0)

	local var_27_0 = arg_27_0._finishEpisodeId
	local var_27_1
	local var_27_2 = LiangYueConfig.instance:getNoGameEpisodeList(arg_27_0._actId)

	for iter_27_0, iter_27_1 in ipairs(arg_27_0._levelItemList) do
		if iter_27_1.episodeId == var_27_0 or iter_27_1.gameEpisodeId == var_27_0 then
			iter_27_1:refreshUI()

			arg_27_0._temptIndex = math.min(iter_27_0 + 1, #arg_27_0._levelItemList)

			if iter_27_1.episodeId == var_27_0 then
				iter_27_1:refreshStoryState(false)
				iter_27_1:playEpisodeAnim(LiangYueEnum.EpisodeAnim.Finish, 0)
				AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_wulu_lucky_bag_prize)

				var_27_1 = LiangYueEnum.FinishStoryAnimDelayTime

				if iter_27_1.gameEpisodeId then
					arg_27_0._temptIndex = iter_27_0
				end

				break
			end

			iter_27_1:refreshGameState(false)
			iter_27_1:playGameEpisodeAnim(LiangYueEnum.EpisodeGameAnim.FinishIdle, 0)
			iter_27_1:playGameEpisodeRewardAnim(LiangYueEnum.EpisodeGameFinishAnim.Open, 0)

			var_27_1 = LiangYueEnum.FinishGameAnimDelayTime

			break
		else
			local var_27_3 = var_27_2[iter_27_0]

			iter_27_1:setInfo(iter_27_0, var_27_3)
		end
	end

	if not var_27_1 then
		logError("未找到对应的关卡 id:" .. var_27_0)
		arg_27_0:_lockScreen(false)
		arg_27_0:refreshUI()

		return
	end

	TaskDispatcher.runDelay(arg_27_0.onPlayPathAnim, arg_27_0, var_27_1)
end

function var_0_0.forceCloseMask(arg_28_0)
	arg_28_0:_lockScreen(false)
	logError("动画计时器超时，强制关闭")
	arg_28_0:refreshUI()
	TaskDispatcher.cancelTask(arg_28_0.forceCloseMask, arg_28_0)
end

function var_0_0.onPlayPathAnim(arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0.onPlayPathAnim, arg_29_0)

	if arg_29_0._temptIndex == arg_29_0._currentIndex then
		arg_29_0:onPlayUnlockAnim()
	else
		arg_29_0:_playPathAnim(arg_29_0._temptIndex, true)
		arg_29_0:_focusStoryItem(arg_29_0._temptIndex, arg_29_0._currentEpisodeId)
		TaskDispatcher.runDelay(arg_29_0.onPlayUnlockAnim, arg_29_0, LiangYueEnum.PathAnimDelayTime)
	end
end

function var_0_0.onPlayUnlockAnim(arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0.onPlayUnlockAnim, arg_30_0)

	local var_30_0 = arg_30_0._finishEpisodeId

	for iter_30_0, iter_30_1 in ipairs(arg_30_0._levelItemList) do
		if iter_30_1.preEpisodeId == var_30_0 then
			iter_30_1:refreshUI()
			iter_30_1:refreshStoryState(false)
			iter_30_1:playEpisodeAnim(LiangYueEnum.EpisodeAnim.Unlock, 0)
			AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_wangshi_argus_level_open)
		elseif iter_30_1.episodeId == var_30_0 and iter_30_1.gameEpisodeId ~= nil then
			iter_30_1:refreshUI()
			iter_30_1:refreshGameState(false)
			iter_30_1:playGameEpisodeAnim(LiangYueEnum.EpisodeGameAnim.Open, 0)
			AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_feichi_stanzas)
		end
	end

	TaskDispatcher.runDelay(arg_30_0.onPlayUnlockAnimEnd, arg_30_0, LiangYueEnum.UnlockAnimDelayTime)
end

function var_0_0.onPlayUnlockAnimEnd(arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0.onPlayUnlockAnimEnd, arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0.forceCloseMask, arg_31_0)
	arg_31_0:_lockScreen(false)

	if arg_31_0._finishEpisodeId then
		LiangYueController.instance:dispatchEvent(LiangYueEvent.OnEpisodeUnlock, arg_31_0._finishEpisodeId)
		logNormal("OnEpisodeUnlock episodeId: " .. arg_31_0._finishEpisodeId)
	end
end

function var_0_0._lockScreen(arg_32_0, arg_32_1)
	if arg_32_1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("LiangYueLevelLock")
	else
		UIBlockMgr.instance:endBlock("LiangYueLevelLock")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function var_0_0.updateTime(arg_33_0)
	local var_33_0 = arg_33_0._actId
	local var_33_1 = ActivityModel.instance:getActivityInfo()[var_33_0]

	if var_33_1 then
		local var_33_2 = var_33_1:getRealEndTimeStamp() - ServerTime.now()

		if var_33_2 > 0 then
			local var_33_3 = TimeUtil.SecondToActivityTimeFormat(var_33_2)

			arg_33_0._txtlimittime.text = var_33_3

			return
		end
	end

	TaskDispatcher.cancelTask(arg_33_0.updateTime, arg_33_0)
end

function var_0_0.onClose(arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0.updateTime, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0.onPlayFinishAnim, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0.onPlayPathAnim, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0.onPlayUnlockAnim, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0.onPlayUnlockAnimEnd, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0.forceCloseMask, arg_34_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_34_0.onCloseViewFinish, arg_34_0)
end

function var_0_0.onDestroyView(arg_35_0)
	return
end

return var_0_0
