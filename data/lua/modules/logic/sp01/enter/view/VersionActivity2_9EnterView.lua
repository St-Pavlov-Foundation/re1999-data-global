module("modules.logic.sp01.enter.view.VersionActivity2_9EnterView", package.seeall)

local var_0_0 = class("VersionActivity2_9EnterView", VersionActivityEnterBaseViewWithGroup)

var_0_0.UnitCameraKey = "VersionActivity2_9EnterView_UnitCameraKey"

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "logo/Time/timebg/#txt_remaintime")
	arg_1_0._txtremaintime2 = gohelper.findChildText(arg_1_0.viewGO, "logo2/Time/timebg/#txt_remaintime")
	arg_1_0.txtDungeonStoreNum1 = gohelper.findChildText(arg_1_0.viewGO, "entrance/#go_group1/activityContainer3/normal/#txt_num")
	arg_1_0.txtDungeonStoreNum2 = gohelper.findChildText(arg_1_0.viewGO, "entrance/#go_group2/activityContainer6/normal/#txt_num")
	arg_1_0.txtDungeonStoreRemainTime1 = gohelper.findChildText(arg_1_0.viewGO, "entrance/#go_group1/activityContainer3/#go_time/#txt_time")
	arg_1_0.txtDungeonStoreRemainTime2 = gohelper.findChildText(arg_1_0.viewGO, "entrance/#go_group2/activityContainer6/#go_time/#txt_time")
	arg_1_0._btnachievementpreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_achievementpreview")
	arg_1_0._btnodysseyreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#go_group2/activityContainer9/btn_reward")
	arg_1_0._txtodysseylevel = gohelper.findChildText(arg_1_0.viewGO, "entrance/#go_group2/activityContainer9/normal/#txt_level")
	arg_1_0._gojumpblock = gohelper.findChild(arg_1_0.viewGO, "#go_jumpblock")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._btnachievementpreview:AddClickListener(arg_2_0._btnachievementpreviewOnClick, arg_2_0)
	arg_2_0._btnodysseyreward:AddClickListener(arg_2_0._btnodysseyrewardOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._btnachievementpreview:RemoveClickListener()
	arg_3_0._btnodysseyreward:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	var_0_0.super._editableInitView(arg_4_0)
	arg_4_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_4_0.refreshActivityState, arg_4_0)
	arg_4_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_4_0.refreshCurrency, arg_4_0)
	arg_4_0:addEventCb(VersionActivity2_9EnterController.instance, VersionActivity2_9Event.SwitchGroup, arg_4_0._switchGroupIndex, arg_4_0)
	arg_4_0:addEventCb(OdysseyController.instance, OdysseyEvent.RefreshHeroInfo, arg_4_0.refreshOdysseyLevel, arg_4_0)
	arg_4_0:addEventCb(OdysseyController.instance, OdysseyEvent.OdysseyTaskUpdated, arg_4_0.refreshReddot, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_4_0._onOpenView, arg_4_0)
	arg_4_0:addEventCb(NavigateMgr.instance, NavigateEvent.ClickHome, arg_4_0._clickHome, arg_4_0)

	arg_4_0.reddotIconMap = arg_4_0:getUserDataTb_()

	CameraMgr.instance:setSceneCameraActive(false, var_0_0.UnitCameraKey)

	arg_4_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_4_0.viewGO)
end

function var_0_0._btnachievementpreviewOnClick(arg_5_0)
	local var_5_0 = ActivityConfig.instance:getActivityCo(arg_5_0.actId)
	local var_5_1 = var_5_0 and var_5_0.achievementJumpId

	JumpController.instance:jump(var_5_1)
end

function var_0_0._btnodysseyrewardOnClick(arg_6_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Odyssey
	}, function()
		OdysseyTaskModel.instance:setTaskInfoList()
		OdysseyDungeonController.instance:openLevelRewardView()
	end)
end

