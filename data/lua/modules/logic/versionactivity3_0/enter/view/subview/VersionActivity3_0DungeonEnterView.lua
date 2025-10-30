module("modules.logic.versionactivity3_0.enter.view.subview.VersionActivity3_0DungeonEnterView", package.seeall)

local var_0_0 = class("VersionActivity3_0DungeonEnterView", BaseView)

function var_0_0._playBgVideo(arg_1_0)
	arg_1_0._videoPath = langVideoUrl(VersionActivity3_0Enum.EnterLoopVideoName)

	if arg_1_0.viewParam and arg_1_0.viewParam.playVideo and arg_1_0.viewContainer then
		arg_1_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_1_0.onPlayVideoDone, arg_1_0)
		arg_1_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_1_0.onPlayVideoDone, arg_1_0)
		arg_1_0._videoComp:loadMedia(arg_1_0._videoPath)
	else
		arg_1_0._videoComp:play(arg_1_0._videoPath, true)
	end
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._simagebg = gohelper.findChildSingleImage(arg_2_0.viewGO, "#simage_bg")
	arg_2_0._txtdesc = gohelper.findChildText(arg_2_0.viewGO, "logo/#txt_dec")
	arg_2_0._gotime = gohelper.findChild(arg_2_0.viewGO, "logo/actbg")
	arg_2_0._txttime = gohelper.findChildText(arg_2_0.viewGO, "logo/actbg/#txt_time")
	arg_2_0._btnboard = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_Board")
	arg_2_0._txtpapernum = gohelper.findChildTextMesh(arg_2_0.viewGO, "#btn_Board/#txt_num")
	arg_2_0._goboardreddot = gohelper.findChild(arg_2_0.viewGO, "#btn_Board/#go_reddot")
	arg_2_0._btnstore = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "entrance/#btn_store")
	arg_2_0._txtStoreNum = gohelper.findChildText(arg_2_0.viewGO, "entrance/#btn_store/normal/#txt_num")
	arg_2_0._txtStoreTime = gohelper.findChildText(arg_2_0.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	arg_2_0._btnenter = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "entrance/#btn_enter")
	arg_2_0._goreddot = gohelper.findChild(arg_2_0.viewGO, "entrance/#btn_enter/#go_reddot")
	arg_2_0._btnFinished = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "entrance/#btn_Finished")
	arg_2_0._gonewunlock = gohelper.findChild(arg_2_0.viewGO, "entrance/#go_newunlock")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.refreshStoreCurrency, arg_3_0)
	arg_3_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0.onRefreshActivity, arg_3_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, arg_3_0._onUpdateDungeonInfo, arg_3_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, arg_3_0.refreshDot, arg_3_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_3_0.refreshDot, arg_3_0)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, arg_3_0.refreshDot, arg_3_0)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, arg_3_0.refreshPaperCount, arg_3_0)
	arg_3_0._btnboard:AddClickListener(arg_3_0._btnboardOnClick, arg_3_0)
	arg_3_0._btnstore:AddClickListener(arg_3_0._btnstoreOnClick, arg_3_0)
	arg_3_0._btnenter:AddClickListener(arg_3_0._btnenterOnClick, arg_3_0)
	arg_3_0._btnFinished:AddClickListener(arg_3_0._btnFinishedOnClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_4_0.refreshStoreCurrency, arg_4_0)
	arg_4_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_4_0.onRefreshActivity, arg_4_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, arg_4_0._onUpdateDungeonInfo, arg_4_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, arg_4_0.refreshDot, arg_4_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_4_0.refreshDot, arg_4_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, arg_4_0.refreshDot, arg_4_0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, arg_4_0.refreshPaperCount, arg_4_0)
	arg_4_0._btnboard:RemoveClickListener()
	arg_4_0._btnstore:RemoveClickListener()
	arg_4_0._btnenter:RemoveClickListener()
	arg_4_0._btnFinished:RemoveClickListener()
end

function var_0_0._onUpdateDungeonInfo(arg_5_0)
	if arg_5_0._hasPreviewFlag then
		arg_5_0:refreshPreviewStatus()
	end

	arg_5_0:_updateBg()
end

function var_0_0.onRefreshActivity(arg_6_0, arg_6_1)
	if arg_6_0._hasPreviewFlag then
		arg_6_0:refreshPreviewStatus()
	end

	if arg_6_1 ~= arg_6_0.actId then
		return
	end

	arg_6_0:refreshActivityState()
end

function var_0_0._btnboardOnClick(arg_7_0)
	CommandStationController.instance:openCommandStationPaperView()
