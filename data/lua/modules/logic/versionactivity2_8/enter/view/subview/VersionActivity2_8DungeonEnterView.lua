module("modules.logic.versionactivity2_8.enter.view.subview.VersionActivity2_8DungeonEnterView", package.seeall)

local var_0_0 = class("VersionActivity2_8DungeonEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_dec")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "logo/actbg")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "logo/actbg/#txt_time")
	arg_1_0._btnstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_store")
	arg_1_0._txtStoreNum = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/normal/#txt_num")
	arg_1_0._txtStoreTime = gohelper.findChildText(arg_1_0.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	arg_1_0._btnenter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_enter")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "entrance/#btn_enter/#go_reddot")
	arg_1_0._btnFinished = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_Finished")
	arg_1_0._gonewunlock = gohelper.findChild(arg_1_0.viewGO, "entrance/#go_newunlock")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.refreshStoreCurrency, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.onRefreshActivity, arg_2_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, arg_2_0._onUpdateDungeonInfo, arg_2_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, arg_2_0.refreshDot, arg_2_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_2_0.refreshDot, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, arg_2_0.refreshDot, arg_2_0)
	arg_2_0._btnstore:AddClickListener(arg_2_0._btnstoreOnClick, arg_2_0)
	arg_2_0._btnenter:AddClickListener(arg_2_0._btnenterOnClick, arg_2_0)
	arg_2_0._btnFinished:AddClickListener(arg_2_0._btnFinishedOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.refreshStoreCurrency, arg_3_0)
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0.onRefreshActivity, arg_3_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, arg_3_0._onUpdateDungeonInfo, arg_3_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, arg_3_0.refreshDot, arg_3_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_3_0.refreshDot, arg_3_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, arg_3_0.refreshDot, arg_3_0)
	arg_3_0._btnstore:RemoveClickListener()
	arg_3_0._btnenter:RemoveClickListener()
	arg_3_0._btnFinished:RemoveClickListener()
end

function var_0_0._onUpdateDungeonInfo(arg_4_0)
	if arg_4_0._hasPreviewFlag then
		arg_4_0:refreshPreviewStatus()
	end
end

function var_0_0.onRefreshActivity(arg_5_0, arg_5_1)
	if arg_5_0._hasPreviewFlag then
		arg_5_0:refreshPreviewStatus()
	end

	if arg_5_1 ~= arg_5_0.actId then
		return
	end

	arg_5_0:refreshActivityState()
end

function var_0_0._btnstoreOnClick(arg_6_0)
	VersionActivity2_8DungeonController.instance:openStoreView()
end

function var_0_0._btnenterOnClick(arg_7_0)
	local var_7_0 = arg_7_0._hasPreviewFlag

	if arg_7_0._hasPreviewFlag then
		local var_7_1 = DungeonMainStoryModel.getKey(PlayerPrefsKey.DungeonPreviewChapter, arg_7_0._chapterId)

		PlayerPrefsHelper.setNumber(var_7_1, 1)
		arg_7_0:refreshPreviewStatus()
	end

	if not GuideController.instance:isForbidGuides() and not GuideModel.instance:isGuideFinish(DungeonMainStoryEnum.Guide.EarlyAccess) then
		DungeonMainStoryModel.instance:setJumpFocusChapterId(arg_7_0._chapterId)
		DungeonController.instance:enterDungeonView(true, true)

		return
	end

	if arg_7_0._chapterId and DungeonMainStoryModel.instance:showPreviewChapterFlag(arg_7_0._chapterId) then
		local var_7_2 = DungeonMainStoryModel.getKey(PlayerPrefsKey.OpenDungeonPreviewChapter, arg_7_0._chapterId)

		if not PlayerPrefsHelper.hasKey(var_7_2) then
			GameFacade.showMessageBox(MessageBoxIdDefine.PreviewChapterOpenTip, MsgBoxEnum.BoxType.Yes_No, function()
				PlayerPrefsHelper.setNumber(var_7_2, 1)
				VersionActivity2_8DungeonController.instance:openVersionActivityDungeonMapView()
			end, nil, nil)

			return
		end
	end

	VersionActivity2_8DungeonController.instance:openVersionActivityDungeonMapView()
end

