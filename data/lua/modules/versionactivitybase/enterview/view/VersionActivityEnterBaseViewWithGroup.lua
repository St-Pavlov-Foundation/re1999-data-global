module("modules.versionactivitybase.enterview.view.VersionActivityEnterBaseViewWithGroup", package.seeall)

slot0 = class("VersionActivityEnterBaseViewWithGroup", BaseView)
slot0.ShowActTagEnum = {
	ShowNewStage = 1,
	ShowNewAct = 0
}

function slot0.onInitView(slot0)
	slot0._btnreplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_replay")
	slot0._goGroupController = gohelper.findChild(slot0.viewGO, "entrance/#go_groupController")
end

function slot0.addEvents(slot0)
	slot0._btnreplay:AddClickListener(slot0._btnReplayOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreplay:RemoveClickListener()
end

slot0.ActUnlockAnimationDuration = 2.5

function slot0._btnReplayOnClick(slot0)
	if not (ActivityModel.instance:getActMO(slot0.actId) and slot1.config and slot1.config.storyId) then
		logError(string.format("act id %s dot config story id", slot2))

		return
	end

	StoryController.instance:playStory(slot2, {
		isVersionActivityPV = true
	})
end

function slot0.onClickGroupBtn(slot0, slot1)
	if slot1.groupIndex == slot0.showGroupIndex then
		return
	end

	slot3, slot4, slot5 = ActivityHelper.getActivityStatusAndToast(slot0.mainActIdList[slot1.groupIndex])

	if slot3 ~= ActivityEnum.ActivityStatus.Normal then
		if slot3 == ActivityEnum.ActivityStatus.NotOpen then
			slot6 = ActivityModel.instance:getActMO(slot2)

			GameFacade.showToast(ToastEnum.V1a4_ActPreTips, slot6.config.name, TimeUtil.getFormatTime_overseas(slot6:getRealStartTimeStamp() - ServerTime.now()))
		elseif slot4 then
			GameFacade.showToastWithTableParam(slot4, slot5)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return
	end

	slot0.showGroupIndex = slot1.groupIndex

	slot0.animator:Play(slot0.showGroupIndex == 1 and "switch_b" or "switch_a", 0, 0)
	slot0:beforeClickGroupBtn()
	slot0:refreshGroupBtnUI()
end

function slot0.defaultCheckActivityCanClick(slot0, slot1)
	slot2, slot3, slot4 = ActivityHelper.getActivityStatusAndToast(slot1.actId)

	if slot2 ~= ActivityEnum.ActivityStatus.Normal then
		if slot3 then
			GameFacade.showToastWithTableParam(slot3, slot4)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end

	return true
end

function slot0._activityBtnOnClick(slot0, slot1)
	if slot1.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	if not slot0["checkActivityCanClickFunc" .. slot1.index] or slot0.defaultCheckActivityCanClick(slot0, slot1) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)

	if slot0["onClickActivity" .. slot1.index] then
		slot3(slot0)
	end
end