end

function var_0_0._btnstoreOnClick(arg_8_0)
	VersionActivity3_0DungeonController.instance:openStoreView()
end

function var_0_0._btnenterOnClick(arg_9_0)
	local var_9_0 = arg_9_0._hasPreviewFlag

	if arg_9_0._hasPreviewFlag then
		local var_9_1 = DungeonMainStoryModel.getKey(PlayerPrefsKey.DungeonPreviewChapter, arg_9_0._chapterId)

		PlayerPrefsHelper.setNumber(var_9_1, 1)
		arg_9_0:refreshPreviewStatus()
	end

	if not GuideController.instance:isForbidGuides() and not GuideModel.instance:isGuideFinish(DungeonMainStoryEnum.Guide.EarlyAccess) then
		DungeonMainStoryModel.instance:setJumpFocusChapterId(arg_9_0._chapterId)
		DungeonController.instance:enterDungeonView(true, true)

		return
	end

	if arg_9_0._chapterId and DungeonMainStoryModel.instance:showPreviewChapterFlag(arg_9_0._chapterId) then
		local var_9_2 = DungeonMainStoryModel.getKey(PlayerPrefsKey.OpenDungeonPreviewChapter, arg_9_0._chapterId)

		if not PlayerPrefsHelper.hasKey(var_9_2) then
			GameFacade.showMessageBox(MessageBoxIdDefine.PreviewChapterOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(var_9_2, 1)
				VersionActivity3_0DungeonController.instance:openVersionActivityDungeonMapView()
			end, nil, nil)

			return
		end
	end

	VersionActivity3_0DungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0._btnFinishedOnClick(arg_11_0)
	return
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0._txtstorename = gohelper.findChildText(arg_12_0.viewGO, "entrance/#btn_store/normal/txt_shop")
	arg_12_0._chapterId = DungeonConfig.instance:getLastEarlyAccessChapterId()
	arg_12_0.actId = VersionActivity3_0Enum.ActivityId.Dungeon
	arg_12_0.animComp = VersionActivity3_0SubAnimatorComp.get(arg_12_0.viewGO, arg_12_0)
	arg_12_0.goEnter = arg_12_0._btnenter.gameObject
	arg_12_0.goFinish = arg_12_0._btnFinished.gameObject
	arg_12_0.goStore = arg_12_0._btnstore.gameObject
	arg_12_0.actId = VersionActivity3_0Enum.ActivityId.Dungeon
	arg_12_0.actCo = ActivityConfig.instance:getActivityCo(arg_12_0.actId)
	arg_12_0._videoComp = VersionActivityVideoComp.get(gohelper.findChild(arg_12_0.viewGO, "#simage_bg"), arg_12_0)

	arg_12_0:_setDesc()
	arg_12_0:refreshDot()
	RedDotController.instance:addRedDot(arg_12_0._goboardreddot, RedDotEnum.DotNode.CommandStationTask)
	arg_12_0:_updateBg()
end

function var_0_0._updateBg(arg_13_0)
	if DungeonModel.instance:hasPassLevelAndStory(11115) then
		arg_13_0._simagebg:LoadImage("singlebg/v3a0_mainactivity_singlebg/v3a0_enterview_fullbg.png")
	else
		arg_13_0._simagebg:LoadImage("singlebg/v3a0_mainactivity_singlebg/v3a0_enterview_fullbg.png")
	end
end

function var_0_0.refreshDot(arg_14_0)
	RedDotController.instance:addRedDot(arg_14_0._goreddot, RedDotEnum.DotNode.V3a0DungeonEnter)
end

function var_0_0._setDesc(arg_15_0)
	if not arg_15_0.actCo or not arg_15_0._txtdesc then
		return
	end

	arg_15_0._txtdesc.text = arg_15_0.actCo.actDesc
end

function var_0_0.onUpdateParam(arg_16_0)
	arg_16_0:refreshUI()
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0:refreshUI()
	arg_17_0.animComp:playOpenAnim()
	TaskDispatcher.runRepeat(arg_17_0.everyMinuteCall, arg_17_0, TimeUtil.OneMinuteSecond)
	arg_17_0:_playBgVideo()
end

