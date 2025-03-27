module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicChapterView", package.seeall)

slot0 = class("VersionActivity2_4MusicChapterView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_Title")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "root/time/#txt_time")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_task")
	slot0._goreddottask = gohelper.findChild(slot0.viewGO, "root/#btn_task/#go_reddottask")
	slot0._btnmodeentry = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_modeentry")
	slot0._gov2a4bakaluoerchapterlayout = gohelper.findChild(slot0.viewGO, "root/#go_v2a4_bakaluoer_chapterlayout")
	slot0._scrollChapterList = gohelper.findChildScrollRect(slot0.viewGO, "root/#go_v2a4_bakaluoer_chapterlayout/#scroll_ChapterList")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "root/#go_v2a4_bakaluoer_chapterlayout/#scroll_ChapterList/Viewport/#go_content")
	slot0._gocurrentdown = gohelper.findChild(slot0.viewGO, "root/#go_v2a4_bakaluoer_chapterlayout/#scroll_ChapterList/Viewport/#go_content/#go_currentdown")
	slot0._gocurrentBG = gohelper.findChild(slot0.viewGO, "root/#go_v2a4_bakaluoer_chapterlayout/#scroll_ChapterList/Viewport/#go_content/#go_currentBG")
	slot0._goleft = gohelper.findChild(slot0.viewGO, "#go_left")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
	slot0._btnmodeentry:AddClickListener(slot0._btnmodeentryOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntask:RemoveClickListener()
	slot0._btnmodeentry:RemoveClickListener()
end

function slot0._btntaskOnClick(slot0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicTaskView()
end

function slot0._btnmodeentryOnClick(slot0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeView()
end

function slot0._editableInitView(slot0)
	Activity179Model.instance:clearSelectedEpisodeId()

	slot0._taskAnimator = slot0._btntask.gameObject:GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(slot0._goreddottask, RedDotEnum.DotNode.V2a4MusicTaskRed, nil, slot0._refreshRedDot, slot0)
	slot0:_initChapterList()
end

function slot0._refreshRedDot(slot0, slot1)
	slot1:defaultRefreshDot()
	slot0._taskAnimator:Play(slot1.show and "loop" or "idle")
end

function slot0._initChapterList(slot0)
	slot0._itemList = slot0:getUserDataTb_()

	for slot5, slot6 in ipairs(Activity179Config.instance:getEpisodeCfgList(Activity179Model.instance:getActivityId())) do
		if slot6.episodeType ~= VersionActivity2_4MusicEnum.EpisodeType.Free then
			slot9 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gocontent), VersionActivity2_4MusicChapterItem)

			slot9:onUpdateMO(slot6)
			table.insert(slot0._itemList, slot9)
		end
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	TaskDispatcher.runRepeat(slot0._updateTime, slot0, 1)
	slot0:_updateTime()
	slot0:addEventCb(StoryController.instance, StoryEvent.StoryFrontViewDestroy, slot0._onEpisodeStoryBeforeFinished, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:_updateItemList()
	slot0:_moveChapterItem(slot0:_getSelectedEpisodeIndex())
end

function slot0._getSelectedEpisodeIndex(slot0)
	for slot5, slot6 in ipairs(slot0._itemList) do
		if slot6:getHasOpened() and slot6:getEpisodeId() == Activity179Model.instance:getSelectedEpisodeId() then
			return slot5
		end
	end

	Activity179Model.instance:clearSelectedEpisodeId()
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Version2_4MusicSelectEpisode, VersionActivity2_4MusicEnum.FirstEpisodeId)

	for slot5, slot6 in ipairs(slot0._itemList) do
		slot6:updateSelectedFlag()
	end

	return 1
end

function slot0._moveChapterItem(slot0, slot1)
	if not slot1 then
		return
	end

	recthelper.setAnchorX(slot0._gocontent.transform, -VersionActivity2_4MusicEnum.EpisodeItemWidth * slot1 + VersionActivity2_4MusicEnum.EpisodeItemWidth / 2 + recthelper.getWidth(slot0._scrollChapterList.transform) / 2)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 ~= ViewName.VersionActivity2_4MusicBeatView then
		return
	end

	slot0:_updateItemList(true)
end

function slot0._onEpisodeStoryBeforeFinished(slot0)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity2_4MusicBeatView) then
		return
	end

	slot0:_updateItemList(true)
end

function slot0._updateItemList(slot0, slot1)
	slot2, slot3 = nil

	for slot7, slot8 in ipairs(slot0._itemList) do
		slot8:updateView()

		if slot8:getHasFinished() then
			slot2 = slot7
		end

		if slot8:getHasOpened() then
			slot3 = slot7
		end
	end

	slot0._lastFinishedIndex = slot2

	slot0:_updateProgress(slot1, slot3)

	slot4 = slot2 == #slot0._itemList

	gohelper.setActive(slot0._btnmodeentry, slot4)

	if slot4 then
		GuideController.instance:dispatchEvent(GuideEvent.TriggerActive, GuideEnum.EventTrigger.MusicFreeView)
	end
end

function slot0._updateProgress(slot0, slot1, slot2)
	slot0._oldOpenIndex = slot0._lastOpenIndex
	slot0._lastOpenIndex = slot2

	if not slot1 or not slot0._oldOpenIndex or slot0._oldOpenIndex == slot0._lastOpenIndex then
		slot0:_setProgress(slot0._lastOpenIndex - 1, 1)

		return
	end

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, slot0._tweenFrame, slot0._tweenFinish, slot0)

	slot0:_moveChapterItem(slot0._lastOpenIndex)
	AudioMgr.instance:trigger(AudioEnum.Bakaluoer.play_ui_diqiu_unlock)
end

function slot0._tweenFrame(slot0, slot1)
	slot0:_setProgress(slot0._oldOpenIndex, slot1)
end

function slot0._tweenFinish(slot0)
	slot0:_setProgress(slot0._oldOpenIndex, 1)
end

function slot0._setProgress(slot0, slot1, slot2)
	if gohelper.isNil(slot0._gocurrentdown) then
		return
	end

	slot3 = (slot1 - 1) * VersionActivity2_4MusicEnum.EpisodeItemWidth + VersionActivity2_4MusicEnum.EpisodeItemWidth * slot2

	recthelper.setAnchorX(slot0._gocurrentdown.transform, VersionActivity2_4MusicEnum.ProgressLightPos + slot3)
	recthelper.setWidth(slot0._gocurrentBG.transform, VersionActivity2_4MusicEnum.ProgressBgWidth + slot3)
end

function slot0._updateTime(slot0)
	if ActivityModel.instance:getActivityInfo()[Activity179Model.instance:getActivityId()] and slot2:getRealEndTimeStamp() - ServerTime.now() > 0 then
		slot0._txttime.text = TimeUtil.SecondToActivityTimeFormat(slot3)

		return
	end

	TaskDispatcher.cancelTask(slot0._updateTime, slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.StoryFrontViewDestroy, slot0._onEpisodeStoryBeforeFinished, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	TaskDispatcher.cancelTask(slot0._updateTime, slot0)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