function slot0.initActivityItem(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0:getUserDataTb_()
	slot5.groupIndex = slot1
	slot5.index = slot2
	slot5.actId = slot3
	slot5.rootGo = slot4
	slot5.openId = ActivityConfig.instance:getActivityCo(slot3) and slot6.openId
	slot5.redDotId = slot6 and slot6.redDotId
	slot5.animator = slot5.rootGo:GetComponent(typeof(UnityEngine.Animator))
	slot5.goNormal = gohelper.findChild(slot4, "normal")
	slot5.goNormalAnimator = slot5.goNormal:GetComponent(typeof(UnityEngine.Animator))

	if slot5.goNormalAnimator then
		slot5.goNormalAnimator.enabled = false
	end

	if VersionActivityEnum.EnterViewNormalAnimationPath[slot3] and gohelper.findChild(slot4, slot7) then
		slot5.normalAnimation = slot8:GetComponent(typeof(UnityEngine.Animation))
	end

	slot5.goLockContainer = gohelper.findChild(slot4, "lockContainer")
	slot5.txtLockGo = gohelper.findChild(slot4, "lockContainer/lock")
	slot5.txtLock = gohelper.findChildText(slot4, "lockContainer/lock/txt_lock")
	slot5.goRedPoint = gohelper.findChild(slot4, "redpoint")
	slot5.goRedPointTag = gohelper.findChild(slot4, "tag")
	slot5.goRedPointTagNewAct = gohelper.findChild(slot4, "tag/new_act")
	slot5.goRedPointTagNewEpisode = gohelper.findChild(slot4, "tag/new_episode")
	slot5.goTime = gohelper.findChild(slot4, "timeContainer")
	slot5.txtTime = gohelper.findChildText(slot4, "timeContainer/time")
	slot5.txtRemainTime = gohelper.findChildText(slot4, "timeContainer/TimeBG/remain_time")
	slot5.click = SLFramework.UGUI.ButtonWrap.Get(slot4)

	gohelper.setActive(gohelper.findChild(slot4, "clickarea"), false)
	slot5.click:AddClickListener(slot0._activityBtnOnClick, slot0, slot5)
	gohelper.setActive(slot5.goRedPointTag, true)
	gohelper.setActive(slot5.goRedPointTagNewAct, false)
	gohelper.setActive(slot5.goRedPointTagNewEpisode, false)

	slot5.redPointTagAnimator = slot5.goRedPointTag and slot5.goRedPointTag:GetComponent(typeof(UnityEngine.Animator))

	return slot5
end

function slot0.createGroupBtnItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.groupIndex = slot1
	slot2.goGroup = gohelper.findChild(slot0._goGroupController, "tab" .. slot1)

	if gohelper.isNil(slot2.goGroup) then
		logError("not found btn group : " .. tostring(slot1))

		return
	end

	slot2.click = gohelper.getClick(slot2.goGroup)
	slot2.goNormal = gohelper.findChild(slot2.goGroup, "go_normal")
	slot2.goSelect = gohelper.findChild(slot2.goGroup, "go_select")
	slot2.goRedDot = gohelper.findChild(slot2.goGroup, "go_reddot")

	slot2.click:AddClickListener(slot0.onClickGroupBtn, slot0, slot2)

	return slot2
end

function slot0.initBtnGroup(slot0)
	slot0.groupItemList = {}

	for slot4 = 1, 2 do
		table.insert(slot0.groupItemList, slot0:createGroupBtnItem(slot4))
	end
end

function slot0._editableInitView(slot0)
	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.activityGoContainerList = slot0:getUserDataTb_()
	slot0.activityItemListWithGroup = {}
	slot0.groupGoList = slot0:getUserDataTb_()
	slot0.showGroupIndex = 0
	slot0.playedNewActTagAnimationIdList = nil
	slot0.animEventWrap = slot0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	slot0.animEventWrap:AddEventListener("refreshUI", slot0.onSwitchGroup, slot0)
	slot0:initBtnGroup()
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.checkNeedRefreshUI, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, slot0.refreshAllNewActOpenTagUI, slot0)
	slot0:addEventCb(NavigateMgr.instance, NavigateEvent.BeforeClickHome, slot0.beforeClickHome, slot0)
	TaskDispatcher.runRepeat(slot0.everyMinuteCall, slot0, TimeUtil.OneMinuteSecond)
end

function slot0.onCloseViewFinish(slot0)
	slot0:checkNeedRefreshUI()

	if ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		slot0:playAmbientAudio()
	end
end

function slot0.onOpenViewFinish(slot0)
	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		slot0:stopAmbientAudio()
	end
end

function slot0.beforeClickHome(slot0)
	slot0.clickedHome = true
end

function slot0.checkNeedRefreshUI(slot0)
	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	if slot0.clickedHome then
		return
	end

	slot0:refreshUI()
	ActivityStageHelper.recordActivityStage(slot0.activityIdListWithGroup[slot0.mainActIdList[slot0.showGroupIndex]])
end