function var_0_0._activityBtnOnClick(arg_8_0, arg_8_1)
	if arg_8_1.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	if not (arg_8_0["checkActivityCanClickFunc" .. arg_8_1.index] or arg_8_0.defaultCheckActivityCanClick)(arg_8_0, arg_8_1) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)

	local var_8_0 = arg_8_0["onClickActivity" .. arg_8_1.actId] or arg_8_0["onClickActivity" .. arg_8_1.index]

	if var_8_0 then
		var_8_0(arg_8_0)
	end

	ActivityEnterMgr.instance:enterActivity(arg_8_1.actId)
end

function var_0_0.onClickActivity130504(arg_9_0)
	AssassinController.instance:openAssassinMapView(nil, true)
end

function var_0_0.onClickActivity130505(arg_10_0)
	BossRushController.instance:openMainView()
end

function var_0_0.onClickActivity130503(arg_11_0)
	VersionActivity2_9DungeonController.instance:openStoreView()
end

function var_0_0.onClickActivity130502(arg_12_0)
	local var_12_0 = VersionActivity2_9DungeonEnum.DungeonChapterId.Story

	if VersionActivity2_9DungeonHelper.isAllEpisodeAdvacePass(var_12_0) then
		local var_12_1 = AssassinConfig.instance:getAssassinConst(AssassinEnum.ConstId.FocusEpisodeId, true)

		VersionActivity2_9DungeonController.instance:openVersionActivityDungeonMapView(var_12_0, var_12_1)
	else
		VersionActivity2_9DungeonController.instance:openVersionActivityDungeonMapView()
	end
end

function var_0_0.onClickActivity130507(arg_13_0)
	OdysseyDungeonModel.instance:cleanLastElementFightParam()
	OdysseyDungeonController.instance:openDungeonView()
end

function var_0_0.refreshUI(arg_14_0)
	var_0_0.super.refreshUI(arg_14_0)
	arg_14_0:refreshOdysseyLevel()
	arg_14_0:refreshEnterViewTime()
	arg_14_0:updateAchievementBtnVisible()
	arg_14_0:refreshCurrency()
	arg_14_0:refreshDungeonStoreTime()
	arg_14_0:refreshReddot()
end

function var_0_0.refreshOdysseyLevel(arg_15_0)
	arg_15_0._txtodysseylevel.text = OdysseyModel.instance:getHeroCurLevelAndExp() or 1
end

function var_0_0.refreshEnterViewTime(arg_16_0)
	arg_16_0:refreshRemainTime()
end

function var_0_0.refreshCurrency(arg_17_0)
	local var_17_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a9Dungeon)
	local var_17_1 = var_17_0 and var_17_0.quantity or 0

	arg_17_0.txtDungeonStoreNum1.text = var_17_1
	arg_17_0.txtDungeonStoreNum2.text = var_17_1
end

function var_0_0.refreshDungeonStoreTime(arg_18_0)
	local var_18_0 = ActivityModel.instance:getActivityInfo()[VersionActivity2_9Enum.ActivityId.DungeonStore]
	local var_18_1 = var_18_0 and var_18_0:getRemainTimeStr2ByEndTime(true)

	arg_18_0.txtDungeonStoreRemainTime1.text = var_18_1
	arg_18_0.txtDungeonStoreRemainTime2.text = var_18_1
end

function var_0_0.refreshRemainTime(arg_19_0)
	local var_19_0 = ActivityModel.instance:getActivityInfo()[arg_19_0.actId]:getRealEndTimeStamp() - ServerTime.now()
	local var_19_1 = string.format(luaLang("remain"), TimeUtil.SecondToActivityTimeFormat(var_19_0))

	arg_19_0._txtremaintime.text = var_19_1
	arg_19_0._txtremaintime2.text = var_19_1
end

function var_0_0.everyMinuteCall(arg_20_0)
	var_0_0.super.everyMinuteCall(arg_20_0)
	arg_20_0:refreshRemainTime()
	arg_20_0:refreshDungeonStoreTime()
end

function var_0_0.updateAchievementBtnVisible(arg_21_0)
	local var_21_0 = ActivityConfig.instance:getActivityCo(arg_21_0.actId)

	gohelper.setActive(arg_21_0._btnachievementpreview.gameObject, var_21_0 and var_21_0.achievementJumpId ~= 0)
end

function var_0_0.initBtnGroup(arg_22_0)
	arg_22_0.groupItemList = {}
end

