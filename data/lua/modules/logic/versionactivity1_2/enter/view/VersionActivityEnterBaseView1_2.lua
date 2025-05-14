module("modules.logic.versionactivity1_2.enter.view.VersionActivityEnterBaseView1_2", package.seeall)

local var_0_0 = class("VersionActivityEnterBaseView1_2", BaseView)

var_0_0.ShowActTagEnum = {
	ShowNewStage = 1,
	ShowNewAct = 0
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_time")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "logo/#txt_remaintime")
	arg_1_0._btnreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_replay")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreplay:AddClickListener(arg_2_0._btnReplayOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreplay:RemoveClickListener()
end

var_0_0.ActUnlockAnimationDuration = 2

function var_0_0._btnReplayOnClick(arg_4_0)
	local var_4_0 = ActivityModel.instance:getActMO(arg_4_0.actId)
	local var_4_1 = var_4_0 and var_4_0.config and var_4_0.config.storyId

	if not var_4_1 then
		logError(string.format("act id %s dot config story id", var_4_1))

		return
	end

	StoryController.instance:playStory(var_4_1, nil, nil, nil, {
		isVersionActivityPV = true
	})
end

function var_0_0.defaultCheckActivityCanClick(arg_5_0, arg_5_1)
	local var_5_0, var_5_1, var_5_2 = ActivityHelper.getActivityStatusAndToast(arg_5_1.actId)

	if var_5_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_5_1 then
			GameFacade.showToastWithTableParam(var_5_1, var_5_2)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end

	return true
end

function var_0_0._activityBtnOnClick(arg_6_0, arg_6_1)
	if arg_6_1.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	if not (arg_6_0["checkActivityCanClickFunc" .. arg_6_1.index] or arg_6_0.defaultCheckActivityCanClick)(arg_6_0, arg_6_1) then
		return
	end

	if arg_6_1.audioId then
		AudioMgr.instance:trigger(arg_6_1.audioId)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)
	end

	local var_6_0 = arg_6_0["onClickActivity" .. arg_6_1.index]

	if var_6_0 then
		var_6_0(arg_6_0)
	end
end

