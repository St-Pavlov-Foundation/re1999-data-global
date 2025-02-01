module("modules.versionactivitybase.enterview.view.VersionActivityEnterBaseViewWithList", package.seeall)

slot0 = class("VersionActivityEnterBaseViewWithList", BaseView)
slot1 = VersionActivityEnterViewTabEnum.ActTabFlag

function slot0.onInitView(slot0)
	slot0._goCategory = gohelper.findChild(slot0.viewGO, "#go_category")
	slot0._goEntrance = gohelper.findChild(slot0.viewGO, "entrance")
	slot0._categoryAnimator = slot0._goCategory:GetComponent(typeof(UnityEngine.Animator))
	slot0._entranceAnimator = slot0._goEntrance:GetComponent(typeof(UnityEngine.Animator))
	slot0._goActivityItem = gohelper.findChild(slot0.viewGO, "#go_category/#scroll_category/Viewport/Content/#go_categoryitem")
	slot0._goActivityOpeningTitle = gohelper.findChild(slot0.viewGO, "#go_category/#scroll_category/Viewport/Content/#txt_title")
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goActivityItem, false)
	gohelper.setActive(slot0._goActivityOpeningTitle, false)

	slot0.activityItemList = {}
	slot0.activityItemDict = {}
	slot0.showItemNum = 0
	slot0.playedNewActTagAnimationIdList = nil

	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.checkNeedRefreshUI, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.checkNeedRefreshUI, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, slot0.refreshAllNewActOpenTagUI, slot0)
	slot0:addEventCb(NavigateMgr.instance, NavigateEvent.BeforeClickHome, slot0.beforeClickHome, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, slot0.checkTabRedDot, slot0)
	slot0:addActivityStateEvents()

	slot0._defaultTabIdx = 1
	slot0._curTabIdx = -1
end

function slot0.onOpen(slot0)
	slot0.onOpening = true
	slot0._curActId = 0

	slot0:initViewParam()
	slot0:initActivityItemList()
	slot0:refreshUI()
	slot0:playOpenAnimation()
	slot0:_selectActivityItem(slot0._defaultTabIdx, true, slot0._showEnterVideo and true)
	slot0:refreshAllTabSelectState()
	slot0:addPerMinuteRefresh()
	slot0:addPerSecondRefresh()
end

function slot0.initViewParam(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.skipOpenAnim = slot0.viewParam.skipOpenAnim
	slot0.activityIdList = slot0.viewParam.activityIdList

	if slot0.viewParam.jumpActId and slot1 > 0 then
		for slot5, slot6 in ipairs(slot0.activityIdList) do
			if slot0:checkIsSameAct(slot6, slot1) then
				slot0._defaultTabIdx = slot5

				break
			end
		end
	end

	if (slot0["checkStatusFunc" .. slot0.activityIdList[slot0._defaultTabIdx]] and slot3() or ActivityHelper.getActivityStatus(slot2)) == ActivityEnum.ActivityStatus.Expired then
		for slot8 = 1, #slot0.activityIdList do
			if ActivityHelper.getActivityStatus(slot0:getActId(slot0.activityIdList[slot8])) == ActivityEnum.ActivityStatus.Normal or slot11 == ActivityEnum.ActivityStatus.NotUnlock or slot11 == ActivityEnum.ActivityStatus.NotOpen then
				slot0._defaultTabIdx = slot8

				break
			end
		end
	end
end

function slot0.onOpenFinish(slot0)
	if slot0.viewParam and slot0.viewParam.actId then
		slot0:clickTargetActivityItem(slot1)
	end

	slot0:checkTabRedDot()
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)
	slot0:clearTimerTask()
	TaskDispatcher.cancelTask(slot0.onOpenAnimationDone, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:initViewParam()
	slot0:refreshUI()
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.activityItemList) do
		slot5.click:RemoveClickListener()
	end
end

function slot0.addActivityStateEvents(slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0.checkActivity, slot0)
end

