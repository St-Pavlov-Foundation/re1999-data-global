module("modules.logic.versionactivity1_2.enter.view.VersionActivityEnterBaseView1_2", package.seeall)

slot0 = class("VersionActivityEnterBaseView1_2", BaseView)
slot0.ShowActTagEnum = {
	ShowNewStage = 1,
	ShowNewAct = 0
}

function slot0.onInitView(slot0)
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "logo/#txt_time")
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "logo/#txt_remaintime")
	slot0._btnreplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_replay")
end

function slot0.addEvents(slot0)
	slot0._btnreplay:AddClickListener(slot0._btnReplayOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreplay:RemoveClickListener()
end

slot0.ActUnlockAnimationDuration = 2

function slot0._btnReplayOnClick(slot0)
	if not (ActivityModel.instance:getActMO(slot0.actId) and slot1.config and slot1.config.storyId) then
		logError(string.format("act id %s dot config story id", slot2))

		return
	end

	StoryController.instance:playStory(slot2, nil, , , {
		isVersionActivityPV = true
	})
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

	if slot1.audioId then
		AudioMgr.instance:trigger(slot1.audioId)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_sign)
	end

	if slot0["onClickActivity" .. slot1.index] then
		slot3(slot0)
	end
end

function slot0.initActivityItem(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.index = slot1
	slot4.actId = slot2
	slot4.rootGo = slot3
	slot4.activityCo = ActivityConfig.instance:getActivityCo(slot2)
	slot4.openId = slot4.activityCo and slot4.activityCo.openId
	slot4.redDotId = slot4.activityCo and slot4.activityCo.redDotId
	slot4.goNormal = gohelper.findChild(slot3, "normal")
	slot4.imageNormal = gohelper.findChildImage(slot3, "normal/bg")
	slot4.txtActivityName = gohelper.findChildText(slot3, "normal/txt_actname")
	slot4.goLockContainer = gohelper.findChild(slot3, "lockContainer")
	slot4.goDefaultLock = gohelper.findChild(slot3, "lockContainer/go_defaultlock")
	slot4.txtLock = gohelper.findChildText(slot3, "lockContainer/go_defaultlock/txt_lock")
	slot4.goLockSuo = gohelper.findChild(slot3, "lockContainer/go_defaultlock/suo_icon")
	slot4.goRedPoint = gohelper.findChild(slot3, "redpoint")
	slot4.goRedPointTag = gohelper.findChild(slot3, "tag")
	slot4.goRedPointTagNewAct = gohelper.findChild(slot3, "tag/new_act")
	slot4.goRedPointTagNewEpisode = gohelper.findChild(slot3, "tag/new_episode")
	slot4.goTime = gohelper.findChild(slot3, "timeContainer")
	slot4.txtTime = gohelper.findChildText(slot3, "timeContainer/time")
	slot4.txtRemainTime = gohelper.findChildText(slot3, "timeContainer/remain_time")
	slot4.click = gohelper.findChildClick(slot3, "clickarea")

	slot4.click:AddClickListener(slot0._activityBtnOnClick, slot0, slot4)
	gohelper.setActive(slot4.goRedPointTag, true)
	gohelper.setActive(slot4.goRedPointTagNewAct, false)
	gohelper.setActive(slot4.goRedPointTagNewEpisode, false)
	gohelper.setActive(slot4.goDefaultLock, true)

	slot4.redPointTagAnimator = slot4.goRedPointTag and slot4.goRedPointTag:GetComponent(typeof(UnityEngine.Animator))

	return slot4
end

function slot0._editableInitView(slot0)
	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.activityGoContainerList = {}
	slot0.activityItemList = {}
	slot0.playedNewActTagAnimationIdList = nil

	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.checkNeedRefreshUI, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.checkNeedRefreshUI, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, slot0.refreshAllNewActOpenTagUI, slot0)
	slot0:addEventCb(NavigateMgr.instance, NavigateEvent.BeforeClickHome, slot0.beforeClickHome, slot0)
	TaskDispatcher.runRepeat(slot0.everyMinuteCall, slot0, TimeUtil.OneMinuteSecond)
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
	ActivityStageHelper.recordActivityStage(slot0.activityIdList)
end

