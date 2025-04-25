module("modules.logic.versionactivity2_5.liangyue.view.LiangYueLevelView", package.seeall)

slot0 = class("LiangYueLevelView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._gostoryPath = gohelper.findChild(slot0.viewGO, "#go_storyPath")
	slot0._gostoryScroll = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll")
	slot0._gostoryStages = gohelper.findChild(slot0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	slot0._goTitle = gohelper.findChild(slot0.viewGO, "#go_Title")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#go_Title/#simage_title")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "#go_Title/#go_time")
	slot0._txtlimittime = gohelper.findChildText(slot0.viewGO, "#go_Title/#go_time/#txt_limittime")
	slot0._btnPlayBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Title/#btn_PlayBtn")
	slot0._btnTask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Task")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#btn_Task/#go_reddot")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._scrollStory = gohelper.findChildScrollRect(slot0._gostoryPath, "")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnPlayBtn:AddClickListener(slot0._btnPlayBtnOnClick, slot0)
	slot0._btnTask:AddClickListener(slot0._btnTaskOnClick, slot0)
	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._touch:AddClickDownListener(slot0._onClickDown, slot0)
	slot0:addEventCb(LiangYueController.instance, LiangYueEvent.OnFinishEpisode, slot0.onEpisodeFinish, slot0)
	slot0:addEventCb(LiangYueController.instance, LiangYueEvent.OnClickStoryItem, slot0.onClickStoryItem, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnPlayBtn:RemoveClickListener()
	slot0._btnTask:RemoveClickListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0._touch:RemoveClickDownListener()
	slot0._scrollStory:RemoveOnValueChanged()
	slot0:removeEventCb(LiangYueController.instance, LiangYueEvent.OnFinishEpisode, slot0.onEpisodeFinish, slot0)
	slot0:removeEventCb(LiangYueController.instance, LiangYueEvent.OnClickStoryItem, slot0.onClickStoryItem, slot0)
end

function slot0._btnPlayBtnOnClick(slot0)
end

function slot0._btnTaskOnClick(slot0)
	ViewMgr.instance:openView(ViewName.LiangYueTaskView)
end

function slot0._editableInitView(slot0)
	slot0._actId = VersionActivity2_5Enum.ActivityId.LiangYue
	slot0._taskAnimator = slot0._btnTask.gameObject:GetComponentInChildren(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.V2a5_Act184Task, nil, slot0._refreshRedDot, slot0)
	slot0:_initLevelItem()

	slot1 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)
	slot0._offsetX = (slot1 - -300) / 2
	slot0.minContentAnchorX = -4760 + slot1
	slot0._bgWidth = recthelper.getWidth(slot0._simageFullBG.transform)
	slot0._minBgPositionX = BootNativeUtil.getDisplayResolution() - slot0._bgWidth
	slot0._maxBgPositionX = 0
	slot0._bgPositonMaxOffsetX = math.abs(slot0._maxBgPositionX - slot0._minBgPositionX)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._gostoryPath)
	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0._gostoryPath)
	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0._gostoryPath, DungeonMapEpisodeAudio, slot0._scrollStory)
	slot0._pathAnimator = gohelper.findChildAnim(slot0.viewGO, "#go_storyPath/#go_storyScroll/path/path_2")
end

function slot0._initLevelItem(slot0)
	slot0._levelItemList = {}

	for slot6 = 1, slot0._gostoryStages.transform.childCount do
		slot9 = slot0:getResInst(slot0.viewContainer._viewSetting.otherRes[1], slot1:GetChild(slot6 - 1).gameObject, string.format("item_%s", slot6))
		slot10 = MonoHelper.addLuaComOnceToGo(slot9, LiangYueLevelItem)

		slot10:onInit(slot9)
		table.insert(slot0._levelItemList, slot10)
	end
end