function slot0.checkActivity(slot0, slot1)
	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName, {
		ViewName.GMToolView
	}) then
		return
	end

	slot0:checkCurActivityIsEnd()
end

function slot0.checkActivityIsEnd(slot0, slot1)
	if string.nilorempty(slot1) or slot1 == 0 then
		return
	end

	return (slot0["checkStatusFunc" .. slot1] and slot2(slot1) or ActivityHelper.getActivityStatus(slot1)) == ActivityEnum.ActivityStatus.Expired
end

function slot0.doActivityShow(slot0)
	MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)
end

function slot0.checkCurActivityIsEnd(slot0)
	if slot0:checkActivityIsEnd(slot0._curActId) then
		slot1 = ActivityHelper.getActivityStatus(slot0._curActId)

		slot0:doActivityShow()
	end
end

function slot0.initActivityItemList(slot0)
	for slot4 = 1, #slot0.activityIdList do
		slot5 = slot0.activityIdList[slot4]
		slot6 = slot0:getActId(slot5)
		slot7 = gohelper.cloneInPlace(slot0._goActivityItem, slot6)

		gohelper.setActive(slot7, true)

		slot8 = slot0:createActivityItem(slot4, slot6, slot7)
		slot8.actList = slot5
		slot0.activityItemList[#slot0.activityItemList + 1] = slot8
		slot0.activityItemDict[slot6] = slot8
	end
end

function slot0.createActivityItem(slot0, slot1, slot2, slot3)
	slot4 = VersionActivityEnterViewTabItem.New()

	slot4:init(slot1, slot2, slot3)
	slot4:setClickFunc(slot0._activityItemOnClick, slot0)
	slot0:onCreateActivityItem(slot4)

	return slot4
end

function slot0.onCreateActivityItem(slot0, slot1)
end

function slot0.getActivityItems(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(slot0.activityItemList) do
		if slot7.actId == slot1 then
			table.insert(slot2 or {}, slot7)
		end
	end

	return slot2
end

function slot0._selectActivityItem(slot0, slot1, slot2, slot3)
	if slot0._curTabIdx == slot1 then
		return
	end

	slot0._curTabIdx = slot1
	slot4 = slot0.activityItemList[slot1]
	slot0._curActId = slot4.actId
	slot5 = ActivityModel.instance:getActivityInfo()[slot4.actId]
	slot6 = slot4.actId

	ActivityEnterMgr.instance:enterActivity(slot6)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		slot6
	})
	slot0:setSelectActId(slot6)
	slot4:refreshActivityItemTag()
	slot4:refreshTimeInfo()
	slot0:onRefreshTabView(slot1, slot3)

	if slot2 then
		slot0:onFocusToTab(slot4)
	end

	slot0.viewContainer:selectActTab(slot1, slot6)
end

function slot0.refreshCurItemView(slot0)
	slot2 = slot0.activityItemList[slot0._curTabIdx]
	slot3 = ActivityModel.instance:getActMO(slot2.actId)
	slot4 = slot2.actId
	slot0._curActId = slot4

	ActivityEnterMgr.instance:enterActivity(slot4)
	slot0:setSelectActId(slot4)
	slot2:refreshActivityItemTag()

	if slot2.showTag == uv0.ShowNewAct or slot2.showTag == uv0.ShowNewStage then
		slot0:playActTagAnimation(slot2)
	end

	slot0:onRefreshTabView(slot1)
	slot0.viewContainer:selectActTab(slot1, slot4)
end

function slot0.onFocusToTab(slot0, slot1)
end

function slot0.setSelectActId(slot0, slot1)
end

function slot0.onRefreshTabView(slot0, slot1)
	slot0._entranceAnimator:Play(UIAnimationName.Open, 0, 0)
end

function slot0._activityItemOnClick(slot0, slot1)
	if slot1.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	if not slot0["checkActivityCanClickFunc" .. slot1.actId] or slot0.defaultCheckActivityClick(slot0, slot1) then
		return
	end

	if slot0["onClickActivity" .. slot1.actId] then
		slot3(slot0)
	end

	slot0:_selectActivityItem(slot1.index)
	slot0:refreshAllTabSelectState()