function var_0_0.onCloseViewFinish(arg_23_0, arg_23_1)
	var_0_0.super.onCloseViewFinish(arg_23_0, arg_23_1)
	arg_23_0:playAnimWhileCloseTargetView(arg_23_1)
	arg_23_0:tryTriggerGuide()
end

function var_0_0.playAnimWhileCloseTargetView(arg_24_0, arg_24_1)
	if arg_24_1 ~= ViewName.VersionActivity2_9DungeonMapView and arg_24_1 ~= ViewName.OdysseyDungeonView then
		return
	end

	local var_24_0 = arg_24_0.showGroupIndex == 1 and "game_a" or "game_b"

	arg_24_0.animator:Play(var_24_0, 0, 0)
end

function var_0_0._switchGroupIndex(arg_25_0)
	arg_25_0.showGroupIndex = arg_25_0.showGroupIndex == 1 and 2 or 1

	local var_25_0 = arg_25_0.showGroupIndex == 1 and "switch_b" or "switch_a"

	arg_25_0._animatorPlayer:Play(var_25_0, arg_25_0._onSwitchGroupIndexDone, arg_25_0)
	VersionActivity2_9EnterController.instance:dispatchEvent(VersionActivity2_9Event.StopBgm)
end

function var_0_0._onSwitchGroupIndexDone(arg_26_0)
	ActivityStageHelper.recordOneActivityStage(arg_26_0.mainActIdList[arg_26_0.showGroupIndex])
	VersionActivity2_9EnterController.instance:recordLastEnterMainActId(arg_26_0.mainActIdList[arg_26_0.showGroupIndex])
	VersionActivity2_9EnterController.instance:dispatchEvent(VersionActivity2_9Event.ManualSwitchBgm)
end

function var_0_0.playAmbientAudio(arg_27_0)
	return
end

function var_0_0.initGroupIndex(arg_28_0)
	arg_28_0.showGroupIndex = tabletool.indexOf(VersionActivity2_9Enum.EnterViewMainActIdList, arg_28_0.actId) or 1

	ActivityStageHelper.recordOneActivityStage(arg_28_0.mainActIdList[arg_28_0.showGroupIndex])
end

function var_0_0.onOpen(arg_29_0)
	var_0_0.super.onOpen(arg_29_0)
	gohelper.setActive(arg_29_0._gojumpblock, arg_29_0.viewParam and arg_29_0.viewParam.skipOpenAnim)
end

function var_0_0.onOpenFinish(arg_30_0)
	var_0_0.super.onOpenFinish(arg_30_0)
	CameraMgr.instance:setSceneCameraActive(true, var_0_0.UnitCameraKey)
end

function var_0_0.tryTriggerGuide(arg_31_0)
	if not GuideModel.instance:isGuideFinish(VersionActivity2_9Enum.NextGroupGuideId) and not arg_31_0.onOpening and ViewHelper.instance:checkViewOnTheTop(arg_31_0.viewName) and ActivityHelper.isOpen(VersionActivity2_9Enum.ActivityId.EnterView2) then
		VersionActivity2_9EnterController.instance:dispatchEvent(VersionActivity2_9Event.UnlockNextHalf)
	end
end

function var_0_0.refreshActivityState(arg_32_0, arg_32_1)
	if not ActivityHelper.isOpen(arg_32_1) then
		return
	end

	if arg_32_1 == VersionActivity2_9Enum.ActivityId.Dungeon2 then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Odyssey
		}, function()
			OdysseyTaskModel.instance:setTaskInfoList()
		end)
	elseif arg_32_1 == VersionActivity2_9Enum.ActivityId.EnterView2 then
		arg_32_0:tryTriggerGuide()
	end
end

