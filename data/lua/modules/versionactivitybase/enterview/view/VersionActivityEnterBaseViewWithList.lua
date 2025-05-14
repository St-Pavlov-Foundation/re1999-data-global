module("modules.versionactivitybase.enterview.view.VersionActivityEnterBaseViewWithList", package.seeall)

local var_0_0 = class("VersionActivityEnterBaseViewWithList", BaseView)
local var_0_1 = VersionActivityEnterViewTabEnum.ActTabFlag

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goCategory = gohelper.findChild(arg_1_0.viewGO, "#go_category")
	arg_1_0._goEntrance = gohelper.findChild(arg_1_0.viewGO, "entrance")
	arg_1_0._categoryAnimator = arg_1_0._goCategory:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._entranceAnimator = arg_1_0._goEntrance:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goActivityItem = gohelper.findChild(arg_1_0.viewGO, "#go_category/#scroll_category/Viewport/Content/#go_categoryitem")
	arg_1_0._goActivityOpeningTitle = gohelper.findChild(arg_1_0.viewGO, "#go_category/#scroll_category/Viewport/Content/#txt_title")
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._goActivityItem, false)
	gohelper.setActive(arg_4_0._goActivityOpeningTitle, false)

	arg_4_0.activityItemList = {}
	arg_4_0.activityItemDict = {}
	arg_4_0.showItemNum = 0
	arg_4_0.playedNewActTagAnimationIdList = nil

	arg_4_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_4_0.checkNeedRefreshUI, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_4_0.checkNeedRefreshUI, arg_4_0)
	arg_4_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, arg_4_0.refreshAllNewActOpenTagUI, arg_4_0)
	arg_4_0:addEventCb(NavigateMgr.instance, NavigateEvent.BeforeClickHome, arg_4_0.beforeClickHome, arg_4_0)
	arg_4_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, arg_4_0.checkTabRedDot, arg_4_0)
	arg_4_0:addActivityStateEvents()

	arg_4_0._defaultTabIdx = 1
	arg_4_0._curTabIdx = -1
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.onOpening = true
	arg_5_0._curActId = 0

	arg_5_0:initViewParam()
	arg_5_0:initActivityItemList()
	arg_5_0:refreshUI()
	arg_5_0:playOpenAnimation()
	arg_5_0:_selectActivityItem(arg_5_0._defaultTabIdx, true, arg_5_0._showEnterVideo and true)
	arg_5_0:refreshAllTabSelectState()
	arg_5_0:addPerMinuteRefresh()
	arg_5_0:addPerSecondRefresh()
end

function var_0_0.initViewParam(arg_6_0)
	arg_6_0.actId = arg_6_0.viewParam.actId
	arg_6_0.skipOpenAnim = arg_6_0.viewParam.skipOpenAnim
	arg_6_0.activityIdList = arg_6_0.viewParam.activityIdList

	local var_6_0 = arg_6_0.viewParam.jumpActId

	if var_6_0 and var_6_0 > 0 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0.activityIdList) do
			if arg_6_0:checkIsSameAct(iter_6_1, var_6_0) then
				arg_6_0._defaultTabIdx = iter_6_0

				break
			end
		end
	end

	local var_6_1 = arg_6_0.activityIdList[arg_6_0._defaultTabIdx]
	local var_6_2 = arg_6_0["checkStatusFunc" .. var_6_1]

	if (var_6_2 and var_6_2() or ActivityHelper.getActivityStatus(var_6_1)) == ActivityEnum.ActivityStatus.Expired then
		for iter_6_2 = 1, #arg_6_0.activityIdList do
			local var_6_3 = arg_6_0.activityIdList[iter_6_2]
			local var_6_4 = arg_6_0:getActId(var_6_3)
			local var_6_5 = ActivityHelper.getActivityStatus(var_6_4)

			if var_6_5 == ActivityEnum.ActivityStatus.Normal or var_6_5 == ActivityEnum.ActivityStatus.NotUnlock or var_6_5 == ActivityEnum.ActivityStatus.NotOpen then
				arg_6_0._defaultTabIdx = iter_6_2

				break
			end
		end
	end