function slot0._refreshRedDot(slot0, slot1)
	slot1:defaultRefreshDot()
	slot0._taskAnimator:Play(slot1.show and "loop" or "idle")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	TaskDispatcher.runRepeat(slot0.updateTime, slot0, TimeUtil.OneMinuteSecond)
	slot0:updateTime()
	slot0:refreshUI()

	if slot0:_checkFirstEnter() then
		slot0._levelItemList[1]:setLockState()
		slot0:_lockScreen(true)
		TaskDispatcher.runDelay(slot0._playFirstUnlock, slot0, 0.8)
	end
end

function slot0._playFirstUnlock(slot0)
	if LiangYueConfig.instance:getFirstEpisodeId() then
		for slot5, slot6 in ipairs(slot0._levelItemList) do
			if slot6.episodeId == slot1.episodeId then
				slot6:refreshUI()
				slot6:refreshStoryState(false)
				slot6:playEpisodeAnim(LiangYueEnum.EpisodeAnim.Unlock, 0)
				AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_wangshi_argus_level_open)
				TaskDispatcher.runDelay(slot0.onPlayUnlockAnimEnd, slot0, 1)

				return
			end
		end
	end

	slot0:_lockScreen(false)
end

function slot0._checkFirstEnter(slot0)
	if slot0._levelItemList[2] and not slot1.isPreFinish and PlayerPrefsHelper.getNumber(string.format("ActLiangYueFirstEnter_%s", PlayerModel.instance:getMyUserId()), 0) == 0 then
		PlayerPrefsHelper.setNumber(slot2, 1)

		return true
	end

	return false
end

function slot0.refreshUI(slot0)
	if #LiangYueConfig.instance:getNoGameEpisodeList(slot0._actId) ~= #slot0._levelItemList then
		logError("levelItem Count not match")

		return
	end

	slot2 = 1
	slot3 = nil

	for slot7, slot8 in ipairs(slot0._levelItemList) do
		slot9 = slot1[slot7]

		slot8:setInfo(slot7, slot9)

		if LiangYueModel.instance:isEpisodeFinish(slot0._actId, slot9.preEpisodeId) then
			slot2 = slot7
			slot3 = slot9.episodeId
		end
	end

	slot0:_focusStoryItem(slot2, slot3, false, false, true)
	slot0:_playPathAnim(slot2, false)

	if slot3 ~= nil then
		TaskDispatcher.runDelay(slot0.delaySendEpisodeUnlockEvent, slot0, 0.01)
	end
end

function slot0.delaySendEpisodeUnlockEvent(slot0)
	LiangYueController.instance:dispatchEvent(LiangYueEvent.OnEpisodeUnlock, slot0._currentEpisodeId)
	logNormal("OnEpisodeUnlock episodeId: " .. slot0._currentEpisodeId)
end

function slot0._onDragBegin(slot0)
	slot0._audioScroll:onDragBegin()
end

function slot0._onDragEnd(slot0)
	slot0._audioScroll:onDragEnd()
end

function slot0._onScrollValueChanged(slot0)
end

function slot0._onClickDown(slot0)
	slot0._audioScroll:onClickDown()
end

function slot0._initBgPosition(slot0)
	recthelper.setAnchorX(slot0._simageFullBG.transform, Mathf.Clamp(-slot0._scrollStory.horizontalNormalizedPosition * slot0._bgPositonMaxOffsetX, slot0._minBgPositionX, slot0._maxBgPositionX))
end