function var_0_0.onOpenFinish(arg_18_0)
	do return end

	arg_18_0._videoPath = langVideoUrl(VersionActivity3_0Enum.EnterLoopVideoName)

	if arg_18_0.viewParam and arg_18_0.viewParam.playVideo and arg_18_0.viewContainer then
		arg_18_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_18_0.onPlayVideoDone, arg_18_0)
		arg_18_0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_18_0.onPlayVideoDone, arg_18_0)
		arg_18_0._videoComp:loadMedia(arg_18_0._videoPath)
	else
		arg_18_0._videoComp:play(arg_18_0._videoPath, true)
	end
end

function var_0_0.onPlayVideoDone(arg_19_0)
	arg_19_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, arg_19_0.onPlayVideoDone, arg_19_0)
	arg_19_0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, arg_19_0.onPlayVideoDone, arg_19_0)
	arg_19_0._videoComp:play(arg_19_0._videoPath, true)
end

function var_0_0.everyMinuteCall(arg_20_0)
	arg_20_0:refreshUI()
end

function var_0_0.refreshUI(arg_21_0)
	arg_21_0:refreshRemainTime()
	arg_21_0:refreshActivityState()
	arg_21_0:refreshStoreCurrency()
	arg_21_0:refreshPreviewStatus()
	arg_21_0:refreshPaperCount()
end

function var_0_0.refreshPaperCount(arg_22_0)
	local var_22_0 = CommandStationConfig.instance:getPaperList()
	local var_22_1 = 0
	local var_22_2 = 0
	local var_22_3 = CommandStationConfig.instance:getCurVersionId()

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if iter_22_1.versionId == var_22_3 then
			var_22_2 = iter_22_1.allNum

			break
		end

		var_22_1 = var_22_1 + iter_22_1.allNum
	end

	local var_22_4 = CommandStationConfig.instance:getCurPaperCount() - var_22_1
	local var_22_5 = Mathf.Clamp(var_22_4, 0, var_22_2)

	arg_22_0._txtpapernum.text = string.format("%d/%d", var_22_5, var_22_2)
end

function var_0_0.refreshPreviewStatus(arg_23_0)
	arg_23_0._hasPreviewFlag = arg_23_0._chapterId and DungeonMainStoryModel.instance:showPreviewChapterFlag(arg_23_0._chapterId) and not DungeonMainStoryModel.hasKey(PlayerPrefsKey.DungeonPreviewChapter, arg_23_0._chapterId)

	gohelper.setActive(arg_23_0._gonewunlock, arg_23_0._hasPreviewFlag)
end

function var_0_0.refreshRemainTime(arg_24_0)
	local var_24_0 = ActivityModel.instance:getActivityInfo()[arg_24_0.actId]:getRealEndTimeStamp() - ServerTime.now()

	if var_24_0 > 0 then
		local var_24_1 = TimeUtil.SecondToActivityTimeFormat(var_24_0)

		arg_24_0._txttime.text = var_24_1

		gohelper.setActive(arg_24_0._txttime, true)
	else
		gohelper.setActive(arg_24_0._txttime, false)
	end

	local var_24_2 = ActivityModel.instance:getActivityInfo()[VersionActivity3_0Enum.ActivityId.DungeonStore]

	arg_24_0._txtstorename.text = var_24_2.config.name
	arg_24_0._txtStoreTime.text = var_24_2:getRemainTimeStr2ByEndTime(true)
end

function var_0_0.refreshActivityState(arg_25_0)
	local var_25_0 = ActivityHelper.getActivityStatusAndToast(arg_25_0.actId)
	local var_25_1 = var_25_0 == ActivityEnum.ActivityStatus.Normal

	var_25_1 = var_25_1 or ActivityHelper.getActivityStatusAndToast(VersionActivity3_0Enum.ActivityId.EnterView) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_25_0.goEnter, var_25_1)
	gohelper.setActive(arg_25_0.goFinish, not var_25_1)

	local var_25_2 = var_25_0 == ActivityEnum.ActivityStatus.Expired

	gohelper.setActive(arg_25_0._gotime, not var_25_2)

	local var_25_3 = ActivityHelper.getActivityStatusAndToast(VersionActivity3_0Enum.ActivityId.DungeonStore) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_25_0.goStore, var_25_3)
end

function var_0_0.refreshStoreCurrency(arg_26_0)
	local var_26_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V3a0Dungeon)
	local var_26_1 = var_26_0 and var_26_0.quantity or 0

	arg_26_0._txtStoreNum.text = GameUtil.numberDisplay(var_26_1)
end

function var_0_0.onClose(arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0.everyMinuteCall, arg_27_0)
end

function var_0_0.onDestroyView(arg_28_0)
	arg_28_0.animComp:destroy()
	arg_28_0._videoComp:destroy()
end

return var_0_0
