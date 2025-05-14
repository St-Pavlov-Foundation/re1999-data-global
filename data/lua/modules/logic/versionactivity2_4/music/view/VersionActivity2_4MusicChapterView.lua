module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicChapterView", package.seeall)

local var_0_0 = class("VersionActivity2_4MusicChapterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_Title")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "root/time/#txt_time")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_task")
	arg_1_0._goreddottask = gohelper.findChild(arg_1_0.viewGO, "root/#btn_task/#go_reddottask")
	arg_1_0._btnmodeentry = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_modeentry")
	arg_1_0._gov2a4bakaluoerchapterlayout = gohelper.findChild(arg_1_0.viewGO, "root/#go_v2a4_bakaluoer_chapterlayout")
	arg_1_0._scrollChapterList = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#go_v2a4_bakaluoer_chapterlayout/#scroll_ChapterList")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "root/#go_v2a4_bakaluoer_chapterlayout/#scroll_ChapterList/Viewport/#go_content")
	arg_1_0._gocurrentdown = gohelper.findChild(arg_1_0.viewGO, "root/#go_v2a4_bakaluoer_chapterlayout/#scroll_ChapterList/Viewport/#go_content/#go_currentdown")
	arg_1_0._gocurrentBG = gohelper.findChild(arg_1_0.viewGO, "root/#go_v2a4_bakaluoer_chapterlayout/#scroll_ChapterList/Viewport/#go_content/#go_currentBG")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#go_left")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnmodeentry:AddClickListener(arg_2_0._btnmodeentryOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnmodeentry:RemoveClickListener()
end

function var_0_0._btntaskOnClick(arg_4_0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicTaskView()
end

function var_0_0._btnmodeentryOnClick(arg_5_0)
	VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicFreeView()
end

function var_0_0._editableInitView(arg_6_0)
	Activity179Model.instance:clearSelectedEpisodeId()

	arg_6_0._taskAnimator = arg_6_0._btntask.gameObject:GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(arg_6_0._goreddottask, RedDotEnum.DotNode.V2a4MusicTaskRed, nil, arg_6_0._refreshRedDot, arg_6_0)
	arg_6_0:_initChapterList()
end

function var_0_0._refreshRedDot(arg_7_0, arg_7_1)
	arg_7_1:defaultRefreshDot()

	local var_7_0 = arg_7_1.show

	arg_7_0._taskAnimator:Play(var_7_0 and "loop" or "idle")
end

function var_0_0._initChapterList(arg_8_0)
	arg_8_0._itemList = arg_8_0:getUserDataTb_()

	local var_8_0 = Activity179Config.instance:getEpisodeCfgList(Activity179Model.instance:getActivityId())

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if iter_8_1.episodeType ~= VersionActivity2_4MusicEnum.EpisodeType.Free then
			local var_8_1 = arg_8_0.viewContainer:getSetting().otherRes[1]
			local var_8_2 = arg_8_0:getResInst(var_8_1, arg_8_0._gocontent)
			local var_8_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_2, VersionActivity2_4MusicChapterItem)

			var_8_3:onUpdateMO(iter_8_1)
			table.insert(arg_8_0._itemList, var_8_3)
		end
	end
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	TaskDispatcher.runRepeat(arg_10_0._updateTime, arg_10_0, 1)
	arg_10_0:_updateTime()
	arg_10_0:addEventCb(StoryController.instance, StoryEvent.StoryFrontViewDestroy, arg_10_0._onEpisodeStoryBeforeFinished, arg_10_0)
	arg_10_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_10_0._onCloseViewFinish, arg_10_0)
	arg_10_0:_updateItemList()
	arg_10_0:_moveChapterItem(arg_10_0:_getSelectedEpisodeIndex())
end

function var_0_0._getSelectedEpisodeIndex(arg_11_0)
	local var_11_0 = Activity179Model.instance:getSelectedEpisodeId()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._itemList) do
		if iter_11_1:getHasOpened() and iter_11_1:getEpisodeId() == var_11_0 then
			return iter_11_0
		end
	end

	Activity179Model.instance:clearSelectedEpisodeId()
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Version2_4MusicSelectEpisode, VersionActivity2_4MusicEnum.FirstEpisodeId)

	for iter_11_2, iter_11_3 in ipairs(arg_11_0._itemList) do
		iter_11_3:updateSelectedFlag()
	end

	return 1
end