function slot0.initViewParam(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.skipOpenAnim = slot0.viewParam.skipOpenAnim
	slot0.activityIdListWithGroup = slot0.viewParam.activityIdListWithGroup
	slot0.mainActIdList = slot0.viewParam.mainActIdList
	slot0.actId2AmbientDict = slot0.viewParam.actId2AmbientDict
	slot0.actId2OpenAudioDict = slot0.viewParam.actId2OpenAudioDict

	slot0:initGroupIndex()
end

function slot0.initGroupIndex(slot0)
	for slot4 = #slot0.mainActIdList, 1, -1 do
		if ActivityHelper.getActivityStatus(slot0.mainActIdList[slot4]) == ActivityEnum.ActivityStatus.Normal then
			slot0.showGroupIndex = slot4

			return
		end
	end

	logError("一个活动都没解锁？")

	slot0.showGroupIndex = 1
end

function slot0.onUpdateParam(slot0)
	slot0:initViewParam()
	slot0:refreshUI()
end

function slot0.onOpen(slot0)
	slot0.onOpening = true

	slot0:initViewParam()
	slot0:initActivityNode()
	slot0:initActivityItemList()
	slot0:refreshUI()
	slot0:playOpenAnimation()
	slot0:playBgm()
	slot0:playAmbientAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_switch)
end

function slot0.initActivityNode(slot0)
	for slot4 = 1, 2 do
		if gohelper.isNil(gohelper.findChild(slot0.viewGO, "entrance/#go_group" .. slot4)) then
			logError("not found group node : entrance/#go_group" .. slot4)
		end

		table.insert(slot0.groupGoList, slot5)
	end

	slot1 = 0

	for slot5, slot6 in ipairs(slot0.mainActIdList) do
		slot7 = slot0.groupGoList[slot5]

		for slot12 = 1, #slot0.activityIdListWithGroup[slot6] do
			if gohelper.isNil(gohelper.findChild(slot7, "activityContainer" .. slot1 + 1)) then
				logError(string.format("not found container node : %s/activityContainer%s", slot7.name, slot1))
			end

			table.insert(slot0.activityGoContainerList, slot13)
		end
	end
end

function slot0.initActivityItemList(slot0)
	slot1 = 0

	for slot5, slot6 in ipairs(slot0.mainActIdList) do
		slot7 = slot0.activityIdListWithGroup[slot6]

		if slot0.activityItemListWithGroup[slot5] == nil then
			slot0.activityItemListWithGroup[slot5] = {}
		end

		for slot12, slot13 in ipairs(slot7) do
			slot1 = slot1 + 1

			table.insert(slot8, slot0:initActivityItem(slot5, slot1, slot13, slot0.activityGoContainerList[slot1]))
		end
	end
end

function slot0.getVersionActivityItem(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.activityItemListWithGroup) do
		for slot10, slot11 in ipairs(slot6) do
			if slot11.actId == slot1 then
				return slot11
			end
		end
	end
end