end

function var_0_0.onOpenFinish(arg_7_0)
	local var_7_0 = arg_7_0.viewParam and arg_7_0.viewParam.actId

	if var_7_0 then
		arg_7_0:clickTargetActivityItem(var_7_0)
	end

	arg_7_0:checkTabRedDot()
end

function var_0_0.onClose(arg_8_0)
	UIBlockMgr.instance:endBlock(arg_8_0.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)
	arg_8_0:clearTimerTask()
	TaskDispatcher.cancelTask(arg_8_0.onOpenAnimationDone, arg_8_0)
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:initViewParam()
	arg_9_0:refreshUI()
end

function var_0_0.onDestroyView(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.activityItemList) do
		iter_10_1.click:RemoveClickListener()
	end
end

function var_0_0.addActivityStateEvents(arg_11_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_11_0.checkActivity, arg_11_0)
end

function var_0_0.checkActivity(arg_12_0, arg_12_1)
	if not ViewHelper.instance:checkViewOnTheTop(arg_12_0.viewName, {
		ViewName.GMToolView
	}) then
		return
	end

	arg_12_0:checkCurActivityIsEnd()
end

function var_0_0.checkActivityIsEnd(arg_13_0, arg_13_1)
	if string.nilorempty(arg_13_1) or arg_13_1 == 0 then
		return
	end

	local var_13_0 = arg_13_0["checkStatusFunc" .. arg_13_1]

	return (var_13_0 and var_13_0(arg_13_1) or ActivityHelper.getActivityStatus(arg_13_1)) == ActivityEnum.ActivityStatus.Expired
end

function var_0_0.doActivityShow(arg_14_0)
	MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)
end

function var_0_0.checkCurActivityIsEnd(arg_15_0)
	if arg_15_0:checkActivityIsEnd(arg_15_0._curActId) then
		local var_15_0 = ActivityHelper.getActivityStatus(arg_15_0._curActId)

		arg_15_0:doActivityShow()
	end
end

function var_0_0.initActivityItemList(arg_16_0)
	for iter_16_0 = 1, #arg_16_0.activityIdList do
		local var_16_0 = arg_16_0.activityIdList[iter_16_0]
		local var_16_1 = arg_16_0:getActId(var_16_0)
		local var_16_2 = gohelper.cloneInPlace(arg_16_0._goActivityItem, var_16_1)

		gohelper.setActive(var_16_2, true)

		local var_16_3 = arg_16_0:createActivityItem(iter_16_0, var_16_1, var_16_2)

		var_16_3.actList = var_16_0
		arg_16_0.activityItemList[#arg_16_0.activityItemList + 1] = var_16_3
		arg_16_0.activityItemDict[var_16_1] = var_16_3
	end
end

function var_0_0.createActivityItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = VersionActivityEnterViewTabItem.New()

	var_17_0:init(arg_17_1, arg_17_2, arg_17_3)
	var_17_0:setClickFunc(arg_17_0._activityItemOnClick, arg_17_0)
	arg_17_0:onCreateActivityItem(var_17_0)

	return var_17_0
end

function var_0_0.onCreateActivityItem(arg_18_0, arg_18_1)
	return
end

function var_0_0.getActivityItems(arg_19_0, arg_19_1)
	local var_19_0

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.activityItemList) do
		if iter_19_1.actId == arg_19_1 then
			var_19_0 = var_19_0 or {}

			table.insert(var_19_0, iter_19_1)
		end
	end

	return var_19_0
end

function var_0_0._selectActivityItem(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_0._curTabIdx == arg_20_1 then
		return
	end

	arg_20_0._curTabIdx = arg_20_1

	local var_20_0 = arg_20_0.activityItemList[arg_20_1]

	arg_20_0._curActId = var_20_0.actId

	local var_20_1 = ActivityModel.instance:getActivityInfo()[var_20_0.actId]
	local var_20_2 = var_20_0.actId

	ActivityEnterMgr.instance:enterActivity(var_20_2)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		var_20_2
	})
	arg_20_0:setSelectActId(var_20_2)
	var_20_0:refreshActivityItemTag()
	var_20_0:refreshTimeInfo()
	arg_20_0:onRefreshTabView(arg_20_1, arg_20_3)

	if arg_20_2 then
		arg_20_0:onFocusToTab(var_20_0)
	end

	arg_20_0.viewContainer:selectActTab(arg_20_1, var_20_2)
