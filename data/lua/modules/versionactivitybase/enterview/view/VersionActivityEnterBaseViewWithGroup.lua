module("modules.versionactivitybase.enterview.view.VersionActivityEnterBaseViewWithGroup", package.seeall)

local var_0_0 = class("VersionActivityEnterBaseViewWithGroup", BaseView)

var_0_0.ShowActTagEnum = {
	ShowNewStage = 1,
	ShowNewAct = 0
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "entrance/#btn_replay")
	arg_1_0._goGroupController = gohelper.findChild(arg_1_0.viewGO, "entrance/#go_groupController")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreplay:AddClickListener(arg_2_0._btnReplayOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreplay:RemoveClickListener()
end

var_0_0.ActUnlockAnimationDuration = 2.5

function var_0_0._btnReplayOnClick(arg_4_0)
	local var_4_0 = ActivityModel.instance:getActMO(arg_4_0.actId)
	local var_4_1 = var_4_0 and var_4_0.config and var_4_0.config.storyId

	if not var_4_1 then
		logError(string.format("act id %s dot config story id", var_4_1))

		return
	end

	local var_4_2 = {}

	var_4_2.isVersionActivityPV = true

	StoryController.instance:playStory(var_4_1, var_4_2)
end

function var_0_0.onClickGroupBtn(arg_5_0, arg_5_1)
	if arg_5_1.groupIndex == arg_5_0.showGroupIndex then
		return
	end

	local var_5_0 = arg_5_0.mainActIdList[arg_5_1.groupIndex]
	local var_5_1, var_5_2, var_5_3 = ActivityHelper.getActivityStatusAndToast(var_5_0)

	if var_5_1 ~= ActivityEnum.ActivityStatus.Normal then
		if var_5_1 == ActivityEnum.ActivityStatus.NotOpen then
			local var_5_4 = ActivityModel.instance:getActMO(var_5_0)
			local var_5_5 = var_5_4:getRealStartTimeStamp() - ServerTime.now()
			local var_5_6 = var_5_4.config.name
			local var_5_7 = TimeUtil.getFormatTime(var_5_5)

			GameFacade.showToast(ToastEnum.V1a4_ActPreTips, var_5_6, var_5_7)
		elseif var_5_2 then
			GameFacade.showToastWithTableParam(var_5_2, var_5_3)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return
	end

	arg_5_0.showGroupIndex = arg_5_1.groupIndex

	local var_5_8 = arg_5_0.showGroupIndex == 1 and "switch_b" or "switch_a"

	arg_5_0.animator:Play(var_5_8, 0, 0)
	arg_5_0:beforeClickGroupBtn()
	arg_5_0:refreshGroupBtnUI()
end

function var_0_0.defaultCheckActivityCanClick(arg_6_0, arg_6_1)
	local var_6_0, var_6_1, var_6_2 = ActivityHelper.getActivityStatusAndToast(arg_6_1.actId)

	if var_6_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_6_1 then
			GameFacade.showToastWithTableParam(var_6_1, var_6_2)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end

	return true
end

function var_0_0._activityBtnOnClick(arg_7_0, arg_7_1)
	if arg_7_1.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	if not (arg_7_0["checkActivityCanClickFunc" .. arg_7_1.index] or arg_7_0.defaultCheckActivityCanClick)(arg_7_0, arg_7_1) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)

	local var_7_0 = arg_7_0["onClickActivity" .. arg_7_1.actId] or arg_7_0["onClickActivity" .. arg_7_1.index]

	if var_7_0 then
		var_7_0(arg_7_0)
	end
end