function var_0_0.initActivityItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0:getUserDataTb_()

	var_7_0.index = arg_7_1
	var_7_0.actId = arg_7_2
	var_7_0.rootGo = arg_7_3
	var_7_0.activityCo = ActivityConfig.instance:getActivityCo(arg_7_2)
	var_7_0.openId = var_7_0.activityCo and var_7_0.activityCo.openId
	var_7_0.redDotId = var_7_0.activityCo and var_7_0.activityCo.redDotId
	var_7_0.goNormal = gohelper.findChild(arg_7_3, "normal")
	var_7_0.imageNormal = gohelper.findChildImage(arg_7_3, "normal/bg")
	var_7_0.txtActivityName = gohelper.findChildText(arg_7_3, "normal/txt_actname")
	var_7_0.goLockContainer = gohelper.findChild(arg_7_3, "lockContainer")
	var_7_0.goDefaultLock = gohelper.findChild(arg_7_3, "lockContainer/go_defaultlock")
	var_7_0.txtLock = gohelper.findChildText(arg_7_3, "lockContainer/go_defaultlock/txt_lock")
	var_7_0.goLockSuo = gohelper.findChild(arg_7_3, "lockContainer/go_defaultlock/suo_icon")
	var_7_0.goRedPoint = gohelper.findChild(arg_7_3, "redpoint")
	var_7_0.goRedPointTag = gohelper.findChild(arg_7_3, "tag")
	var_7_0.goRedPointTagNewAct = gohelper.findChild(arg_7_3, "tag/new_act")
	var_7_0.goRedPointTagNewEpisode = gohelper.findChild(arg_7_3, "tag/new_episode")
	var_7_0.goTime = gohelper.findChild(arg_7_3, "timeContainer")
	var_7_0.txtTime = gohelper.findChildText(arg_7_3, "timeContainer/time")
	var_7_0.txtRemainTime = gohelper.findChildText(arg_7_3, "timeContainer/remain_time")
	var_7_0.click = gohelper.findChildClick(arg_7_3, "clickarea")

	var_7_0.click:AddClickListener(arg_7_0._activityBtnOnClick, arg_7_0, var_7_0)
	gohelper.setActive(var_7_0.goRedPointTag, true)
	gohelper.setActive(var_7_0.goRedPointTagNewAct, false)
	gohelper.setActive(var_7_0.goRedPointTagNewEpisode, false)
	gohelper.setActive(var_7_0.goDefaultLock, true)

	var_7_0.redPointTagAnimator = var_7_0.goRedPointTag and var_7_0.goRedPointTag:GetComponent(typeof(UnityEngine.Animator))

	return var_7_0
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.animator = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_8_0.activityGoContainerList = {}
	arg_8_0.activityItemList = {}
	arg_8_0.playedNewActTagAnimationIdList = nil

	arg_8_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_8_0.checkNeedRefreshUI, arg_8_0)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_8_0.checkNeedRefreshUI, arg_8_0)
	arg_8_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, arg_8_0.refreshAllNewActOpenTagUI, arg_8_0)
	arg_8_0:addEventCb(NavigateMgr.instance, NavigateEvent.BeforeClickHome, arg_8_0.beforeClickHome, arg_8_0)
	TaskDispatcher.runRepeat(arg_8_0.everyMinuteCall, arg_8_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.beforeClickHome(arg_9_0)
	arg_9_0.clickedHome = true
end

function var_0_0.checkNeedRefreshUI(arg_10_0)
	if not ViewHelper.instance:checkViewOnTheTop(arg_10_0.viewName) then
		return
	end

	if arg_10_0.clickedHome then
		return
	end

	arg_10_0:refreshUI()
	ActivityStageHelper.recordActivityStage(arg_10_0.activityIdList)
end

function var_0_0.initViewParam(arg_11_0)
	arg_11_0.actId = arg_11_0.viewParam.actId
	arg_11_0.skipOpenAnim = arg_11_0.viewParam.skipOpenAnim
	arg_11_0.activityIdList = arg_11_0.viewParam.activityIdList
end

function var_0_0.onUpdateParam(arg_12_0)
	arg_12_0:initViewParam()
	arg_12_0:refreshUI()
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0.onOpening = true

	arg_13_0:initViewParam()
	arg_13_0:initActivityNode()
	arg_13_0:initActivityItemList()
	arg_13_0:initActivityName()
	arg_13_0:refreshUI()
	arg_13_0:playOpenAnimation()
end

function var_0_0.initActivityNode(arg_14_0)
	local var_14_0

	for iter_14_0 = 1, #arg_14_0.activityIdList do
		local var_14_1 = arg_14_0.activityGoContainerList[iter_14_0]

		if not var_14_1 then
			local var_14_2 = string.format("entrance/activityContainer%s/act", iter_14_0)

			var_14_1 = gohelper.findChild(arg_14_0.viewGO, var_14_2)

			if gohelper.isNil(var_14_1) then
				logError("not found container node : entrance/activityContainer" .. iter_14_0)
			end

			table.insert(arg_14_0.activityGoContainerList, var_14_1)
		end

		gohelper.setActive(var_14_1, true)
	end

	for iter_14_1 = #arg_14_0.activityIdList + 1, #arg_14_0.activityGoContainerList do
		gohelper.setActive(arg_14_0.activityGoContainerList[iter_14_1], false)
	end
end

function var_0_0.initActivityItemList(arg_15_0)
	for iter_15_0 = 1, #arg_15_0.activityIdList do
		table.insert(arg_15_0.activityItemList, arg_15_0:initActivityItem(iter_15_0, arg_15_0.activityIdList[iter_15_0], arg_15_0.activityGoContainerList[iter_15_0]))
	end
end

function var_0_0.initActivityName(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.activityItemList) do
		iter_16_1.txtActivityName.text = iter_16_1.activityCo.name
	end
end

function var_0_0.getVersionActivityItem(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.activityItemList) do
		if iter_17_1.actId == arg_17_1 then
			return iter_17_1
		end
	end
end

function var_0_0.playOpenAnimation(arg_18_0)
	if arg_18_0.skipOpenAnim then
		arg_18_0.animator:Play(UIAnimationName.Idle)

		arg_18_0.onOpening = false
	else
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(arg_18_0.viewName .. "playOpenAnimation")
		AudioMgr.instance:trigger(AudioEnum.VersionActivity1_2.play_ui_lvhu_open)
		arg_18_0.animator:Play(UIAnimationName.Open)
		TaskDispatcher.runDelay(arg_18_0.onOpenAnimationDone, arg_18_0, 2.167)
	end
end

function var_0_0.refreshUI(arg_19_0)
	arg_19_0:refreshCenterActUI()
	arg_19_0:refreshActivityUI()
end

function var_0_0.refreshCenterActUI(arg_20_0)
	local var_20_0 = ActivityModel.instance:getActivityInfo()[arg_20_0.actId]

	if arg_20_0._txttime then
		if LangSettings.instance:isEn() then
			arg_20_0._txttime.text = string.format("<color=#578425>%s ~ %s</color>", var_20_0:getStartTimeStr(), var_20_0:getEndTimeStr())
		else
			arg_20_0._txttime.text = string.format("<color=#578425>%s ~ %s(UTC+8)</color>", var_20_0:getStartTimeStr(), var_20_0:getEndTimeStr())
		end
	end

	if arg_20_0._txtremaintime then
		local var_20_1 = var_20_0:getRealEndTimeStamp() - ServerTime.now()
		local var_20_2 = Mathf.Floor(var_20_1 / TimeUtil.OneDaySecond)
		local var_20_3 = var_20_1 % TimeUtil.OneDaySecond
		local var_20_4 = Mathf.Floor(var_20_3 / TimeUtil.OneHourSecond)
		local var_20_5 = var_20_2 .. luaLang("time_day") .. var_20_4 .. luaLang("time_hour2")

		if LangSettings.instance:isEn() then
			var_20_5 = var_20_2 .. luaLang("time_day") .. " " .. var_20_4 .. luaLang("time_hour2")
		end

		arg_20_0._txtremaintime.text = string.format(luaLang("remain"), var_20_5)
	end
end

function var_0_0.refreshActivityUI(arg_21_0)
	arg_21_0.playedActTagAudio = false
	arg_21_0.playedActUnlockAudio = false

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.activityItemList) do
		arg_21_0:refreshActivityItem(iter_21_1)
	end