end

function var_0_0.refreshCurItemView(arg_21_0)
	local var_21_0 = arg_21_0._curTabIdx
	local var_21_1 = arg_21_0.activityItemList[var_21_0]
	local var_21_2 = ActivityModel.instance:getActMO(var_21_1.actId)
	local var_21_3 = var_21_1.actId

	arg_21_0._curActId = var_21_3

	ActivityEnterMgr.instance:enterActivity(var_21_3)
	arg_21_0:setSelectActId(var_21_3)
	var_21_1:refreshActivityItemTag()

	if var_21_1.showTag == var_0_1.ShowNewAct or var_21_1.showTag == var_0_1.ShowNewStage then
		arg_21_0:playActTagAnimation(var_21_1)
	end

	arg_21_0:onRefreshTabView(var_21_0)
	arg_21_0.viewContainer:selectActTab(var_21_0, var_21_3)
end

function var_0_0.onFocusToTab(arg_22_0, arg_22_1)
	return
end

function var_0_0.setSelectActId(arg_23_0, arg_23_1)
	return
end

function var_0_0.onRefreshTabView(arg_24_0, arg_24_1)
	arg_24_0._entranceAnimator:Play(UIAnimationName.Open, 0, 0)
end

function var_0_0._activityItemOnClick(arg_25_0, arg_25_1)
	if arg_25_1.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	if not (arg_25_0["checkActivityCanClickFunc" .. arg_25_1.actId] or arg_25_0.defaultCheckActivityClick)(arg_25_0, arg_25_1) then
		return
	end

	local var_25_0 = arg_25_0["onClickActivity" .. arg_25_1.actId]

	if var_25_0 then
		var_25_0(arg_25_0)
	end

	arg_25_0:_selectActivityItem(arg_25_1.index)
	arg_25_0:refreshAllTabSelectState()
end

function var_0_0.defaultCheckActivityClick(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1.actId
	local var_26_1, var_26_2, var_26_3 = ActivityHelper.getActivityStatusAndToast(var_26_0)

	if arg_26_0:CheckActivityStatusClickAble(var_26_1) then
		return true
	else
		if var_26_2 then
			GameFacade.showToastWithTableParam(var_26_2, var_26_3)
		end

		AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_closehouse)

		return false
	end
end

function var_0_0.CheckActivityStatusClickAble(arg_27_0, arg_27_1)
	if not arg_27_0._activtiyStatusClickAble then
		arg_27_0._activtiyStatusClickAble = {
			[ActivityEnum.ActivityStatus.Normal] = true,
			[ActivityEnum.ActivityStatus.NotUnlock] = true
		}
	end

	return arg_27_0._activtiyStatusClickAble[arg_27_1]
end

function var_0_0.openActItemSortFunc(arg_28_0, arg_28_1)
	local var_28_0 = ActivityModel.instance:getActMO(arg_28_0)
	local var_28_1 = ActivityModel.instance:getActMO(arg_28_1)
	local var_28_2 = var_28_0.config.displayPriority
	local var_28_3 = var_28_1.config.displayPriority

	if var_28_2 ~= var_28_3 then
		return var_28_2 < var_28_3
	end

	local var_28_4 = var_28_0:getRealStartTimeStamp()
	local var_28_5 = var_28_1:getRealStartTimeStamp()

	if var_28_4 ~= var_28_5 then
		return var_28_5 < var_28_4
	end

	return arg_28_0 < arg_28_1
end