end

function slot0.defaultCheckActivityClick(slot0, slot1)
	slot3, slot4, slot5 = ActivityHelper.getActivityStatusAndToast(slot1.actId)

	if slot0:CheckActivityStatusClickAble(slot3) then
		return true
	else
		if slot4 then
			GameFacade.showToastWithTableParam(slot4, slot5)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end
end

function slot0.CheckActivityStatusClickAble(slot0, slot1)
	if not slot0._activtiyStatusClickAble then
		slot0._activtiyStatusClickAble = {
			[ActivityEnum.ActivityStatus.Normal] = true,
			[ActivityEnum.ActivityStatus.NotUnlock] = true
		}
	end

	return slot0._activtiyStatusClickAble[slot1]
end

function slot0.openActItemSortFunc(slot0, slot1)
	if ActivityModel.instance:getActMO(slot0).config.displayPriority ~= ActivityModel.instance:getActMO(slot1).config.displayPriority then
		return slot4 < slot5
	end

	if slot2:getRealStartTimeStamp() ~= slot3:getRealStartTimeStamp() then
		return slot7 < slot6
	end

	return slot0 < slot1
end

function slot0.noOpenActItemSortFunc(slot0, slot1)
	if ActivityModel.instance:getActMO(slot0):getRealStartTimeStamp() ~= ActivityModel.instance:getActMO(slot1):getRealStartTimeStamp() then
		return slot4 < slot5
	end

	if slot2.config.displayPriority ~= slot3.config.displayPriority then
		return slot6 < slot7
	end

	return slot0 < slot1
end

function slot0.beforeClickHome(slot0)
	slot0.clickedHome = true
end

function slot0.checkNeedRefreshUI(slot0)
	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName, {
		ViewName.GMToolView
	}) then
		return
	end

	if slot0.clickedHome then
		return
	end

	slot0:refreshUI()
	ActivityStageHelper.recordActivityStage(slot0.activityIdList)
end

function slot0.refreshUI(slot0)
	slot0:refreshActivityUI()
	slot0:refreshItemSiblingAndActive()
end

function slot0.refreshActivityUI(slot0)
	slot0.playedActTagAudio = false
	slot0.playedActUnlockAudio = false
	slot1, slot2 = nil

	for slot6, slot7 in ipairs(slot0.activityItemList) do
		if slot0:getActId(slot7.actList) == slot7.actId then
			slot0:refreshActivityItem(slot7)
		else
			if not slot1 then
				slot1 = {}
				slot2 = {}
			end

			table.insert(slot2, slot7.actId)

			slot1[slot8] = slot7

			slot0:changeActivityItem(slot7, slot8)
		end
	end

	if slot2 then
		for slot6, slot7 in ipairs(slot2) do
			slot0.activityItemDict[slot7] = nil
		end
	end

	if slot1 then
		for slot6, slot7 in pairs(slot1) do
			slot0.activityItemDict[slot6] = slot7
		end

		if slot1[slot0._curActId] then
			slot0:refreshCurItemView()
		end
	end
end

function slot0.clickTargetActivityItem(slot0, slot1)
	if not slot1 and not ActivityModel.instance:getActMO(slot1) then
		return
	end

	for slot5, slot6 in pairs(slot0.activityItemList) do
		if slot6.actId == slot1 then
			slot0:_activityItemOnClick(slot6)
		end
	end
end

function slot0.changeActivityItem(slot0, slot1, slot2)
	slot1.actId = slot2
	slot1.openId = ActivityConfig.instance:getActivityCo(slot2) and slot3.openId
	slot1.redDotId = slot3 and slot3.redDotId

	slot0:refreshActivityItem(slot1)
end