end

function var_0_0.defaultBeforePlayActUnlockAnimation(arg_22_0, arg_22_1)
	local var_22_0 = gohelper.findChild(arg_22_1.rootGo, "lockContainer/go_defaultlock/circle")

	gohelper.setActive(var_22_0, false)
	gohelper.setActive(arg_22_1.txtLock.gameObject, false)
	gohelper.setActive(arg_22_1.goLockContainer, true)
	gohelper.setActive(arg_22_1.goDefaultLock, true)
end

function var_0_0.refreshActivityItem(arg_23_0, arg_23_1)
	if arg_23_1.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	local var_23_0 = ActivityHelper.getActivityStatus(arg_23_1.actId)

	logNormal("act id : " .. arg_23_1.actId .. ", status : " .. var_23_0)

	local var_23_1 = var_23_0 == ActivityEnum.ActivityStatus.Normal

	if var_23_1 and not VersionActivityBaseController.instance:isPlayedUnlockAnimation(arg_23_1.actId) then
		arg_23_1.lockAnimator = arg_23_1.goDefaultLock and arg_23_1.goDefaultLock:GetComponent(typeof(UnityEngine.Animator))

		if arg_23_1.lockAnimator then
			(arg_23_0["beforePlayActUnlockAnimationActivity" .. arg_23_1.index] or arg_23_0.defaultBeforePlayActUnlockAnimation)(arg_23_0, arg_23_1)
			arg_23_0:playActUnlockAnimation(arg_23_1)
		else
			arg_23_0:refreshLockUI(arg_23_1, var_23_0)
		end
	else
		arg_23_0:refreshLockUI(arg_23_1, var_23_0)
	end

	arg_23_0:refreshTimeContainer(arg_23_1, var_23_0)
	arg_23_0:refreshRedDotContainer(arg_23_1, var_23_1)

	local var_23_2 = arg_23_0["onRefreshActivity" .. arg_23_1.index]

	if var_23_2 then
		var_23_2(arg_23_0, arg_23_1)
	end
end

function var_0_0.refreshLockUI(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_2 == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_24_1.goLockContainer, not var_24_0)
	gohelper.setActive(arg_24_1.goLockSuo, arg_24_2 == ActivityEnum.ActivityStatus.NotOpen or arg_24_2 == ActivityEnum.ActivityStatus.NotUnlock)

	if not var_24_0 and arg_24_1.txtLock then
		local var_24_1 = ""

		if arg_24_2 == ActivityEnum.ActivityStatus.NotOpen then
			local var_24_2 = ActivityModel.instance:getActivityInfo()[arg_24_1.actId]

			var_24_1 = string.format(luaLang("test_task_unlock_time"), var_24_2:getRemainTimeStr2ByOpenTime())
		elseif arg_24_2 == ActivityEnum.ActivityStatus.Expired then
			var_24_1 = luaLang("p_activityenter_finish")
		elseif arg_24_2 == ActivityEnum.ActivityStatus.NotUnlock then
			var_24_1 = luaLang("p_versionactivitytripenter_lock")
		elseif arg_24_2 == ActivityEnum.ActivityStatus.NotOnLine then
			var_24_1 = luaLang("p_activityenter_finish")
		elseif arg_24_2 == ActivityEnum.ActivityStatus.None then
			var_24_1 = luaLang("p_activityenter_finish")
		end

		arg_24_1.txtLock.text = var_24_1
	end