function slot0.playOpenAnimation(slot0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(slot0.viewName .. "playOpenAnimation")

	if slot0.skipOpenAnim then
		slot0.animator:Play(UIAnimationName.Idle)
		TaskDispatcher.runDelay(slot0.onOpenAnimationDone, slot0, 0.5)
	else
		slot0:beforePlayOpenAnimation()
		slot0.animator:Play(slot0.showGroupIndex == 1 and "open_a" or "open_b", 0, 0)
		TaskDispatcher.runDelay(slot0.onOpenAnimationDone, slot0, 2.167)
	end
end

function slot0.refreshUI(slot0)
	slot0:refreshCenterActUI()
	slot0:refreshActivityUI()
end

function slot0.refreshCenterActUI(slot0)
	slot0:refreshSingleBgUI()
	slot0:refreshGroupBtnUI()
end

function slot0.refreshSingleBgUI(slot0)
end

function slot0.refreshGroupBtnUI(slot0)
	for slot4, slot5 in ipairs(slot0.groupItemList) do
		gohelper.setActive(slot5.goNormal, slot0.showGroupIndex ~= slot5.groupIndex)
		gohelper.setActive(slot5.goSelect, slot0.showGroupIndex == slot5.groupIndex)

		if ActivityHelper.getActivityStatus(slot0.mainActIdList[slot4]) == ActivityEnum.ActivityStatus.Normal and not slot5.redDotComp then
			slot5.redDotComp = RedDotController.instance:addRedDot(slot5.goRedDot, ActivityConfig.instance:getActivityCo(slot6).redDotId)
		end
	end
end

function slot0.refreshActivityUI(slot0)
	slot0.playedActTagAudio = false
	slot0.playedActUnlockAudio = false

	for slot4, slot5 in ipairs(slot0.groupGoList) do
		gohelper.setActive(slot5, slot4 == slot0.showGroupIndex)
	end

	for slot4, slot5 in ipairs(slot0.activityItemListWithGroup[slot0.showGroupIndex]) do
		slot0:refreshActivityItem(slot5)
	end
end

function slot0.defaultBeforePlayActUnlockAnimation(slot0, slot1)
	gohelper.setActive(slot1.goTime, false)
	gohelper.setActive(slot1.goLockContainer, true)

	if slot1.txtLockGo then
		gohelper.setActive(slot1.txtLockGo, false)
	end
end

function slot0.refreshActivityItem(slot0, slot1)
	if slot1.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	slot2 = ActivityHelper.getActivityStatus(slot1.actId)

	logNormal("act id : " .. slot1.actId .. ", status : " .. slot2)

	slot3 = slot2 == ActivityEnum.ActivityStatus.Normal
	slot4 = ActivityModel.instance:getActivityInfo()[slot1.actId]

	if slot1.normalAnimation then
		slot1.normalAnimation.enabled = slot3
	end

	if slot3 and not VersionActivityBaseController.instance:isPlayedUnlockAnimation(slot1.actId) then
		slot1.lockAnimator = slot1.goLockContainer and slot1.goLockContainer:GetComponent(typeof(UnityEngine.Animator))

		if not slot1.lockAnimator then
			slot0:refreshLockUI(slot1, slot2)
		else
			slot0["beforePlayActUnlockAnimationActivity" .. slot1.index] or slot0.defaultBeforePlayActUnlockAnimation(slot0, slot1)
			slot0:playActUnlockAnimation(slot1)
		end
	else
		slot0:refreshLockUI(slot1, slot2)
	end

	if slot1.animator then
		if slot2 == ActivityEnum.ActivityStatus.Normal then
			slot1.animator:Play(UIAnimationName.Loop)
		else
			slot1.animator:Play(UIAnimationName.Idle)
		end
	end

	if slot1.txtTime then
		slot1.txtTime.text = slot4:getStartTimeStr() .. "~" .. slot4:getEndTimeStr()
	end

	if slot1.txtRemainTime then
		if slot2 == ActivityEnum.ActivityStatus.Normal then
			slot1.txtRemainTime.text = string.format(luaLang("remain"), slot4:getRemainTimeStr2ByEndTime())
		else
			slot1.txtRemainTime.text = ""
		end
	end

	if slot3 and slot1.redDotId and slot1.redDotId ~= 0 then
		RedDotController.instance:addRedDot(slot1.goRedPoint, slot1.redDotId)
	end

	gohelper.setActive(slot1.goRedPointTag, slot3)
	gohelper.setActive(slot1.goRedPointTagNewAct, false)
	gohelper.setActive(slot1.goRedPointTagNewEpisode, false)

	slot1.showTag = nil

	if slot3 then
		if not ActivityEnterMgr.instance:isEnteredActivity(slot1.actId) then
			slot1.showTag = uv0.ShowActTagEnum.ShowNewAct

			slot0:playActTagAnimation(slot1)
		elseif slot4:isNewStageOpen() then
			slot1.showTag = uv0.ShowActTagEnum.ShowNewStage

			slot0:playActTagAnimation(slot1)
		end
	end

	if slot0["onRefreshActivity" .. slot1.index] then
		slot5(slot0, slot1)
	end
end

function slot0.refreshLockUI(slot0, slot1, slot2)
	slot3 = slot2 == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(slot1.goLockContainer, not slot3)
	gohelper.setActive(slot1.txtLockGo, not slot3)
	gohelper.setActive(slot1.goTime, slot3)

	if not slot3 and slot1.txtLock then
		slot1.txtLock.text = slot0["getLockTextFunc" .. slot1.index] or slot0.getLockText(slot0, slot1, slot2)
	end
end

function slot0.getLockText(slot0, slot1, slot2)
	slot4 = nil

	if slot2 == ActivityEnum.ActivityStatus.NotOpen then
		slot4 = string.format(luaLang("test_task_unlock_time"), ActivityModel.instance:getActivityInfo()[slot1.actId]:getRemainTimeStr2ByOpenTime())
	elseif slot2 == ActivityEnum.ActivityStatus.Expired then
		slot4 = luaLang("p_activityenter_finish")
	elseif slot2 == ActivityEnum.ActivityStatus.NotUnlock then
		slot4 = luaLang("p_versionactivitytripenter_lock")
	elseif slot2 == ActivityEnum.ActivityStatus.NotOnLine then
		slot4 = luaLang("p_activityenter_finish")
	elseif slot2 == ActivityEnum.ActivityStatus.None then
		slot4 = luaLang("p_activityenter_finish")
	end

	return slot4
end

function slot0.refreshAllNewActOpenTagUI(slot0)
	for slot4, slot5 in ipairs(slot0.activityItemListWithGroup[slot0.showGroupIndex]) do
		slot7 = ActivityHelper.getActivityStatus(slot5.actId) == ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(slot5.goRedPointTag, slot7)
		gohelper.setActive(slot5.goRedPointTagNewAct, slot7 and not ActivityEnterMgr.instance:isEnteredActivity(slot5.actId))
	end
end

function slot0.isPlayedActTagAnimation(slot0, slot1)
	if not slot0.playedNewActTagAnimationIdList then
		return false
	end

	return tabletool.indexOf(slot0.playedNewActTagAnimationIdList, slot1)
end

function slot0.playActTagAnimation(slot0, slot1)
	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	if slot0.onOpening or slot0.playingUnlockAnimation then
		slot0.needPlayNewActTagActIdList = slot0.needPlayNewActTagActIdList or {}

		if not tabletool.indexOf(slot0.needPlayNewActTagActIdList, slot1.actId) then
			table.insert(slot0.needPlayNewActTagActIdList, slot1.actId)
		end
	else
		slot0:_playActTagAnimation(slot1)
	end
end

function slot0._playActTagAnimation(slot0, slot1)
	if slot1.showTag == uv0.ShowActTagEnum.ShowNewAct then
		gohelper.setActive(slot1.goRedPointTagNewAct, true)
	elseif slot1.showTag == uv0.ShowActTagEnum.ShowNewStage then
		gohelper.setActive(slot1.goRedPointTagNewEpisode, true)
	end

	slot0.playedNewActTagAnimationIdList = slot0.playedNewActTagAnimationIdList or {}

	if not slot1.redPointTagAnimator then
		table.insert(slot0.playedNewActTagAnimationIdList, slot1.actId)

		return
	end

	if not slot0:isPlayedActTagAnimation(slot1.actId) then
		slot1.redPointTagAnimator:Play(UIAnimationName.Open)
		table.insert(slot0.playedNewActTagAnimationIdList, slot1.actId)

		if not slot0.playedActTagAudio and not slot0.onOpening then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_open)

			slot0.playedActTagAudio = true
		end
	end