function var_0_0.noOpenActItemSortFunc(arg_29_0, arg_29_1)
	local var_29_0 = ActivityModel.instance:getActMO(arg_29_0)
	local var_29_1 = ActivityModel.instance:getActMO(arg_29_1)
	local var_29_2 = var_29_0:getRealStartTimeStamp()
	local var_29_3 = var_29_1:getRealStartTimeStamp()

	if var_29_2 ~= var_29_3 then
		return var_29_2 < var_29_3
	end

	local var_29_4 = var_29_0.config.displayPriority
	local var_29_5 = var_29_1.config.displayPriority

	if var_29_4 ~= var_29_5 then
		return var_29_4 < var_29_5
	end

	return arg_29_0 < arg_29_1
end

function var_0_0.beforeClickHome(arg_30_0)
	arg_30_0.clickedHome = true
end

function var_0_0.checkNeedRefreshUI(arg_31_0)
	if not ViewHelper.instance:checkViewOnTheTop(arg_31_0.viewName, {
		ViewName.GMToolView
	}) then
		return
	end

	if arg_31_0.clickedHome then
		return
	end

	arg_31_0:refreshUI()
	ActivityStageHelper.recordActivityStage(arg_31_0.activityIdList)
end

function var_0_0.refreshUI(arg_32_0)
	arg_32_0:refreshActivityUI()
	arg_32_0:refreshItemSiblingAndActive()
end

function var_0_0.refreshActivityUI(arg_33_0)
	arg_33_0.playedActTagAudio = false
	arg_33_0.playedActUnlockAudio = false

	local var_33_0
	local var_33_1

	for iter_33_0, iter_33_1 in ipairs(arg_33_0.activityItemList) do
		local var_33_2 = arg_33_0:getActId(iter_33_1.actList)

		if var_33_2 == iter_33_1.actId then
			arg_33_0:refreshActivityItem(iter_33_1)
		else
			if not var_33_0 then
				var_33_0 = {}
				var_33_1 = {}
			end

			table.insert(var_33_1, iter_33_1.actId)

			var_33_0[var_33_2] = iter_33_1

			arg_33_0:changeActivityItem(iter_33_1, var_33_2)
		end
	end

	if var_33_1 then
		for iter_33_2, iter_33_3 in ipairs(var_33_1) do
			arg_33_0.activityItemDict[iter_33_3] = nil
		end
	end

	if var_33_0 then
		for iter_33_4, iter_33_5 in pairs(var_33_0) do
			arg_33_0.activityItemDict[iter_33_4] = iter_33_5
		end

		if var_33_0[arg_33_0._curActId] then
			arg_33_0:refreshCurItemView()
		end
	end
end

function var_0_0.clickTargetActivityItem(arg_34_0, arg_34_1)
	if not arg_34_1 and not ActivityModel.instance:getActMO(arg_34_1) then
		return
	end

	for iter_34_0, iter_34_1 in pairs(arg_34_0.activityItemList) do
		if iter_34_1.actId == arg_34_1 then
			arg_34_0:_activityItemOnClick(iter_34_1)
		end
	end
end

function var_0_0.changeActivityItem(arg_35_0, arg_35_1, arg_35_2)
	arg_35_1.actId = arg_35_2

	local var_35_0 = ActivityConfig.instance:getActivityCo(arg_35_2)

	arg_35_1.openId = var_35_0 and var_35_0.openId
	arg_35_1.redDotId = var_35_0 and var_35_0.redDotId

	arg_35_0:refreshActivityItem(arg_35_1)
end