function var_0_0.initActivityItem(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = arg_8_0:getUserDataTb_()

	var_8_0.groupIndex = arg_8_1
	var_8_0.index = arg_8_2
	var_8_0.actId = arg_8_3
	var_8_0.rootGo = arg_8_4

	local var_8_1 = ActivityConfig.instance:getActivityCo(arg_8_3)

	var_8_0.openId = var_8_1 and var_8_1.openId
	var_8_0.redDotId = var_8_1 and var_8_1.redDotId
	var_8_0.animator = var_8_0.rootGo:GetComponent(typeof(UnityEngine.Animator))
	var_8_0.goNormal = gohelper.findChild(arg_8_4, "normal")
	var_8_0.goNormalAnimator = var_8_0.goNormal:GetComponent(typeof(UnityEngine.Animator))

	if var_8_0.goNormalAnimator then
		var_8_0.goNormalAnimator.enabled = false
	end

	local var_8_2 = VersionActivityEnum.EnterViewNormalAnimationPath[arg_8_3]

	if var_8_2 then
		local var_8_3 = gohelper.findChild(arg_8_4, var_8_2)

		if var_8_3 then
			var_8_0.normalAnimation = var_8_3:GetComponent(typeof(UnityEngine.Animation))
		end
	end

	var_8_0.goLockContainer = gohelper.findChild(arg_8_4, "lockContainer")
	var_8_0.txtLockGo = gohelper.findChild(arg_8_4, "lockContainer/lock")
	var_8_0.txtLock = gohelper.findChildText(arg_8_4, "lockContainer/lock/txt_lock")
	var_8_0.goRedPoint = gohelper.findChild(arg_8_4, "redpoint")
	var_8_0.goRedPointTag = gohelper.findChild(arg_8_4, "tag")
	var_8_0.goRedPointTagNewAct = gohelper.findChild(arg_8_4, "tag/new_act")
	var_8_0.goRedPointTagNewEpisode = gohelper.findChild(arg_8_4, "tag/new_episode")
	var_8_0.goTime = gohelper.findChild(arg_8_4, "timeContainer")
	var_8_0.txtTime = gohelper.findChildText(arg_8_4, "timeContainer/time")
	var_8_0.txtRemainTime = gohelper.findChildText(arg_8_4, "timeContainer/TimeBG/remain_time")
	var_8_0.click = SLFramework.UGUI.ButtonWrap.Get(arg_8_4)

	local var_8_4 = gohelper.findChild(arg_8_4, "clickarea")

	gohelper.setActive(var_8_4, false)
	var_8_0.click:AddClickListener(arg_8_0._activityBtnOnClick, arg_8_0, var_8_0)
	gohelper.setActive(var_8_0.goRedPointTag, true)
	gohelper.setActive(var_8_0.goRedPointTagNewAct, false)
	gohelper.setActive(var_8_0.goRedPointTagNewEpisode, false)

	var_8_0.redPointTagAnimator = var_8_0.goRedPointTag and var_8_0.goRedPointTag:GetComponent(typeof(UnityEngine.Animator))

	return var_8_0
end

function var_0_0.createGroupBtnItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getUserDataTb_()

	var_9_0.groupIndex = arg_9_1
	var_9_0.goGroup = gohelper.findChild(arg_9_0._goGroupController, "tab" .. arg_9_1)

	if gohelper.isNil(var_9_0.goGroup) then
		logError("not found btn group : " .. tostring(arg_9_1))

		return
	end

	var_9_0.click = gohelper.getClick(var_9_0.goGroup)
	var_9_0.goNormal = gohelper.findChild(var_9_0.goGroup, "go_normal")
	var_9_0.goSelect = gohelper.findChild(var_9_0.goGroup, "go_select")
	var_9_0.goRedDot = gohelper.findChild(var_9_0.goGroup, "go_reddot")

	var_9_0.click:AddClickListener(arg_9_0.onClickGroupBtn, arg_9_0, var_9_0)

	return var_9_0
end

function var_0_0.initBtnGroup(arg_10_0)
	arg_10_0.groupItemList = {}

	for iter_10_0 = 1, 2 do
		table.insert(arg_10_0.groupItemList, arg_10_0:createGroupBtnItem(iter_10_0))
	end
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0.animator = arg_11_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_11_0.activityGoContainerList = arg_11_0:getUserDataTb_()
	arg_11_0.activityItemListWithGroup = {}
	arg_11_0.groupGoList = arg_11_0:getUserDataTb_()
	arg_11_0.showGroupIndex = 0
	arg_11_0.playedNewActTagAnimationIdList = nil
	arg_11_0.animEventWrap = arg_11_0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	arg_11_0.animEventWrap:AddEventListener("refreshUI", arg_11_0.onSwitchGroup, arg_11_0)
	arg_11_0:initBtnGroup()
	arg_11_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_11_0.checkNeedRefreshUI, arg_11_0)
	arg_11_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_11_0.onCloseViewFinish, arg_11_0)
	arg_11_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_11_0.onOpenViewFinish, arg_11_0)
	arg_11_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, arg_11_0.refreshAllNewActOpenTagUI, arg_11_0)
	arg_11_0:addEventCb(NavigateMgr.instance, NavigateEvent.BeforeClickHome, arg_11_0.beforeClickHome, arg_11_0)
	TaskDispatcher.runRepeat(arg_11_0.everyMinuteCall, arg_11_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.onCloseViewFinish(arg_12_0)
	arg_12_0:checkNeedRefreshUI()

	if ViewHelper.instance:checkViewOnTheTop(arg_12_0.viewName) then
		arg_12_0:playAmbientAudio()
	end
end

function var_0_0.onOpenViewFinish(arg_13_0)
	if not ViewHelper.instance:checkViewOnTheTop(arg_13_0.viewName) then
		arg_13_0:stopAmbientAudio()
	end
end

function var_0_0.beforeClickHome(arg_14_0)
	arg_14_0.clickedHome = true
end

function var_0_0.checkNeedRefreshUI(arg_15_0)
	if not ViewHelper.instance:checkViewOnTheTop(arg_15_0.viewName) then
		return
	end

	if arg_15_0.clickedHome then
		return
	end

	arg_15_0:refreshUI()
	ActivityStageHelper.recordActivityStage(arg_15_0.activityIdListWithGroup[arg_15_0.mainActIdList[arg_15_0.showGroupIndex]])
end

function var_0_0.initViewParam(arg_16_0)
	arg_16_0.actId = arg_16_0.viewParam.actId
	arg_16_0.skipOpenAnim = arg_16_0.viewParam.skipOpenAnim
	arg_16_0.activityIdListWithGroup = arg_16_0.viewParam.activityIdListWithGroup
	arg_16_0.mainActIdList = arg_16_0.viewParam.mainActIdList
	arg_16_0.actId2AmbientDict = arg_16_0.viewParam.actId2AmbientDict
	arg_16_0.actId2OpenAudioDict = arg_16_0.viewParam.actId2OpenAudioDict

	arg_16_0:initGroupIndex()
end

function var_0_0.initGroupIndex(arg_17_0)
	for iter_17_0 = #arg_17_0.mainActIdList, 1, -1 do
		if ActivityHelper.getActivityStatus(arg_17_0.mainActIdList[iter_17_0]) == ActivityEnum.ActivityStatus.Normal then
			arg_17_0.showGroupIndex = iter_17_0

			return
		end
	end

	logError("一个活动都没解锁？")

	arg_17_0.showGroupIndex = 1
end

function var_0_0.onUpdateParam(arg_18_0)
	arg_18_0:initViewParam()
	arg_18_0:refreshUI()
end

function var_0_0.onOpen(arg_19_0)
	arg_19_0.onOpening = true

	arg_19_0:initViewParam()
	arg_19_0:initActivityNode()
	arg_19_0:initActivityItemList()
	arg_19_0:refreshUI()
	arg_19_0:playOpenAnimation()
	arg_19_0:playBgm()
	arg_19_0:playAmbientAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_switch)