function slot0._playPathAnim(slot0, slot1, slot2)
	if slot1 > 1 then
		slot0._pathAnimator.speed = 1

		slot0._pathAnimator:Play(string.format("go%s", Mathf.Clamp(slot1 - 1, 1, #slot0._levelItemList - 1)), 0, slot2 and 0 or 1)
	else
		slot0._pathAnimator.speed = 0

		slot0._pathAnimator:Play("go1", -1, 0)
	end
end

function slot0.onClickStoryItem(slot0, slot1, slot2, slot3)
	slot0:_focusStoryItem(slot1, slot2, slot3, true)
end

function slot0._focusStoryItem(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._currentEpisodeId = slot2
	slot0._currentIndex = slot1

	if slot0._offsetX - recthelper.getAnchorX(slot0._levelItemList[slot1]._go.transform.parent) > 0 then
		slot8 = 0
	elseif slot8 < slot0.minContentAnchorX then
		slot8 = slot0.minContentAnchorX
	end

	if slot5 then
		recthelper.setAnchorX(slot0._gostoryScroll.transform, slot8)
	elseif slot4 then
		ZProj.TweenHelper.DOAnchorPosX(slot0._gostoryScroll.transform, slot8, LiangYueEnum.FocusItemMoveDuration, slot0.onFocusEnd, slot0, {
			slot2,
			slot3
		})
	else
		ZProj.TweenHelper.DOAnchorPosX(slot0._gostoryScroll.transform, slot8, LiangYueEnum.FocusItemMoveDuration)
	end
end

function slot0.onFocusEnd(slot0, slot1)
	slot5 = LiangYueConfig.instance:getEpisodeConfigByActAndId(slot0._actId, slot1[1])

	if slot1[2] then
		LiangYueController.instance:openGameView(slot4, slot2)

		return
	end

	slot6 = slot5.storyId

	if LiangYueModel.instance:isEpisodeFinish(slot4, slot2) then
		StoryController.instance:playStory(slot6)

		return
	end

	StoryController.instance:playStory(slot6, {
		mark = true,
		episodeId = slot2
	}, slot0.onStoryFinished, slot0)
end

function slot0.onStoryFinished(slot0)
	LiangYueController.instance:finishEpisode(slot0._actId, slot0._currentEpisodeId)
end

function slot0.onEpisodeFinish(slot0, slot1, slot2)
	if slot0._actId ~= slot1 then
		return
	end

	slot0._finishEpisodeId = slot2
	slot3 = LiangYueConfig.instance:getEpisodeConfigByActAndId(slot1, slot2)
	slot0._finishEpisodeConfig = slot3

	if not (slot3.puzzleId == 0) then
		slot0._listenView = ViewName.LiangYueGameView

		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
	else
		slot0:_lockScreen(true)
		TaskDispatcher.runDelay(slot0.forceCloseMask, slot0, 10)
		TaskDispatcher.runDelay(slot0.onPlayFinishAnim, slot0, 1.93)
	end
end

function slot0.onCloseViewFinish(slot0, slot1)
	if slot1 ~= slot0._listenView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
	slot0:_lockScreen(true)
	TaskDispatcher.runDelay(slot0.forceCloseMask, slot0, 10)
	TaskDispatcher.runDelay(slot0.onPlayFinishAnim, slot0, 0.73)
end

function slot0.onPlayFinishAnim(slot0)
	TaskDispatcher.cancelTask(slot0.onPlayFinishAnim, slot0)

	slot1 = slot0._finishEpisodeId
	slot2 = nil
	slot3 = LiangYueConfig.instance:getNoGameEpisodeList(slot0._actId)

	for slot7, slot8 in ipairs(slot0._levelItemList) do
		if slot8.episodeId == slot1 or slot8.gameEpisodeId == slot1 then
			slot8:refreshUI()

			slot0._temptIndex = math.min(slot7 + 1, #slot0._levelItemList)

			if slot8.episodeId == slot1 then
				slot8:refreshStoryState(false)
				slot8:playEpisodeAnim(LiangYueEnum.EpisodeAnim.Finish, 0)
				AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_wulu_lucky_bag_prize)

				slot2 = LiangYueEnum.FinishStoryAnimDelayTime

				if slot8.gameEpisodeId then
					slot0._temptIndex = slot7
				end

				break
			end

			slot8:refreshGameState(false)
			slot8:playGameEpisodeAnim(LiangYueEnum.EpisodeGameAnim.FinishIdle, 0)
			slot8:playGameEpisodeRewardAnim(LiangYueEnum.EpisodeGameFinishAnim.Open, 0)

			slot2 = LiangYueEnum.FinishGameAnimDelayTime

			break
		else
			slot8:setInfo(slot7, slot3[slot7])
		end
	end

	if not slot2 then
		logError("未找到对应的关卡 id:" .. slot1)
		slot0:_lockScreen(false)
		slot0:refreshUI()

		return
	end

	TaskDispatcher.runDelay(slot0.onPlayPathAnim, slot0, slot2)
end

function slot0.forceCloseMask(slot0)
	slot0:_lockScreen(false)
	logError("动画计时器超时，强制关闭")
	slot0:refreshUI()
	TaskDispatcher.cancelTask(slot0.forceCloseMask, slot0)
end

function slot0.onPlayPathAnim(slot0)
	TaskDispatcher.cancelTask(slot0.onPlayPathAnim, slot0)

	if slot0._temptIndex == slot0._currentIndex then
		slot0:onPlayUnlockAnim()
	else
		slot0:_playPathAnim(slot0._temptIndex, true)
		slot0:_focusStoryItem(slot0._temptIndex, slot0._currentEpisodeId)
		TaskDispatcher.runDelay(slot0.onPlayUnlockAnim, slot0, LiangYueEnum.PathAnimDelayTime)
	end
end

function slot0.onPlayUnlockAnim(slot0)
	TaskDispatcher.cancelTask(slot0.onPlayUnlockAnim, slot0)

	for slot5, slot6 in ipairs(slot0._levelItemList) do
		if slot6.preEpisodeId == slot0._finishEpisodeId then
			slot6:refreshUI()
			slot6:refreshStoryState(false)
			slot6:playEpisodeAnim(LiangYueEnum.EpisodeAnim.Unlock, 0)
			AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_wangshi_argus_level_open)
		elseif slot6.episodeId == slot1 and slot6.gameEpisodeId ~= nil then
			slot6:refreshUI()
			slot6:refreshGameState(false)
			slot6:playGameEpisodeAnim(LiangYueEnum.EpisodeGameAnim.Open, 0)
			AudioMgr.instance:trigger(AudioEnum.LiangYueAudio.play_ui_feichi_stanzas)
		end
	end

	TaskDispatcher.runDelay(slot0.onPlayUnlockAnimEnd, slot0, LiangYueEnum.UnlockAnimDelayTime)
end

function slot0.onPlayUnlockAnimEnd(slot0)
	TaskDispatcher.cancelTask(slot0.onPlayUnlockAnimEnd, slot0)
	TaskDispatcher.cancelTask(slot0.forceCloseMask, slot0)
	slot0:_lockScreen(false)

	if slot0._finishEpisodeId then
		LiangYueController.instance:dispatchEvent(LiangYueEvent.OnEpisodeUnlock, slot0._finishEpisodeId)
		logNormal("OnEpisodeUnlock episodeId: " .. slot0._finishEpisodeId)
	end
end

function slot0._lockScreen(slot0, slot1)
	if slot1 then
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("LiangYueLevelLock")
	else
		UIBlockMgr.instance:endBlock("LiangYueLevelLock")
		UIBlockMgrExtend.setNeedCircleMv(true)
	end
end

function slot0.updateTime(slot0)
	if ActivityModel.instance:getActivityInfo()[slot0._actId] and slot2:getRealEndTimeStamp() - ServerTime.now() > 0 then
		slot0._txtlimittime.text = TimeUtil.SecondToActivityTimeFormat(slot3)

		return
	end

	TaskDispatcher.cancelTask(slot0.updateTime, slot0)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.updateTime, slot0)
	TaskDispatcher.cancelTask(slot0.onPlayFinishAnim, slot0)
	TaskDispatcher.cancelTask(slot0.onPlayPathAnim, slot0)
	TaskDispatcher.cancelTask(slot0.onPlayUnlockAnim, slot0)
	TaskDispatcher.cancelTask(slot0.onPlayUnlockAnimEnd, slot0)
	TaskDispatcher.cancelTask(slot0.forceCloseMask, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