end

function slot0.playActUnlockAnimation(slot0, slot1)
	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	if slot0.onOpening then
		slot0.needPlayUnlockAnimationActIdList = slot0.needPlayUnlockAnimationActIdList or {}

		if not tabletool.indexOf(slot0.needPlayUnlockAnimationActIdList, slot1.actId) then
			table.insert(slot0.needPlayUnlockAnimationActIdList, slot1.actId)
		end
	else
		slot0:_playActUnlockAnimation(slot1)
	end
end

function slot0._playActUnlockAnimation(slot0, slot1)
	if not slot1 then
		return
	end

	VersionActivityBaseController.instance:playedActivityUnlockAnimation(slot1.actId)

	if slot1.lockAnimator then
		if slot1.goNormalAnimator then
			slot1.goNormalAnimator.enabled = true
		end

		slot1.lockAnimator:Play(UIAnimationName.Unlock, 0, 0)
		slot0:playTimeUnlock(slot1)

		if not slot0.playedActUnlockAudio then
			AudioMgr.instance:trigger(AudioEnum.chess_activity142.SwitchPlayer)

			slot0.playedActUnlockAudio = true
		end

		slot0.playingUnlockAnimation = true

		TaskDispatcher.runDelay(slot0.playUnlockAnimationDone, slot0, uv0.ActUnlockAnimationDuration)
	end
end