end

function var_0_0.initActivityNode(arg_20_0)
	for iter_20_0 = 1, 2 do
		local var_20_0 = gohelper.findChild(arg_20_0.viewGO, "entrance/#go_group" .. iter_20_0)

		if gohelper.isNil(var_20_0) then
			logError("not found group node : entrance/#go_group" .. iter_20_0)
		end

		table.insert(arg_20_0.groupGoList, var_20_0)
	end

	local var_20_1 = 0

	for iter_20_1, iter_20_2 in ipairs(arg_20_0.mainActIdList) do
		local var_20_2 = arg_20_0.groupGoList[iter_20_1]
		local var_20_3 = arg_20_0.activityIdListWithGroup[iter_20_2]

		for iter_20_3 = 1, #var_20_3 do
			var_20_1 = var_20_1 + 1

			local var_20_4 = gohelper.findChild(var_20_2, "activityContainer" .. var_20_1)

			if gohelper.isNil(var_20_4) then
				logError(string.format("not found container node : %s/activityContainer%s", var_20_2.name, var_20_1))
			end

			table.insert(arg_20_0.activityGoContainerList, var_20_4)
		end
	end
end

function var_0_0.initActivityItemList(arg_21_0)
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.mainActIdList) do
		local var_21_1 = arg_21_0.activityIdListWithGroup[iter_21_1]
		local var_21_2 = arg_21_0.activityItemListWithGroup[iter_21_0]

		if var_21_2 == nil then
			var_21_2 = {}
			arg_21_0.activityItemListWithGroup[iter_21_0] = var_21_2
		end

		for iter_21_2, iter_21_3 in ipairs(var_21_1) do
			var_21_0 = var_21_0 + 1

			table.insert(var_21_2, arg_21_0:initActivityItem(iter_21_0, var_21_0, iter_21_3, arg_21_0.activityGoContainerList[var_21_0]))
		end
	end