function slot0.refreshItemSiblingAndActive(slot0)
	slot1 = #slot0.activityItemList
	slot2 = {}
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in pairs(slot0.activityItemDict) do
		if (slot0["checkStatusFunc" .. slot8] and slot10(slot8) or ActivityHelper.getActivityStatus(slot8)) == ActivityEnum.ActivityStatus.Normal or slot11 == ActivityEnum.ActivityStatus.NotUnlock then
			table.insert(slot2, slot8)
		elseif slot11 == ActivityEnum.ActivityStatus.NotOpen then
			table.insert(slot3, slot8)
		else
			table.insert(slot4, slot8)
		end
	end

	table.sort(slot2, slot0.openActItemSortFunc)

	for slot8 = 1, #slot2 do
		slot10 = slot0.activityItemDict[slot2[slot8]]

		gohelper.setSibling(slot10.rootGo, slot8)
		gohelper.setActive(slot10.rootGo, true)
	end

	gohelper.setSibling(slot0._goActivityOpeningTitle, #slot2 + 1)
	gohelper.setActive(slot0._goActivityOpeningTitle, #slot3 > 0)
	table.sort(slot3, slot0.noOpenActItemSortFunc)

	for slot8 = 1, #slot3 do
		slot10 = slot0.activityItemDict[slot3[slot8]]

		gohelper.setSibling(slot10.rootGo, #slot2 + 1 + slot8)
		gohelper.setActive(slot10.rootGo, true)
	end

	for slot8 = 1, #slot4 do
		gohelper.setActive(slot0.activityItemDict[slot4[slot8]].rootGo, false)
	end

	slot0.showItemNum = #slot2 + #slot3
end

function slot0.refreshActivityItem(slot0, slot1)
	if slot1.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	if not ActivityModel.instance:getActivityInfo()[slot1.actId] then
		return
	end

	slot3 = ActivityHelper.getActivityStatus(slot1.actId)

	slot1:refreshActivityItemTag()

	if slot1.showTag == uv0.ShowNewAct or slot1.showTag == uv0.ShowNewStage then
		slot0:playActTagAnimation(slot1)
	end

	if slot1.actId == V1a6_CachotEnum.ActivityId and V1a6_CachotModel.instance:isOnline() then
		V1a6_CachotController.instance:checkRogueStateInfo()
	end

	slot1:refreshTimeInfo()
	slot1:refreshNameText()
	slot1:addRedDot()
	slot0:onRefreshActivityTabIcon(slot1)

	if slot0["onRefreshActivity" .. slot1.index] then
		slot4(slot0, slot1)
	end
end

function slot0.refreshActvityItemsTimeInfo(slot0)
	for slot4, slot5 in pairs(slot0.activityItemDict) do
		slot5:refreshTimeInfo()
	end
end

function slot0.onRefreshActivityTabIcon(slot0, slot1)
end

function slot0._setCanvasGroupAlpha(slot0, slot1, slot2)
	if slot1 then
		slot1.alpha = slot2
	end
end

function slot0.refreshAllTabSelectState(slot0)
	for slot4, slot5 in ipairs(slot0.activityItemList) do
		slot7 = slot5.index == slot0._curTabIdx

		slot5:refreshSelectState(slot7)
		slot0:refreshTabSelectState(slot5, slot7)
	end
end

function slot0.refreshTabSelectState(slot0, slot1, slot2)
end

function slot0.playOpenAnimation(slot0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(slot0.viewName .. "playOpenAnimation")

	if slot0.skipOpenAnim then
		slot0:onOpenAnimationDone()
	else
		slot0._entranceAnimator:Play(UIAnimationName.Open, 0, 0)
		slot0._categoryAnimator:Play(UIAnimationName.Open, 0, 0)
		slot0:onPlayOpenAnimation()
		TaskDispatcher.runDelay(slot0.onOpenAnimationDone, slot0, 0.3)
	end
end

function slot0.onPlayOpenAnimation(slot0)
end

function slot0.onOpenAnimationDone(slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)

	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		slot0.onOpening = false

		return
	end

	slot0:playAllNewTagAnimation()

	slot0.onOpening = false
end

function slot0.playAllNewTagAnimation(slot0)
	if slot0.needPlayNewActTagActIdList then
		for slot4, slot5 in ipairs(slot0.needPlayNewActTagActIdList) do
			slot0:_playActTagAnimations(slot0:getActivityItems(slot5))
		end

		slot0.needPlayNewActTagActIdList = nil
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
	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	if slot0.onOpening then
		slot0.needPlayNewActTagActIdList = slot0.needPlayNewActTagActIdList or {}

		if not tabletool.indexOf(slot0.needPlayNewActTagActIdList, slot1.actId) then
			table.insert(slot0.needPlayNewActTagActIdList, slot1.actId)
		end
	else
		slot0:_playActTagAnimation(slot1)
	end
end

function slot0._playActTagAnimations(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in pairs(slot1) do
		slot0:_playActTagAnimation(slot6)
	end
end

function slot0._playActTagAnimation(slot0, slot1)
	if slot1.showTag == uv0.ShowNewAct then
		gohelper.setActive(slot1.newActivityFlags.select, true)
		gohelper.setActive(slot1.newActivityFlags.normal, true)
	elseif slot1.showTag == uv0.ShowNewStage then
		gohelper.setActive(slot1.newEpisodeFlags.select, true)
		gohelper.setActive(slot1.newEpisodeFlags.normal, true)
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

function slot0.checkTabRedDot(slot0)
	if not slot0.activityItemList then
		return
	end

	slot0._redDotItems = {}

	for slot5, slot6 in ipairs(slot1) do
		slot9 = RedDotModel.instance:getRedDotInfo(slot6.redDotId)

		if (ActivityHelper.getActivityStatus(slot6.actId) == ActivityEnum.ActivityStatus.Normal or slot7 == ActivityEnum.ActivityStatus.NotOpen or slot7 == ActivityEnum.ActivityStatus.NotUnlock) and slot9 and slot9.infos then
			for slot13, slot14 in pairs(slot9.infos) do
				if slot14.value > 0 then
					slot0._redDotItems[#slot0._redDotItems + 1] = slot6
				end
			end
		end
	end
end

function slot0.addPerSecondRefresh(slot0)
	TaskDispatcher.runRepeat(slot0.everySecondCall, slot0, 1)
end

function slot0.everySecondCall(slot0)
	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName, {
		ViewName.GMToolView
	}) then
		return
	end

	slot0:refreshActvityItemsTimeInfo()
	slot0:checkCurActivityIsEnd()
end

function slot0.addPerMinuteRefresh(slot0)
	if math.floor(ServerTime.now() % TimeUtil.OneMinuteSecond) > 0 then
		TaskDispatcher.runDelay(slot0._addPerMinuteRefresh, slot0, TimeUtil.OneMinuteSecond - slot2 + 1)
	else
		slot0:_addPerMinuteRefresh()
	end
end

function slot0._addPerMinuteRefresh(slot0)
	slot0:everyMinuteCall()
	TaskDispatcher.runRepeat(slot0.everyMinuteCall, slot0, TimeUtil.OneMinuteSecond)
end

function slot0.everyMinuteCall(slot0)
	if not ViewHelper.instance:checkViewOnTheTop(slot0.viewName) then
		return
	end

	slot0:refreshUI()
end

function slot0.clearTimerTask(slot0)
	TaskDispatcher.cancelTask(slot0.everyMinuteCall, slot0)
	TaskDispatcher.cancelTask(slot0._addPerMinuteRefresh, slot0)
	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
end

function slot0.checkIsSameAct(slot0, slot1, slot2)
	if type(slot1) == "table" then
		for slot6, slot7 in ipairs(slot1) do
			if slot7 == slot2 then
				return true
			end
		end

		return false
	end

	return slot1 == slot2
end

function slot0.getActId(slot0, slot1)
	if type(slot1) == "table" then
		for slot5, slot6 in ipairs(slot1) do
			if ActivityHelper.getActivityStatus(slot6) == ActivityEnum.ActivityStatus.Normal or slot7 == ActivityEnum.ActivityStatus.NotUnlock then
				return slot6
			end
		end

		return slot1[1]
	end

	return slot1
end

return slot0