function var_0_0._moveChapterItem(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	local var_12_0 = recthelper.getWidth(arg_12_0._scrollChapterList.transform)

	recthelper.setAnchorX(arg_12_0._gocontent.transform, -VersionActivity2_4MusicEnum.EpisodeItemWidth * arg_12_1 + VersionActivity2_4MusicEnum.EpisodeItemWidth / 2 + var_12_0 / 2)
end

function var_0_0._onCloseViewFinish(arg_13_0, arg_13_1)
	if arg_13_1 ~= ViewName.VersionActivity2_4MusicBeatView then
		return
	end

	arg_13_0:_updateItemList(true)
end

function var_0_0._onEpisodeStoryBeforeFinished(arg_14_0)
	if ViewMgr.instance:isOpen(ViewName.VersionActivity2_4MusicBeatView) then
		return
	end

	arg_14_0:_updateItemList(true)
end

function var_0_0._updateItemList(arg_15_0, arg_15_1)
	local var_15_0
	local var_15_1

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._itemList) do
		iter_15_1:updateView()

		if iter_15_1:getHasFinished() then
			var_15_0 = iter_15_0
		end

		if iter_15_1:getHasOpened() then
			var_15_1 = iter_15_0
		end
	end

	arg_15_0._lastFinishedIndex = var_15_0

	arg_15_0:_updateProgress(arg_15_1, var_15_1)

	local var_15_2 = var_15_0 == #arg_15_0._itemList

	gohelper.setActive(arg_15_0._btnmodeentry, var_15_2)

	if var_15_2 then
		GuideController.instance:dispatchEvent(GuideEvent.TriggerActive, GuideEnum.EventTrigger.MusicFreeView)
	end
end

function var_0_0._updateProgress(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._oldOpenIndex = arg_16_0._lastOpenIndex
	arg_16_0._lastOpenIndex = arg_16_2

	if not arg_16_1 or not arg_16_0._oldOpenIndex or arg_16_0._oldOpenIndex == arg_16_0._lastOpenIndex then
		arg_16_0:_setProgress(arg_16_0._lastOpenIndex - 1, 1)

		return
	end

	arg_16_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, arg_16_0._tweenFrame, arg_16_0._tweenFinish, arg_16_0)

	arg_16_0:_moveChapterItem(arg_16_0._lastOpenIndex)
	AudioMgr.instance:trigger(AudioEnum.Bakaluoer.play_ui_diqiu_unlock)
end

function var_0_0._tweenFrame(arg_17_0, arg_17_1)
	arg_17_0:_setProgress(arg_17_0._oldOpenIndex, arg_17_1)
end

function var_0_0._tweenFinish(arg_18_0)
	arg_18_0:_setProgress(arg_18_0._oldOpenIndex, 1)
end

function var_0_0._setProgress(arg_19_0, arg_19_1, arg_19_2)
	if gohelper.isNil(arg_19_0._gocurrentdown) then
		return
	end

	local var_19_0 = (arg_19_1 - 1) * VersionActivity2_4MusicEnum.EpisodeItemWidth + VersionActivity2_4MusicEnum.EpisodeItemWidth * arg_19_2

	recthelper.setAnchorX(arg_19_0._gocurrentdown.transform, VersionActivity2_4MusicEnum.ProgressLightPos + var_19_0)
	recthelper.setWidth(arg_19_0._gocurrentBG.transform, VersionActivity2_4MusicEnum.ProgressBgWidth + var_19_0)
end

function var_0_0._updateTime(arg_20_0)
	local var_20_0 = Activity179Model.instance:getActivityId()
	local var_20_1 = ActivityModel.instance:getActivityInfo()[var_20_0]

	if var_20_1 then
		local var_20_2 = var_20_1:getRealEndTimeStamp() - ServerTime.now()

		if var_20_2 > 0 then
			local var_20_3 = TimeUtil.SecondToActivityTimeFormat(var_20_2)

			arg_20_0._txttime.text = var_20_3

			return
		end
	end

	TaskDispatcher.cancelTask(arg_20_0._updateTime, arg_20_0)
end

function var_0_0.onClose(arg_21_0)
	arg_21_0:removeEventCb(StoryController.instance, StoryEvent.StoryFrontViewDestroy, arg_21_0._onEpisodeStoryBeforeFinished, arg_21_0)
	arg_21_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_21_0._onCloseViewFinish, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._updateTime, arg_21_0)

	if arg_21_0._tweenId then
		ZProj.TweenHelper.KillById(arg_21_0._tweenId)

		arg_21_0._tweenId = nil
	end
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

return var_0_0