end

function var_0_0.getVersionActivityItem(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.activityItemListWithGroup) do
		for iter_22_2, iter_22_3 in ipairs(iter_22_1) do
			if iter_22_3.actId == arg_22_1 then
				return iter_22_3
			end
		end
	end
end

function var_0_0.playOpenAnimation(arg_23_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(arg_23_0.viewName .. "playOpenAnimation")

	if arg_23_0.skipOpenAnim then
		arg_23_0.animator:Play(UIAnimationName.Idle)
		TaskDispatcher.runDelay(arg_23_0.onOpenAnimationDone, arg_23_0, 0.5)
	else
		arg_23_0:beforePlayOpenAnimation()

		local var_23_0 = arg_23_0.showGroupIndex == 1 and "open_a" or "open_b"

		arg_23_0.animator:Play(var_23_0, 0, 0)
		TaskDispatcher.runDelay(arg_23_0.onOpenAnimationDone, arg_23_0, 2.167)
	end
end

function var_0_0.refreshUI(arg_24_0)
	arg_24_0:refreshCenterActUI()
	arg_24_0:refreshActivityUI()
end

function var_0_0.refreshCenterActUI(arg_25_0)
	arg_25_0:refreshSingleBgUI()
	arg_25_0:refreshGroupBtnUI()
end

function var_0_0.refreshSingleBgUI(arg_26_0)
	return
end

function var_0_0.refreshGroupBtnUI(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.groupItemList) do
		gohelper.setActive(iter_27_1.goNormal, arg_27_0.showGroupIndex ~= iter_27_1.groupIndex)
		gohelper.setActive(iter_27_1.goSelect, arg_27_0.showGroupIndex == iter_27_1.groupIndex)

		local var_27_0 = arg_27_0.mainActIdList[iter_27_0]

		if ActivityHelper.getActivityStatus(var_27_0) == ActivityEnum.ActivityStatus.Normal and not iter_27_1.redDotComp then
			local var_27_1 = ActivityConfig.instance:getActivityCo(var_27_0)

			iter_27_1.redDotComp = RedDotController.instance:addRedDot(iter_27_1.goRedDot, var_27_1.redDotId)
		end
	end
end

function var_0_0.refreshActivityUI(arg_28_0)
	arg_28_0.playedActTagAudio = false
	arg_28_0.playedActUnlockAudio = false

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.groupGoList) do
		gohelper.setActive(iter_28_1, iter_28_0 == arg_28_0.showGroupIndex)
	end

	for iter_28_2, iter_28_3 in ipairs(arg_28_0.activityItemListWithGroup[arg_28_0.showGroupIndex]) do
		arg_28_0:refreshActivityItem(iter_28_3)
	end