function slot0.playTimeUnlock(slot0, slot1)
	slot1.timeAnimator = slot1.goTime and slot1.goTime:GetComponent(typeof(UnityEngine.Animator))

	if slot1.timeAnimator then
		slot0.needPlayTimeUnlockList = slot0.needPlayTimeUnlockList or {}

		if not tabletool.indexOf(slot0.needPlayTimeUnlockList, slot1) then
			table.insert(slot0.needPlayTimeUnlockList, slot1)
		end
	end
end

function slot0.playAllTimeUnlockAnimation(slot0)
	if slot0.needPlayTimeUnlockList then
		for slot4, slot5 in ipairs(slot0.needPlayTimeUnlockList) do
			if slot5.timeAnimator then
				gohelper.setActive(slot5.goTime, true)
				slot5.timeAnimator:Play(UIAnimationName.Open, 0, 0)
			end
		end
	end
end

function slot0.playUnlockAnimationDone(slot0)
	slot0.playingUnlockAnimation = false

	slot0:refreshActivityUI()
	slot0:playAllTimeUnlockAnimation()
	slot0:playAllNewTagAnimation()
end

function slot0.onOpenAnimationDone(slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)
	slot0.animator:Play(slot0.showGroupIndex == 1 and "open_a" or "open_b", 0, 1)

	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		slot0.onOpening = false

		return
	end

	if slot0.needPlayUnlockAnimationActIdList then
		for slot5, slot6 in ipairs(slot0.needPlayUnlockAnimationActIdList) do
			slot0:_playActUnlockAnimation(slot0:getVersionActivityItem(slot6))
		end

		slot0.needPlayUnlockAnimationActIdList = nil
	end

	if not slot0.playingUnlockAnimation then
		slot0:playAllNewTagAnimation()
	end

	slot0.onOpening = false
end

function slot0.playAllNewTagAnimation(slot0)
	if slot0.needPlayNewActTagActIdList then
		for slot4, slot5 in ipairs(slot0.needPlayNewActTagActIdList) do
			slot0:_playActTagAnimation(slot0:getVersionActivityItem(slot5))
		end

		slot0.needPlayNewActTagActIdList = nil
	end
end

function slot0.everyMinuteCall(slot0)
	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	slot0:refreshUI()
end

function slot0.onSwitchGroup(slot0)
	slot0:refreshUI()
	slot0:playAmbientAudio()
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)
	slot0:stopBgm()
	slot0:stopAmbientAudio()
	TaskDispatcher.cancelTask(slot0.everyMinuteCall, slot0)
	TaskDispatcher.cancelTask(slot0.onOpenAnimationDone, slot0)
	TaskDispatcher.cancelTask(slot0.playUnlockAnimationDone, slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.activityItemListWithGroup) do
		for slot9, slot10 in ipairs(slot5) do
			slot10.click:RemoveClickListener()
		end
	end

	for slot4, slot5 in ipairs(slot0.groupItemList) do
		slot5.click:RemoveClickListener()
	end

	slot0.animEventWrap:RemoveAllEventListener()
end

function slot0.beforeClickGroupBtn(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_switch)
end

function slot0.getLastNormalActId(slot0)
	for slot4 = #slot0.mainActIdList, 1, -1 do
		if ActivityHelper.getActivityStatus(slot0.mainActIdList[slot4]) == ActivityEnum.ActivityStatus.Normal then
			return slot0.mainActIdList[slot4]
		end
	end

	return slot0.mainActIdList[1]
end

function slot0.beforePlayOpenAnimation(slot0)
	if not slot0.actId2OpenAudioDict[slot0:getLastNormalActId()] then
		logWarn("no open audio")

		return
	end

	AudioMgr.instance:trigger(slot2)
end

function slot0.playAmbientAudio(slot0)
	if slot0.mainActIdList[slot0.showGroupIndex] == slot0.playingAmbientActId then
		return
	end

	slot0:stopAmbientAudio()

	slot0.playingAmbientActId = slot1
	slot0.ambientPlayingId = AudioMgr.instance:trigger(slot0.actId2AmbientDict[slot1])
end

function slot0.stopAmbientAudio(slot0)
	if slot0.ambientPlayingId then
		AudioMgr.instance:stopPlayingID(slot0.ambientPlayingId)
	end
end

function slot0.playBgm(slot0)
end

function slot0.stopBgm(slot0)
end

return slot0