function slot0.initViewParam(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.skipOpenAnim = slot0.viewParam.skipOpenAnim
	slot0.activityIdList = slot0.viewParam.activityIdList
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
	slot0:initActivityName()
	slot0:refreshUI()
	slot0:playOpenAnimation()
end

function slot0.initActivityNode(slot0)
	slot1 = nil

	for slot5 = 1, #slot0.activityIdList do
		if not slot0.activityGoContainerList[slot5] then
			if gohelper.isNil(gohelper.findChild(slot0.viewGO, string.format("entrance/activityContainer%s/act", slot5))) then
				logError("not found container node : entrance/activityContainer" .. slot5)
			end

			table.insert(slot0.activityGoContainerList, slot1)
		end

		gohelper.setActive(slot1, true)
	end

	for slot5 = #slot0.activityIdList + 1, #slot0.activityGoContainerList do
		gohelper.setActive(slot0.activityGoContainerList[slot5], false)
	end
end

function slot0.initActivityItemList(slot0)
	for slot4 = 1, #slot0.activityIdList do
		table.insert(slot0.activityItemList, slot0:initActivityItem(slot4, slot0.activityIdList[slot4], slot0.activityGoContainerList[slot4]))
	end
end

function slot0.initActivityName(slot0)
	for slot4, slot5 in ipairs(slot0.activityItemList) do
		slot5.txtActivityName.text = slot5.activityCo.name
	end
end

function slot0.getVersionActivityItem(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.activityItemList) do
		if slot6.actId == slot1 then
			return slot6
		end
	end
end

function slot0.playOpenAnimation(slot0)
	if slot0.skipOpenAnim then
		slot0.animator:Play(UIAnimationName.Idle)

		slot0.onOpening = false
	else
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock(slot0.viewName .. "playOpenAnimation")
		AudioMgr.instance:trigger(AudioEnum.VersionActivity1_2.play_ui_lvhu_open)
		slot0.animator:Play(UIAnimationName.Open)
		TaskDispatcher.runDelay(slot0.onOpenAnimationDone, slot0, 2.167)
	end
end

function slot0.refreshUI(slot0)
	slot0:refreshCenterActUI()
	slot0:refreshActivityUI()
end

function slot0.refreshCenterActUI(slot0)
	slot1 = ActivityModel.instance:getActivityInfo()[slot0.actId]

	if slot0._txttime then
		if LangSettings.instance:isEn() then
			slot0._txttime.text = string.format("<color=#578425>%s ~ %s</color>", slot1:getStartTimeStr(), slot1:getEndTimeStr())
		else
			slot0._txttime.text = string.format("<color=#578425>%s ~ %s(UTC+8)</color>", slot1:getStartTimeStr(), slot1:getEndTimeStr())
		end
	end

	if slot0._txtremaintime then
		slot2 = slot1:getRealEndTimeStamp() - ServerTime.now()
		slot6 = Mathf.Floor(slot2 / TimeUtil.OneDaySecond) .. luaLang("time_day") .. Mathf.Floor(slot2 % TimeUtil.OneDaySecond / TimeUtil.OneHourSecond) .. luaLang("time_hour2")

		if LangSettings.instance:isEn() then
			slot6 = slot3 .. luaLang("time_day") .. " " .. slot5 .. luaLang("time_hour2")
		end

		slot0._txtremaintime.text = string.format(luaLang("remain"), slot6)
	end
end

function slot0.refreshActivityUI(slot0)
	slot0.playedActTagAudio = false
	slot0.playedActUnlockAudio = false

	for slot4, slot5 in ipairs(slot0.activityItemList) do
		slot0:refreshActivityItem(slot5)
	end
end

function slot0.defaultBeforePlayActUnlockAnimation(slot0, slot1)
	gohelper.setActive(gohelper.findChild(slot1.rootGo, "lockContainer/go_defaultlock/circle"), false)
	gohelper.setActive(slot1.txtLock.gameObject, false)
	gohelper.setActive(slot1.goLockContainer, true)
	gohelper.setActive(slot1.goDefaultLock, true)
end

function slot0.refreshActivityItem(slot0, slot1)
	if slot1.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	slot2 = ActivityHelper.getActivityStatus(slot1.actId)

	logNormal("act id : " .. slot1.actId .. ", status : " .. slot2)

	if slot2 == ActivityEnum.ActivityStatus.Normal and not VersionActivityBaseController.instance:isPlayedUnlockAnimation(slot1.actId) then
		slot1.lockAnimator = slot1.goDefaultLock and slot1.goDefaultLock:GetComponent(typeof(UnityEngine.Animator))

		if slot1.lockAnimator then
			slot0["beforePlayActUnlockAnimationActivity" .. slot1.index] or slot0.defaultBeforePlayActUnlockAnimation(slot0, slot1)
			slot0:playActUnlockAnimation(slot1)
		else
			slot0:refreshLockUI(slot1, slot2)
		end
	else
		slot0:refreshLockUI(slot1, slot2)
	end

	slot0:refreshTimeContainer(slot1, slot2)
	slot0:refreshRedDotContainer(slot1, slot3)

	if slot0["onRefreshActivity" .. slot1.index] then
		slot4(slot0, slot1)
	end
end

function slot0.refreshLockUI(slot0, slot1, slot2)
	slot3 = slot2 == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(slot1.goLockContainer, not slot3)
	gohelper.setActive(slot1.goLockSuo, slot2 == ActivityEnum.ActivityStatus.NotOpen or slot2 == ActivityEnum.ActivityStatus.NotUnlock)

	if not slot3 and slot1.txtLock then
		slot4 = ""

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

		slot1.txtLock.text = slot4
	end
end

function slot0.refreshTimeContainer(slot0, slot1, slot2)
	slot3 = slot2 == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(slot1.goTime, slot3)

	if not slot3 then
		return
	end

	slot4 = ActivityModel.instance:getActivityInfo()[slot1.actId]

	if slot1.txtTime then
		slot1.txtTime.text = slot4:getStartTimeStr() .. "~" .. slot4:getEndTimeStr()
	end

	if slot1.txtRemainTime then
		if slot3 then
			slot1.txtRemainTime.text = string.format(luaLang("remain"), slot4:getRemainTimeStr2ByEndTime())
		else
			slot1.txtRemainTime.text = ""
		end
	end
end

function slot0.refreshRedDotContainer(slot0, slot1, slot2)
	if slot2 and slot1.redDotId and slot1.redDotId ~= 0 then
		RedDotController.instance:addRedDot(slot1.goRedPoint, slot1.redDotId)
	end

	slot0:refreshRedDotTag(slot1, slot2)
end

function slot0.refreshRedDotTag(slot0, slot1, slot2)
	gohelper.setActive(slot1.goRedPointTag, slot2)
	gohelper.setActive(slot1.goRedPointTagNewAct, false)
	gohelper.setActive(slot1.goRedPointTagNewEpisode, false)

	slot1.showTag = nil

	if slot2 then
		if not ActivityEnterMgr.instance:isEnteredActivity(slot1.actId) then
			slot1.showTag = uv0.ShowActTagEnum.ShowNewAct

			slot0:playActTagAnimation(slot1)
		elseif ActivityModel.instance:getActivityInfo()[slot1.actId]:isNewStageOpen() then
			slot1.showTag = uv0.ShowActTagEnum.ShowNewStage

			slot0:playActTagAnimation(slot1)
		end
	end
end

function slot0.refreshAllNewActOpenTagUI(slot0)
	for slot4, slot5 in ipairs(slot0.activityItemList) do
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

		if not slot0.playedActTagAudio then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_open)

			slot0.playedActTagAudio = true
		end
	end