end

function var_0_0.refreshTimeContainer(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_2 == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_25_1.goTime, var_25_0)

	if not var_25_0 then
		return
	end

	local var_25_1 = ActivityModel.instance:getActivityInfo()[arg_25_1.actId]

	if arg_25_1.txtTime then
		arg_25_1.txtTime.text = var_25_1:getStartTimeStr() .. "~" .. var_25_1:getEndTimeStr()
	end

	if arg_25_1.txtRemainTime then
		if var_25_0 then
			arg_25_1.txtRemainTime.text = string.format(luaLang("remain"), var_25_1:getRemainTimeStr2ByEndTime())
		else
			arg_25_1.txtRemainTime.text = ""
		end
	end
end

function var_0_0.refreshRedDotContainer(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_2 and arg_26_1.redDotId and arg_26_1.redDotId ~= 0 then
		RedDotController.instance:addRedDot(arg_26_1.goRedPoint, arg_26_1.redDotId)
	end

	arg_26_0:refreshRedDotTag(arg_26_1, arg_26_2)
end

function var_0_0.refreshRedDotTag(arg_27_0, arg_27_1, arg_27_2)
	gohelper.setActive(arg_27_1.goRedPointTag, arg_27_2)
	gohelper.setActive(arg_27_1.goRedPointTagNewAct, false)
	gohelper.setActive(arg_27_1.goRedPointTagNewEpisode, false)

	arg_27_1.showTag = nil

	if arg_27_2 then
		if not ActivityEnterMgr.instance:isEnteredActivity(arg_27_1.actId) then
			arg_27_1.showTag = var_0_0.ShowActTagEnum.ShowNewAct

			arg_27_0:playActTagAnimation(arg_27_1)
		elseif ActivityModel.instance:getActivityInfo()[arg_27_1.actId]:isNewStageOpen() then
			arg_27_1.showTag = var_0_0.ShowActTagEnum.ShowNewStage

			arg_27_0:playActTagAnimation(arg_27_1)
		end
	end
end

function var_0_0.refreshAllNewActOpenTagUI(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.activityItemList) do
		local var_28_0 = ActivityHelper.getActivityStatus(iter_28_1.actId) == ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(iter_28_1.goRedPointTag, var_28_0)
		gohelper.setActive(iter_28_1.goRedPointTagNewAct, var_28_0 and not ActivityEnterMgr.instance:isEnteredActivity(iter_28_1.actId))
	end
end

function var_0_0.isPlayedActTagAnimation(arg_29_0, arg_29_1)
	if not arg_29_0.playedNewActTagAnimationIdList then
		return false
	end

	return tabletool.indexOf(arg_29_0.playedNewActTagAnimationIdList, arg_29_1)
end

function var_0_0.playActTagAnimation(arg_30_0, arg_30_1)
	if arg_30_0.onOpening or arg_30_0.playingUnlockAnimation then
		arg_30_0.needPlayNewActTagActIdList = arg_30_0.needPlayNewActTagActIdList or {}

		if not tabletool.indexOf(arg_30_0.needPlayNewActTagActIdList, arg_30_1.actId) then
			table.insert(arg_30_0.needPlayNewActTagActIdList, arg_30_1.actId)
		end
	else
		arg_30_0:_playActTagAnimation(arg_30_1)
	end
end

function var_0_0._playActTagAnimation(arg_31_0, arg_31_1)
	if arg_31_1.showTag == var_0_0.ShowActTagEnum.ShowNewAct then
		gohelper.setActive(arg_31_1.goRedPointTagNewAct, true)
	elseif arg_31_1.showTag == var_0_0.ShowActTagEnum.ShowNewStage then
		gohelper.setActive(arg_31_1.goRedPointTagNewEpisode, true)
	end

	arg_31_0.playedNewActTagAnimationIdList = arg_31_0.playedNewActTagAnimationIdList or {}

	if not arg_31_1.redPointTagAnimator then
		table.insert(arg_31_0.playedNewActTagAnimationIdList, arg_31_1.actId)

		return
	end

	if not arg_31_0:isPlayedActTagAnimation(arg_31_1.actId) then
		arg_31_1.redPointTagAnimator:Play(UIAnimationName.Open)
		table.insert(arg_31_0.playedNewActTagAnimationIdList, arg_31_1.actId)

		if not arg_31_0.playedActTagAudio then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_open)

			arg_31_0.playedActTagAudio = true
		end
	end
end