function var_0_0.refreshItemSiblingAndActive(arg_36_0)
	local var_36_0 = #arg_36_0.activityItemList
	local var_36_1 = {}
	local var_36_2 = {}
	local var_36_3 = {}

	for iter_36_0, iter_36_1 in pairs(arg_36_0.activityItemDict) do
		local var_36_4 = arg_36_0["checkStatusFunc" .. iter_36_0]
		local var_36_5 = var_36_4 and var_36_4(iter_36_0) or ActivityHelper.getActivityStatus(iter_36_0)

		if var_36_5 == ActivityEnum.ActivityStatus.Normal or var_36_5 == ActivityEnum.ActivityStatus.NotUnlock then
			table.insert(var_36_1, iter_36_0)
		elseif var_36_5 == ActivityEnum.ActivityStatus.NotOpen then
			table.insert(var_36_2, iter_36_0)
		else
			table.insert(var_36_3, iter_36_0)
		end
	end

	table.sort(var_36_1, arg_36_0.openActItemSortFunc)

	for iter_36_2 = 1, #var_36_1 do
		local var_36_6 = var_36_1[iter_36_2]
		local var_36_7 = arg_36_0.activityItemDict[var_36_6]

		gohelper.setSibling(var_36_7.rootGo, iter_36_2)
		gohelper.setActive(var_36_7.rootGo, true)
	end

	gohelper.setSibling(arg_36_0._goActivityOpeningTitle, #var_36_1 + 1)
	gohelper.setActive(arg_36_0._goActivityOpeningTitle, #var_36_2 > 0)
	table.sort(var_36_2, arg_36_0.noOpenActItemSortFunc)

	for iter_36_3 = 1, #var_36_2 do
		local var_36_8 = var_36_2[iter_36_3]
		local var_36_9 = arg_36_0.activityItemDict[var_36_8]

		gohelper.setSibling(var_36_9.rootGo, #var_36_1 + 1 + iter_36_3)
		gohelper.setActive(var_36_9.rootGo, true)
	end

	for iter_36_4 = 1, #var_36_3 do
		local var_36_10 = var_36_3[iter_36_4]
		local var_36_11 = arg_36_0.activityItemDict[var_36_10]

		gohelper.setActive(var_36_11.rootGo, false)
	end

	arg_36_0.showItemNum = #var_36_1 + #var_36_2
end

function var_0_0.refreshActivityItem(arg_37_0, arg_37_1)
	if arg_37_1.actId == ActivityEnum.PlaceholderActivityId then
		return
	end

	if not ActivityModel.instance:getActivityInfo()[arg_37_1.actId] then
		return
	end

	local var_37_0 = ActivityHelper.getActivityStatus(arg_37_1.actId)

	arg_37_1:refreshActivityItemTag()

	if arg_37_1.showTag == var_0_1.ShowNewAct or arg_37_1.showTag == var_0_1.ShowNewStage then
		arg_37_0:playActTagAnimation(arg_37_1)
	end

	if arg_37_1.actId == V1a6_CachotEnum.ActivityId and V1a6_CachotModel.instance:isOnline() then
		V1a6_CachotController.instance:checkRogueStateInfo()
	end

	arg_37_1:refreshTimeInfo()
	arg_37_1:refreshNameText()
	arg_37_1:addRedDot()
	arg_37_0:onRefreshActivityTabIcon(arg_37_1)

	local var_37_1 = arg_37_0["onRefreshActivity" .. arg_37_1.index]

	if var_37_1 then
		var_37_1(arg_37_0, arg_37_1)
	end
end

function var_0_0.refreshActvityItemsTimeInfo(arg_38_0)
	for iter_38_0, iter_38_1 in pairs(arg_38_0.activityItemDict) do
		iter_38_1:refreshTimeInfo()
	end
end

function var_0_0.onRefreshActivityTabIcon(arg_39_0, arg_39_1)
	return
end

function var_0_0._setCanvasGroupAlpha(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_1 then
		arg_40_1.alpha = arg_40_2
	end
end

function var_0_0.refreshAllTabSelectState(arg_41_0)
	for iter_41_0, iter_41_1 in ipairs(arg_41_0.activityItemList) do
		local var_41_0 = iter_41_1.index == arg_41_0._curTabIdx

		iter_41_1:refreshSelectState(var_41_0)
		arg_41_0:refreshTabSelectState(iter_41_1, var_41_0)
	end
end

function var_0_0.refreshTabSelectState(arg_42_0, arg_42_1, arg_42_2)
	return
end

function var_0_0.playOpenAnimation(arg_43_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(arg_43_0.viewName .. "playOpenAnimation")

	if arg_43_0.skipOpenAnim then
		arg_43_0:onOpenAnimationDone()
	else
		arg_43_0._entranceAnimator:Play(UIAnimationName.Open, 0, 0)
		arg_43_0._categoryAnimator:Play(UIAnimationName.Open, 0, 0)
		arg_43_0:onPlayOpenAnimation()
		TaskDispatcher.runDelay(arg_43_0.onOpenAnimationDone, arg_43_0, 0.3)
	end
end

function var_0_0.onPlayOpenAnimation(arg_44_0)
	return
end

function var_0_0.onOpenAnimationDone(arg_45_0)
	UIBlockMgr.instance:endBlock(arg_45_0.viewName .. "playOpenAnimation")
	UIBlockMgrExtend.setNeedCircleMv(true)

	if not ViewHelper.instance:checkViewOnTheTop(arg_45_0.viewName) then
		arg_45_0.onOpening = false

		return
	end

	arg_45_0:playAllNewTagAnimation()

	arg_45_0.onOpening = false
end

function var_0_0.playAllNewTagAnimation(arg_46_0)
	if arg_46_0.needPlayNewActTagActIdList then
		for iter_46_0, iter_46_1 in ipairs(arg_46_0.needPlayNewActTagActIdList) do
			arg_46_0:_playActTagAnimations(arg_46_0:getActivityItems(iter_46_1))
		end

		arg_46_0.needPlayNewActTagActIdList = nil
	end
end

function var_0_0.refreshAllNewActOpenTagUI(arg_47_0)
	for iter_47_0, iter_47_1 in ipairs(arg_47_0.activityItemList) do
		local var_47_0 = ActivityHelper.getActivityStatus(iter_47_1.actId) == ActivityEnum.ActivityStatus.Normal

		gohelper.setActive(iter_47_1.goRedPointTag, var_47_0)
		gohelper.setActive(iter_47_1.goRedPointTagNewAct, var_47_0 and not ActivityEnterMgr.instance:isEnteredActivity(iter_47_1.actId))
	end
end

function var_0_0.isPlayedActTagAnimation(arg_48_0, arg_48_1)
	if not arg_48_0.playedNewActTagAnimationIdList then
		return false
	end

	return tabletool.indexOf(arg_48_0.playedNewActTagAnimationIdList, arg_48_1)
end

function var_0_0.playActTagAnimation(arg_49_0, arg_49_1)
	if not ViewHelper.instance:checkViewOnTheTop(arg_49_0.viewName) then
		return
	end

	if arg_49_0.onOpening then
		arg_49_0.needPlayNewActTagActIdList = arg_49_0.needPlayNewActTagActIdList or {}

		if not tabletool.indexOf(arg_49_0.needPlayNewActTagActIdList, arg_49_1.actId) then
			table.insert(arg_49_0.needPlayNewActTagActIdList, arg_49_1.actId)
		end
	else
		arg_49_0:_playActTagAnimation(arg_49_1)
	end
end

function var_0_0._playActTagAnimations(arg_50_0, arg_50_1)
	if not arg_50_1 then
		return
	end

	for iter_50_0, iter_50_1 in pairs(arg_50_1) do
		arg_50_0:_playActTagAnimation(iter_50_1)
	end
end

function var_0_0._playActTagAnimation(arg_51_0, arg_51_1)
	if arg_51_1.showTag == var_0_1.ShowNewAct then
		gohelper.setActive(arg_51_1.newActivityFlags.select, true)
		gohelper.setActive(arg_51_1.newActivityFlags.normal, true)
	elseif arg_51_1.showTag == var_0_1.ShowNewStage then
		gohelper.setActive(arg_51_1.newEpisodeFlags.select, true)
		gohelper.setActive(arg_51_1.newEpisodeFlags.normal, true)
	end

	arg_51_0.playedNewActTagAnimationIdList = arg_51_0.playedNewActTagAnimationIdList or {}

	if not arg_51_1.redPointTagAnimator then
		table.insert(arg_51_0.playedNewActTagAnimationIdList, arg_51_1.actId)

		return
	end

	if not arg_51_0:isPlayedActTagAnimation(arg_51_1.actId) then
		arg_51_1.redPointTagAnimator:Play(UIAnimationName.Open)
		table.insert(arg_51_0.playedNewActTagAnimationIdList, arg_51_1.actId)

		if not arg_51_0.playedActTagAudio and not arg_51_0.onOpening then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_open)

			arg_51_0.playedActTagAudio = true
		end
	end
end

function var_0_0.checkTabRedDot(arg_52_0)
	local var_52_0 = arg_52_0.activityItemList

	if not var_52_0 then
		return
	end

	arg_52_0._redDotItems = {}

	for iter_52_0, iter_52_1 in ipairs(var_52_0) do
		local var_52_1 = ActivityHelper.getActivityStatus(iter_52_1.actId)
		local var_52_2 = var_52_1 == ActivityEnum.ActivityStatus.Normal or var_52_1 == ActivityEnum.ActivityStatus.NotOpen or var_52_1 == ActivityEnum.ActivityStatus.NotUnlock
		local var_52_3 = RedDotModel.instance:getRedDotInfo(iter_52_1.redDotId)

		if var_52_2 and var_52_3 and var_52_3.infos then
			for iter_52_2, iter_52_3 in pairs(var_52_3.infos) do
				if iter_52_3.value > 0 then
					arg_52_0._redDotItems[#arg_52_0._redDotItems + 1] = iter_52_1
				end
			end
		end
	end
end

function var_0_0.addPerSecondRefresh(arg_53_0)
	TaskDispatcher.runRepeat(arg_53_0.everySecondCall, arg_53_0, 1)
end

function var_0_0.everySecondCall(arg_54_0)
	if not ViewHelper.instance:checkViewOnTheTop(arg_54_0.viewName, {
		ViewName.GMToolView
	}) then
		return
	end

	arg_54_0:refreshActvityItemsTimeInfo()
	arg_54_0:checkCurActivityIsEnd()
end

function var_0_0.addPerMinuteRefresh(arg_55_0)
	local var_55_0 = ServerTime.now()
	local var_55_1 = math.floor(var_55_0 % TimeUtil.OneMinuteSecond)

	if var_55_1 > 0 then
		TaskDispatcher.runDelay(arg_55_0._addPerMinuteRefresh, arg_55_0, TimeUtil.OneMinuteSecond - var_55_1 + 1)
	else
		arg_55_0:_addPerMinuteRefresh()
	end
end

function var_0_0._addPerMinuteRefresh(arg_56_0)
	arg_56_0:everyMinuteCall()
	TaskDispatcher.runRepeat(arg_56_0.everyMinuteCall, arg_56_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.everyMinuteCall(arg_57_0)
	if not ViewHelper.instance:checkViewOnTheTop(arg_57_0.viewName) then
		return
	end

	arg_57_0:refreshUI()
end

function var_0_0.clearTimerTask(arg_58_0)
	TaskDispatcher.cancelTask(arg_58_0.everyMinuteCall, arg_58_0)
	TaskDispatcher.cancelTask(arg_58_0._addPerMinuteRefresh, arg_58_0)
	TaskDispatcher.cancelTask(arg_58_0.everySecondCall, arg_58_0)
end

function var_0_0.checkIsSameAct(arg_59_0, arg_59_1, arg_59_2)
	if type(arg_59_1) == "table" then
		for iter_59_0, iter_59_1 in ipairs(arg_59_1) do
			if iter_59_1 == arg_59_2 then
				return true
			end
		end

		return false
	end

	return arg_59_1 == arg_59_2
end

function var_0_0.getActId(arg_60_0, arg_60_1)
	if type(arg_60_1) == "table" then
		for iter_60_0, iter_60_1 in ipairs(arg_60_1) do
			local var_60_0 = ActivityHelper.getActivityStatus(iter_60_1)

			if var_60_0 == ActivityEnum.ActivityStatus.Normal or var_60_0 == ActivityEnum.ActivityStatus.NotUnlock then
				return iter_60_1
			end
		end

		return arg_60_1[1]
	end

	return arg_60_1
end

return var_0_0