end

function slot0.playActUnlockAnimation(slot0, slot1)
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
		slot1.lockAnimator:Play(UIAnimationName.Open, 0, 0)
		slot0:playTimeUnlock(slot1)

		if not slot0.playedActUnlockAudio then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity1_2.play_ui_lvhu_level_unlock)

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

	slot0:playAllTimeUnlockAnimation()
	slot0:playAllNewTagAnimation()
end

function slot0.onOpenAnimationDone(slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)

	slot0.onOpening = false

	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		slot0.needPlayUnlockAnimationActIdList = nil

		return
	end

	if slot0.needPlayUnlockAnimationActIdList then
		for slot4, slot5 in ipairs(slot0.needPlayUnlockAnimationActIdList) do
			slot0:_playActUnlockAnimation(slot0:getVersionActivityItem(slot5))
		end

		slot0.needPlayUnlockAnimationActIdList = nil
	end

	if not slot0.playingUnlockAnimation then
		slot0:playAllNewTagAnimation()
	end
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

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(slot0.everyMinuteCall, slot0)
	TaskDispatcher.cancelTask(slot0.onOpenAnimationDone, slot0)
	TaskDispatcher.cancelTask(slot0.playUnlockAnimationDone, slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.activityItemList) do
		slot5.click:RemoveClickListener()
	end
end

return slot0