function var_0_0._btnFinishedOnClick(arg_9_0)
	return
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._txtstorename = gohelper.findChildText(arg_10_0.viewGO, "entrance/#btn_store/normal/txt_shop")
	arg_10_0._chapterId = DungeonConfig.instance:getLastEarlyAccessChapterId()
	arg_10_0.actId = VersionActivity2_8Enum.ActivityId.Dungeon
	arg_10_0.animComp = VersionActivity2_8SubAnimatorComp.get(arg_10_0.viewGO, arg_10_0)
	arg_10_0.goEnter = arg_10_0._btnenter.gameObject
	arg_10_0.goFinish = arg_10_0._btnFinished.gameObject
	arg_10_0.goStore = arg_10_0._btnstore.gameObject
	arg_10_0.actId = VersionActivity2_8Enum.ActivityId.Dungeon
	arg_10_0.actCo = ActivityConfig.instance:getActivityCo(arg_10_0.actId)

	arg_10_0:_setDesc()
	arg_10_0:refreshDot()
end

function var_0_0.refreshDot(arg_11_0)
	local var_11_0 = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a8DungeonEnter, 0)

	gohelper.setActive(arg_11_0._goreddot, var_11_0)
end

function var_0_0._setDesc(arg_12_0)
	if not arg_12_0.actCo or not arg_12_0._txtdesc then
		return
	end

	arg_12_0._txtdesc.text = arg_12_0.actCo.actDesc
end

function var_0_0.onUpdateParam(arg_13_0)
	arg_13_0:refreshUI()
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:refreshUI()
	arg_14_0.animComp:playOpenAnim()
	TaskDispatcher.runRepeat(arg_14_0.everyMinuteCall, arg_14_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.everyMinuteCall(arg_15_0)
	arg_15_0:refreshUI()
end

function var_0_0.refreshUI(arg_16_0)
	arg_16_0:refreshRemainTime()
	arg_16_0:refreshActivityState()
	arg_16_0:refreshStoreCurrency()
	arg_16_0:refreshPreviewStatus()
end

function var_0_0.refreshPreviewStatus(arg_17_0)
	arg_17_0._hasPreviewFlag = arg_17_0._chapterId and DungeonMainStoryModel.instance:showPreviewChapterFlag(arg_17_0._chapterId) and not DungeonMainStoryModel.hasKey(PlayerPrefsKey.DungeonPreviewChapter, arg_17_0._chapterId)

	gohelper.setActive(arg_17_0._gonewunlock, arg_17_0._hasPreviewFlag)
end

function var_0_0.refreshRemainTime(arg_18_0)
	local var_18_0 = ActivityModel.instance:getActivityInfo()[arg_18_0.actId]:getRealEndTimeStamp() - ServerTime.now()

	if var_18_0 > 0 then
		local var_18_1 = TimeUtil.SecondToActivityTimeFormat(var_18_0)

		arg_18_0._txttime.text = var_18_1

		gohelper.setActive(arg_18_0._txttime, true)
	else
		gohelper.setActive(arg_18_0._txttime, false)
	end

	local var_18_2 = ActivityModel.instance:getActivityInfo()[VersionActivity2_8Enum.ActivityId.DungeonStore]

	arg_18_0._txtstorename.text = var_18_2.config.name
	arg_18_0._txtStoreTime.text = var_18_2:getRemainTimeStr2ByEndTime(true)
end

function var_0_0.refreshActivityState(arg_19_0)
	local var_19_0 = ActivityHelper.getActivityStatusAndToast(arg_19_0.actId)
	local var_19_1 = var_19_0 == ActivityEnum.ActivityStatus.Normal

	var_19_1 = var_19_1 or ActivityHelper.getActivityStatusAndToast(VersionActivity2_8Enum.ActivityId.EnterView) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_19_0.goEnter, var_19_1)
	gohelper.setActive(arg_19_0.goFinish, not var_19_1)

	local var_19_2 = var_19_0 == ActivityEnum.ActivityStatus.Expired

	gohelper.setActive(arg_19_0._gotime, not var_19_2)

	local var_19_3 = ActivityHelper.getActivityStatusAndToast(VersionActivity2_8Enum.ActivityId.DungeonStore) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_19_0.goStore, var_19_3)
end

function var_0_0.refreshStoreCurrency(arg_20_0)
	local var_20_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a8Dungeon)
	local var_20_1 = var_20_0 and var_20_0.quantity or 0

	arg_20_0._txtStoreNum.text = GameUtil.numberDisplay(var_20_1)
end

function var_0_0.onClose(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.everyMinuteCall, arg_21_0)
end

function var_0_0.onDestroyView(arg_22_0)
	arg_22_0.animComp:destroy()
end

return var_0_0