function var_0_0.playActUnlockAnimation(arg_32_0, arg_32_1)
	if arg_32_0.onOpening then
		arg_32_0.needPlayUnlockAnimationActIdList = arg_32_0.needPlayUnlockAnimationActIdList or {}

		if not tabletool.indexOf(arg_32_0.needPlayUnlockAnimationActIdList, arg_32_1.actId) then
			table.insert(arg_32_0.needPlayUnlockAnimationActIdList, arg_32_1.actId)
		end
	else
		arg_32_0:_playActUnlockAnimation(arg_32_1)
	end
end

function var_0_0._playActUnlockAnimation(arg_33_0, arg_33_1)
	if not arg_33_1 then
		return
	end

	VersionActivityBaseController.instance:playedActivityUnlockAnimation(arg_33_1.actId)

	if arg_33_1.lockAnimator then
		arg_33_1.lockAnimator:Play(UIAnimationName.Open, 0, 0)
		arg_33_0:playTimeUnlock(arg_33_1)

		if not arg_33_0.playedActUnlockAudio then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_2.play_ui_lvhu_level_unlock)

			arg_33_0.playedActUnlockAudio = true
		end

		arg_33_0.playingUnlockAnimation = true

		TaskDispatcher.runDelay(arg_33_0.playUnlockAnimationDone, arg_33_0, var_0_0.ActUnlockAnimationDuration)
	end
end

function var_0_0.playTimeUnlock(arg_34_0, arg_34_1)
	arg_34_1.timeAnimator = arg_34_1.goTime and arg_34_1.goTime:GetComponent(typeof(UnityEngine.Animator))

	if arg_34_1.timeAnimator then
		arg_34_0.needPlayTimeUnlockList = arg_34_0.needPlayTimeUnlockList or {}

		if not tabletool.indexOf(arg_34_0.needPlayTimeUnlockList, arg_34_1) then
			table.insert(arg_34_0.needPlayTimeUnlockList, arg_34_1)
		end
	end
end

function var_0_0.playAllTimeUnlockAnimation(arg_35_0)
	if arg_35_0.needPlayTimeUnlockList then
		for iter_35_0, iter_35_1 in ipairs(arg_35_0.needPlayTimeUnlockList) do
			if iter_35_1.timeAnimator then
				gohelper.setActive(iter_35_1.goTime, true)
				iter_35_1.timeAnimator:Play(UIAnimationName.Open, 0, 0)
			end
		end
	end
end

function var_0_0.playUnlockAnimationDone(arg_36_0)
	arg_36_0.playingUnlockAnimation = false

	arg_36_0:playAllTimeUnlockAnimation()
	arg_36_0:playAllNewTagAnimation()
end

function var_0_0.onOpenAnimationDone(arg_37_0)
	UIBlockMgr.instance:endBlock(arg_37_0.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)

	arg_37_0.onOpening = false

	if not ViewHelper.instance:checkViewOnTheTop(arg_37_0.viewName) then
		arg_37_0.needPlayUnlockAnimationActIdList = nil

		return
	end

	if arg_37_0.needPlayUnlockAnimationActIdList then
		for iter_37_0, iter_37_1 in ipairs(arg_37_0.needPlayUnlockAnimationActIdList) do
			arg_37_0:_playActUnlockAnimation(arg_37_0:getVersionActivityItem(iter_37_1))
		end

		arg_37_0.needPlayUnlockAnimationActIdList = nil
	end

	if not arg_37_0.playingUnlockAnimation then
		arg_37_0:playAllNewTagAnimation()
	end
end

function var_0_0.playAllNewTagAnimation(arg_38_0)
	if arg_38_0.needPlayNewActTagActIdList then
		for iter_38_0, iter_38_1 in ipairs(arg_38_0.needPlayNewActTagActIdList) do
			arg_38_0:_playActTagAnimation(arg_38_0:getVersionActivityItem(iter_38_1))
		end

		arg_38_0.needPlayNewActTagActIdList = nil
	end
end

function var_0_0.everyMinuteCall(arg_39_0)
	if not ViewHelper.instance:checkViewOnTheTop(arg_39_0.viewName) then
		return
	end

	arg_39_0:refreshUI()
end

function var_0_0.onClose(arg_40_0)
	UIBlockMgr.instance:endBlock(arg_40_0.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(arg_40_0.everyMinuteCall, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.onOpenAnimationDone, arg_40_0)
	TaskDispatcher.cancelTask(arg_40_0.playUnlockAnimationDone, arg_40_0)
end

function var_0_0.onDestroyView(arg_41_0)
	for iter_41_0, iter_41_1 in ipairs(arg_41_0.activityItemList) do
		iter_41_1.click:RemoveClickListener()
	end
end

return var_0_0