end

function var_0_0.defaultBeforePlayActUnlockAnimation(arg_29_0, arg_29_1)
	gohelper.setActive(arg_29_1.goTime, false)
	gohelper.setActive(arg_29_1.goLockContainer, true)

	if arg_29_1.txtLockGo then
		gohelper.setActive(arg_29_1.txtLockGo, false)
	end
end

function var_0_0.refreshActivityItem(arg_30_0, arg_30_1)
	if arg_30_1.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	local var_30_0 = ActivityHelper.getActivityStatus(arg_30_1.actId)

	logNormal("act id : " .. arg_30_1.actId .. ", status : " .. var_30_0)

	local var_30_1 = var_30_0 == ActivityEnum.ActivityStatus.Normal
	local var_30_2 = ActivityModel.instance:getActivityInfo()[arg_30_1.actId]

	if arg_30_1.normalAnimation then
		arg_30_1.normalAnimation.enabled = var_30_1
	end

	if var_30_1 and not VersionActivityBaseController.instance:isPlayedUnlockAnimation(arg_30_1.actId) then
		arg_30_1.lockAnimator = arg_30_1.goLockContainer and arg_30_1.goLockContainer:GetComponent(typeof(UnityEngine.Animator))

		if not arg_30_1.lockAnimator then
			arg_30_0:refreshLockUI(arg_30_1, var_30_0)
		else
			(arg_30_0["beforePlayActUnlockAnimationActivity" .. arg_30_1.index] or arg_30_0.defaultBeforePlayActUnlockAnimation)(arg_30_0, arg_30_1)
			arg_30_0:playActUnlockAnimation(arg_30_1)
		end
	else
		arg_30_0:refreshLockUI(arg_30_1, var_30_0)
	end

	if arg_30_1.animator then
		if var_30_0 == ActivityEnum.ActivityStatus.Normal then
			arg_30_1.animator:Play(UIAnimationName.Loop)
		else
			arg_30_1.animator:Play(UIAnimationName.Idle)
		end
	end

	if arg_30_1.txtTime then
		arg_30_1.txtTime.text = var_30_2:getStartTimeStr() .. "~" .. var_30_2:getEndTimeStr()
	end

	if arg_30_1.txtRemainTime then
		if var_30_0 == ActivityEnum.ActivityStatus.Normal then
			arg_30_1.txtRemainTime.text = string.format(luaLang("remain"), var_30_2:getRemainTimeStr2ByEndTime())
		else
			arg_30_1.txtRemainTime.text = ""
		end
	end

	if var_30_1 and arg_30_1.redDotId and arg_30_1.redDotId ~= 0 and not gohelper.isNil(arg_30_1.goRedPoint) then
		RedDotController.instance:addRedDot(arg_30_1.goRedPoint, arg_30_1.redDotId)
	end

	gohelper.setActive(arg_30_1.goRedPointTag, var_30_1)
	gohelper.setActive(arg_30_1.goRedPointTagNewAct, false)
	gohelper.setActive(arg_30_1.goRedPointTagNewEpisode, false)

	arg_30_1.showTag = nil

	if var_30_1 then
		if not ActivityEnterMgr.instance:isEnteredActivity(arg_30_1.actId) then
			arg_30_1.showTag = var_0_0.ShowActTagEnum.ShowNewAct

			arg_30_0:playActTagAnimation(arg_30_1)
		elseif var_30_2:isNewStageOpen() then
			arg_30_1.showTag = var_0_0.ShowActTagEnum.ShowNewStage

			arg_30_0:playActTagAnimation(arg_30_1)
		end
	end

	local var_30_3 = arg_30_0["onRefreshActivity" .. arg_30_1.index]

	if var_30_3 then
		var_30_3(arg_30_0, arg_30_1)
	end