function var_0_0.refreshReddot(arg_34_0)
	for iter_34_0, iter_34_1 in ipairs(arg_34_0.activityItemListWithGroup[arg_34_0.showGroupIndex]) do
		local var_34_0 = arg_34_0.reddotIconMap[iter_34_1.index]

		if not var_34_0 then
			var_34_0 = {
				goRedPoint = iter_34_1.goRedPoint,
				rootGo = iter_34_1.rootGo,
				reddotIcon = iter_34_1.goRedPoint and RedDotController.instance:getRedDotComp(iter_34_1.goRedPoint),
				customReddotIconGO = gohelper.findChild(iter_34_1.rootGo, "go_RedPoint")
			}
			arg_34_0.reddotIconMap[iter_34_1.index] = var_34_0
		end

		gohelper.setActive(var_34_0.goRedPoint, false)

		if var_34_0.reddotIcon then
			var_34_0.reddotIcon:defaultRefreshDot()
		end

		gohelper.setActive(var_34_0.customReddotIconGO, var_34_0.reddotIcon and var_34_0.reddotIcon.show)
	end

	arg_34_0:refreshLevelRewardEnterReddot()
end

function var_0_0.refreshLevelRewardEnterReddot(arg_35_0)
	local var_35_0 = arg_35_0.reddotIconMap[9]

	if not var_35_0 then
		return
	end

	local var_35_1 = gohelper.findChild(var_35_0.rootGo, "go_RedPoint1")
	local var_35_2 = OdysseyTaskModel.instance:checkHasLevelReawrdTaskCanGet()

	gohelper.setActive(var_35_1, var_35_2)
end

function var_0_0.getVersionActivityItem(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0.activityItemListWithGroup and arg_36_0.activityItemListWithGroup[arg_36_0.showGroupIndex]

	if var_36_0 then
		for iter_36_0, iter_36_1 in ipairs(var_36_0) do
			if iter_36_1.actId == arg_36_1 then
				return iter_36_1
			end
		end
	end
end

function var_0_0._onOpenView(arg_37_0, arg_37_1)
	if arg_37_1 ~= ViewName.VersionActivity2_9DungeonMapView and arg_37_1 ~= ViewName.OdysseyDungeonView then
		return
	end

	local var_37_0 = arg_37_0.showGroupIndex == 1 and "close_a" or "close_b"

	arg_37_0.animator:Play(var_37_0, 0, 0)
end

function var_0_0.refreshActivityItem(arg_38_0, arg_38_1)
	var_0_0.super.refreshActivityItem(arg_38_0, arg_38_1)

	if arg_38_1.txtRemainTime then
		arg_38_1.txtRemainTime.text = ActivityHelper.getActivityRemainTimeStr(arg_38_1.actId)
	end

	local var_38_0 = ActivityHelper.isOpen(arg_38_1.actId) and not arg_38_1.showTag

	gohelper.setActive(arg_38_1.goTime, var_38_0)
end

function var_0_0._playActTagAnimation(arg_39_0, arg_39_1)
	var_0_0.super._playActTagAnimation(arg_39_0, arg_39_1)

	local var_39_0 = ActivityHelper.isOpen(arg_39_1.actId) and not arg_39_1.showTag

	gohelper.setActive(arg_39_1.goTime, var_39_0)
end

function var_0_0.getLockText(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = var_0_0.super.getLockText(arg_40_0, arg_40_1, arg_40_2)

	if arg_40_2 == ActivityEnum.ActivityStatus.NotUnlock then
		var_40_0 = OpenHelper.getActivityUnlockTxt(arg_40_1.openId)
	end

	return var_40_0
end

function var_0_0.onOpenAnimationDone(arg_41_0)
	var_0_0.super.onOpenAnimationDone(arg_41_0)
	gohelper.setActive(arg_41_0._gojumpblock, false)
	arg_41_0:tryTriggerGuide()
end

function var_0_0.onClose(arg_42_0)
	CameraMgr.instance:setSceneCameraActive(true, var_0_0.UnitCameraKey)
	var_0_0.super.onClose(arg_42_0)
end

function var_0_0.beforePlayOpenAnimation(arg_43_0)
	local var_43_0 = arg_43_0.mainActIdList[arg_43_0.showGroupIndex]
	local var_43_1 = var_43_0 and arg_43_0.actId2OpenAudioDict[var_43_0]

	if var_43_1 and var_43_1 ~= 0 then
		AudioMgr.instance:trigger(var_43_1)
	end
end

function var_0_0._clickHome(arg_44_0)
	VersionActivity2_9EnterController.instance:clearLastEnterMainActId()
end

return var_0_0