end

function var_0_0.refreshLockUI(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_2 == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(arg_31_1.goLockContainer, not var_31_0)
	gohelper.setActive(arg_31_1.txtLockGo, not var_31_0)
	gohelper.setActive(arg_31_1.goTime, var_31_0)

	if not var_31_0 and arg_31_1.txtLock then
		local var_31_1 = arg_31_0["getLockTextFunc" .. arg_31_1.index] or arg_31_0.getLockText

		arg_31_1.txtLock.text = var_31_1(arg_31_0, arg_31_1, arg_31_2)
	end
end

function var_0_0.getLockText(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = ActivityModel.instance:getActivityInfo()[arg_32_1.actId]
	local var_32_1

	if arg_32_2 == ActivityEnum.ActivityStatus.NotOpen then
		var_32_1 = string.format(luaLang("test_task_unlock_time"), var_32_0:getRemainTimeStr2ByOpenTime())
	elseif arg_32_2 == ActivityEnum.ActivityStatus.Expired then
		var_32_1 = luaLang("p_activityenter_finish")
	elseif arg_32_2 == ActivityEnum.ActivityStatus.NotUnlock then
		var_32_1 = luaLang("p_versionactivitytripenter_lock")
	elseif arg_32_2 == ActivityEnum.ActivityStatus.NotOnLine then
		var_32_1 = luaLang("p_activityenter_finish")
	elseif arg_32_2 == ActivityEnum.ActivityStatus.None then
		var_32_1 = luaLang("p_activityenter_finish")
	end

	return var_32_1
end

function var_0_0.refreshAllNewActOpenTagUI(arg_33_0)
	for iter_33_0, iter_33_1 in ipairs(arg_33_0.activityItemListWithGroup[arg_33_0.showGroupIndex]) do
		local var_33_0 = ActivityHelper.getActivityStatus(iter_33_1.actId) == ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(iter_33_1.goRedPointTag, var_33_0)
		gohelper.setActive(iter_33_1.goRedPointTagNewAct, var_33_0 and not ActivityEnterMgr.instance:isEnteredActivity(iter_33_1.actId))
	end
end

function var_0_0.isPlayedActTagAnimation(arg_34_0, arg_34_1)
	if not arg_34_0.playedNewActTagAnimationIdList then
		return false
	end

	return tabletool.indexOf(arg_34_0.playedNewActTagAnimationIdList, arg_34_1)
end

function var_0_0.playActTagAnimation(arg_35_0, arg_35_1)
	if not ViewHelper.instance:checkViewOnTheTop(arg_35_0.viewName) then
		return
	end

	if arg_35_0.onOpening or arg_35_0.playingUnlockAnimation then
		arg_35_0.needPlayNewActTagActIdList = arg_35_0.needPlayNewActTagActIdList or {}

		if not tabletool.indexOf(arg_35_0.needPlayNewActTagActIdList, arg_35_1.actId) then
			table.insert(arg_35_0.needPlayNewActTagActIdList, arg_35_1.actId)
		end
	else
		arg_35_0:_playActTagAnimation(arg_35_1)
	end
end

function var_0_0._playActTagAnimation(arg_36_0, arg_36_1)
	if arg_36_1.showTag == var_0_0.ShowActTagEnum.ShowNewAct then
		gohelper.setActive(arg_36_1.goRedPointTagNewAct, true)
	elseif arg_36_1.showTag == var_0_0.ShowActTagEnum.ShowNewStage then
		gohelper.setActive(arg_36_1.goRedPointTagNewEpisode, true)
	end

	arg_36_0.playedNewActTagAnimationIdList = arg_36_0.playedNewActTagAnimationIdList or {}

	if not arg_36_1.redPointTagAnimator then
		table.insert(arg_36_0.playedNewActTagAnimationIdList, arg_36_1.actId)

		return
	end

	if not arg_36_0:isPlayedActTagAnimation(arg_36_1.actId) then
		arg_36_1.redPointTagAnimator:Play(UIAnimationName.Open)
		table.insert(arg_36_0.playedNewActTagAnimationIdList, arg_36_1.actId)

		if not arg_36_0.playedActTagAudio and not arg_36_0.onOpening then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_open)

			arg_36_0.playedActTagAudio = true
		end
	end
end

function var_0_0.playActUnlockAnimation(arg_37_0, arg_37_1)
	if not ViewHelper.instance:checkViewOnTheTop(arg_37_0.viewName) then
		return
	end

	if arg_37_0.onOpening then
		arg_37_0.needPlayUnlockAnimationActIdList = arg_37_0.needPlayUnlockAnimationActIdList or {}

		if not tabletool.indexOf(arg_37_0.needPlayUnlockAnimationActIdList, arg_37_1.actId) then
			table.insert(arg_37_0.needPlayUnlockAnimationActIdList, arg_37_1.actId)
		end
	else
		arg_37_0:_playActUnlockAnimation(arg_37_1)
	end
end

function var_0_0._playActUnlockAnimation(arg_38_0, arg_38_1)
	if not arg_38_1 then
		return
	end

	VersionActivityBaseController.instance:playedActivityUnlockAnimation(arg_38_1.actId)

	if arg_38_1.lockAnimator then
		if arg_38_1.goNormalAnimator then
			arg_38_1.goNormalAnimator.enabled = true
		end

		arg_38_1.lockAnimator:Play(UIAnimationName.Unlock, 0, 0)
		arg_38_0:playTimeUnlock(arg_38_1)

		if not arg_38_0.playedActUnlockAudio then
			AudioMgr.instance:trigger(AudioEnum.chess_activity142.SwitchPlayer)

			arg_38_0.playedActUnlockAudio = true
		end

		arg_38_0.playingUnlockAnimation = true

		TaskDispatcher.runDelay(arg_38_0.playUnlockAnimationDone, arg_38_0, var_0_0.ActUnlockAnimationDuration)
	end
end

function var_0_0.playTimeUnlock(arg_39_0, arg_39_1)
	arg_39_1.timeAnimator = arg_39_1.goTime and arg_39_1.goTime:GetComponent(typeof(UnityEngine.Animator))

	if arg_39_1.timeAnimator then
		arg_39_0.needPlayTimeUnlockList = arg_39_0.needPlayTimeUnlockList or {}

		if not tabletool.indexOf(arg_39_0.needPlayTimeUnlockList, arg_39_1) then
			table.insert(arg_39_0.needPlayTimeUnlockList, arg_39_1)
		end
	end
end

function var_0_0.playAllTimeUnlockAnimation(arg_40_0)
	if arg_40_0.needPlayTimeUnlockList then
		for iter_40_0, iter_40_1 in ipairs(arg_40_0.needPlayTimeUnlockList) do
			if iter_40_1.timeAnimator then
				gohelper.setActive(iter_40_1.goTime, true)
				iter_40_1.timeAnimator:Play(UIAnimationName.Open, 0, 0)
			end
		end
	end
end

function var_0_0.playUnlockAnimationDone(arg_41_0)
	arg_41_0.playingUnlockAnimation = false

	arg_41_0:refreshActivityUI()
	arg_41_0:playAllTimeUnlockAnimation()
	arg_41_0:playAllNewTagAnimation()
end

function var_0_0.onOpenAnimationDone(arg_42_0)
	UIBlockMgr.instance:endBlock(arg_42_0.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)

	local var_42_0 = arg_42_0.showGroupIndex == 1 and "open_a" or "open_b"

	arg_42_0.animator:Play(var_42_0, 0, 1)

	if not ViewHelper.instance:checkViewOnTheTop(arg_42_0.viewName) then
		arg_42_0.onOpening = false

		return
	end

	if arg_42_0.needPlayUnlockAnimationActIdList then
		for iter_42_0, iter_42_1 in ipairs(arg_42_0.needPlayUnlockAnimationActIdList) do
			arg_42_0:_playActUnlockAnimation(arg_42_0:getVersionActivityItem(iter_42_1))
		end

		arg_42_0.needPlayUnlockAnimationActIdList = nil
	end

	if not arg_42_0.playingUnlockAnimation then
		arg_42_0:playAllNewTagAnimation()
	end

	arg_42_0.onOpening = false
end

function var_0_0.playAllNewTagAnimation(arg_43_0)
	if arg_43_0.needPlayNewActTagActIdList then
		for iter_43_0, iter_43_1 in ipairs(arg_43_0.needPlayNewActTagActIdList) do
			arg_43_0:_playActTagAnimation(arg_43_0:getVersionActivityItem(iter_43_1))
		end

		arg_43_0.needPlayNewActTagActIdList = nil
	end
end

function var_0_0.everyMinuteCall(arg_44_0)
	if not ViewHelper.instance:checkViewOnTheTop(arg_44_0.viewName) then
		return
	end

	arg_44_0:refreshUI()
end

function var_0_0.onSwitchGroup(arg_45_0)
	arg_45_0:refreshUI()
	arg_45_0:playAmbientAudio()
end

function var_0_0.onClose(arg_46_0)
	UIBlockMgr.instance:endBlock(arg_46_0.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)
	arg_46_0:stopBgm()
	arg_46_0:stopAmbientAudio()
	TaskDispatcher.cancelTask(arg_46_0.everyMinuteCall, arg_46_0)
	TaskDispatcher.cancelTask(arg_46_0.onOpenAnimationDone, arg_46_0)
	TaskDispatcher.cancelTask(arg_46_0.playUnlockAnimationDone, arg_46_0)
end

function var_0_0.onDestroyView(arg_47_0)
	for iter_47_0, iter_47_1 in ipairs(arg_47_0.activityItemListWithGroup) do
		for iter_47_2, iter_47_3 in ipairs(iter_47_1) do
			iter_47_3.click:RemoveClickListener()
		end
	end

	for iter_47_4, iter_47_5 in ipairs(arg_47_0.groupItemList) do
		iter_47_5.click:RemoveClickListener()
	end

	arg_47_0.animEventWrap:RemoveAllEventListener()
end

function var_0_0.beforeClickGroupBtn(arg_48_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_switch)
end

function var_0_0.getLastNormalActId(arg_49_0)
	for iter_49_0 = #arg_49_0.mainActIdList, 1, -1 do
		if ActivityHelper.getActivityStatus(arg_49_0.mainActIdList[iter_49_0]) == ActivityEnum.ActivityStatus.Normal then
			return arg_49_0.mainActIdList[iter_49_0]
		end
	end

	return arg_49_0.mainActIdList[1]
end

function var_0_0.beforePlayOpenAnimation(arg_50_0)
	local var_50_0 = arg_50_0:getLastNormalActId()
	local var_50_1 = arg_50_0.actId2OpenAudioDict[var_50_0]

	if not var_50_1 then
		logWarn("no open audio")

		return
	end

	AudioMgr.instance:trigger(var_50_1)
end

function var_0_0.playAmbientAudio(arg_51_0)
	local var_51_0 = arg_51_0.mainActIdList[arg_51_0.showGroupIndex]

	if var_51_0 == arg_51_0.playingAmbientActId then
		return
	end

	arg_51_0:stopAmbientAudio()

	arg_51_0.playingAmbientActId = var_51_0

	local var_51_1 = arg_51_0.actId2AmbientDict[var_51_0]

	arg_51_0.ambientPlayingId = AudioMgr.instance:trigger(var_51_1)
end

function var_0_0.stopAmbientAudio(arg_52_0)
	if arg_52_0.ambientPlayingId then
		AudioMgr.instance:stopPlayingID(arg_52_0.ambientPlayingId)
	end
end

function var_0_0.playBgm(arg_53_0)
	return
end

function var_0_0.stopBgm(arg_54_0)
	return
end

return var_0_0
