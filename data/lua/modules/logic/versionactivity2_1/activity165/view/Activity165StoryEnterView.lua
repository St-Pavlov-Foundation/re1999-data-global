module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryEnterView", package.seeall)

local var_0_0 = class("Activity165StoryEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")
	arg_1_0._gostorynode = gohelper.findChild(arg_1_0.viewGO, "#go_storynode")
	arg_1_0._gostory1 = gohelper.findChild(arg_1_0.viewGO, "#go_storynode/#go_story1")
	arg_1_0._simagepic = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_storynode/#go_story1/#simage_pic")
	arg_1_0._simagepiclocked = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_storynode/#go_story1/#simage_pic_locked")
	arg_1_0._btnreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_review")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._gorewardwindow = gohelper.findChild(arg_1_0.viewGO, "#go_rewardwindow")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rewardwindow/#btn_close")
	arg_1_0._sliderprogress = gohelper.findChildSlider(arg_1_0.viewGO, "#go_rewardwindow/Content/#slider_progress")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "#go_rewardwindow/Content/#go_rewardContent")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "#go_rewardwindow/Content/#go_rewardContent/#go_rewarditem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreview:AddClickListener(arg_2_0._btnreviewOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:_addEvents()
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreview:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:_removeEvents()
end

function var_0_0._btnclickOnClick(arg_4_0)
	return
end

function var_0_0._btnrewordOnClick(arg_5_0)
	return
end

function var_0_0._btnreviewOnClick(arg_6_0)
	local var_6_0 = Activity165Model.instance:getEndingRedDotIndex() or 1

	Activity165Controller.instance:openActivity165ReviewView(var_6_0, arg_6_0)
end

function var_0_0._btncloseOnClick(arg_7_0)
	arg_7_0:_onCloseRewardWindow()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._goReward = gohelper.findChild(arg_8_0.viewGO, "#go_rewardwindow/Content")
	arg_8_0._goreviewreddot = gohelper.findChild(arg_8_0.viewGO, "#btn_review/#go_reddot")
	arg_8_0._contentBg = gohelper.findChild(arg_8_0.viewGO, "#go_rewardwindow/Content/bg")
	arg_8_0._progressbg = gohelper.findChild(arg_8_0.viewGO, "#go_rewardwindow/Content/#slider_progress/Background")

	gohelper.setActive(arg_8_0._gorewarditem, false)
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0._addEvents(arg_10_0)
	arg_10_0:addEventCb(Activity165Controller.instance, Activity165Event.Act165GetInfoReply, arg_10_0._onGetInfo, arg_10_0)
	arg_10_0:addEventCb(Activity165Controller.instance, Activity165Event.Act165GainMilestoneRewardReply, arg_10_0._Act165GainMilestoneRewardReply, arg_10_0)
	arg_10_0:addEventCb(Activity165Controller.instance, Activity165Event.Act165GenerateEndingReply, arg_10_0._Act165GenerateEndingReply, arg_10_0)
	arg_10_0:addEventCb(Activity165Controller.instance, Activity165Event.onClickOpenStoryRewardBtn, arg_10_0._onClickOpenStoryRewardBtn, arg_10_0)
	arg_10_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_10_0.onRefreshActivity, arg_10_0)
end

function var_0_0._removeEvents(arg_11_0)
	arg_11_0:removeEventCb(Activity165Controller.instance, Activity165Event.Act165GetInfoReply, arg_11_0._onGetInfo, arg_11_0)
	arg_11_0:removeEventCb(Activity165Controller.instance, Activity165Event.Act165GainMilestoneRewardReply, arg_11_0._Act165GainMilestoneRewardReply, arg_11_0)
	arg_11_0:removeEventCb(Activity165Controller.instance, Activity165Event.Act165GenerateEndingReply, arg_11_0._Act165GenerateEndingReply, arg_11_0)
	arg_11_0:removeEventCb(Activity165Controller.instance, Activity165Event.onClickOpenStoryRewardBtn, arg_11_0._onClickOpenStoryRewardBtn, arg_11_0)
	arg_11_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_11_0.onRefreshActivity, arg_11_0)
end

function var_0_0._onGetInfo(arg_12_0, arg_12_1)
	for iter_12_0 = 1, 3 do
		arg_12_0:_refreshStoryItem(iter_12_0)
	end

	arg_12_0:_refreshView()
end

function var_0_0._Act165GainMilestoneRewardReply(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.activityId
	local var_13_1 = arg_13_1.storyId
	local var_13_2 = arg_13_1.gainedEndingCount

	arg_13_0:_getStoryItem(var_13_1):refreshRewardState()
	arg_13_0:_onRefreshRewardItems(var_13_0, var_13_1)
	arg_13_0:_refreshProgress(var_13_2)
end

function var_0_0._onClickOpenStoryRewardBtn(arg_14_0, arg_14_1)
	arg_14_0:_onOpenRewardWindow(arg_14_1)
end

function var_0_0._Act165GenerateEndingReply(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1.activityId
	local var_15_1 = arg_15_1.storyId

	arg_15_0:_checkRedDot()
	arg_15_0:_refreshStoryItem(var_15_1)
	arg_15_0:_onRefreshRewardItems(var_15_0, var_15_1)
	gohelper.setActive(arg_15_0._btnreview.gameObject, true)
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0._rewardsItemList = arg_16_0:getUserDataTb_()
	arg_16_0._storyItemList = arg_16_0:getUserDataTb_()

	arg_16_0:_checkRedDot()
	arg_16_0:_onCloseRewardWindow()

	arg_16_0._actId = Activity165Model.instance:getActivityId()

	arg_16_0:_refreshView()
end

function var_0_0._refreshStoryItem(arg_17_0, arg_17_1)
	local var_17_0 = Activity165Model.instance:getStoryMo(arg_17_0._actId, arg_17_1)

	arg_17_0:_getStoryItem(arg_17_1):onUpdateMO(var_17_0, arg_17_1)
end

function var_0_0._getStoryItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._storyItemList[arg_18_1]

	if not var_18_0 then
		local var_18_1 = gohelper.findChild(arg_18_0.viewGO, "#go_storynode/#go_story" .. arg_18_1)

		var_18_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_18_1, Activity165StoryItem)
		arg_18_0._storyItemList[arg_18_1] = var_18_0
	end

	return var_18_0
end

function var_0_0._refreshView(arg_19_0)
	for iter_19_0 = 1, 3 do
		arg_19_0:_refreshStoryItem(iter_19_0)
	end

	gohelper.setActive(arg_19_0._btnreview.gameObject, Activity165Model.instance:isHasUnlockEnding())
end

function var_0_0._onCloseRewardWindow(arg_20_0)
	gohelper.setActive(arg_20_0._gorewardwindow, false)
end

local var_0_1 = {
	-750,
	-100,
	346.3
}

function var_0_0._onOpenRewardWindow(arg_21_0, arg_21_1)
	arg_21_0:_onRefreshRewardItems(arg_21_0._actId, arg_21_1)

	arg_21_0.storyMo = Activity165Model.instance:getStoryMo(arg_21_0._actId, arg_21_1)

	local var_21_0 = arg_21_0.storyMo:getAllEndingRewardCo()

	arg_21_0.allRewardCount = var_21_0 and tabletool.len(var_21_0) or 0

	local var_21_1 = arg_21_0.storyMo:getclaimRewardCount() or 0

	arg_21_0:_refreshProgress(var_21_1)

	local var_21_2 = arg_21_0.allRewardCount * 250
	local var_21_3 = GameUtil.clamp(var_21_2, 500, 672)

	recthelper.setWidth(arg_21_0._contentBg.transform, var_21_3)

	local var_21_4 = 203 * (arg_21_0.allRewardCount - 1)

	recthelper.setWidth(arg_21_0._sliderprogress.transform, var_21_4)
	recthelper.setWidth(arg_21_0._progressbg.transform, var_21_4)
	transformhelper.setLocalPosXY(arg_21_0._goReward.transform, var_0_1[arg_21_1], -376.9)
	gohelper.setActive(arg_21_0._gorewardwindow, true)
	arg_21_0:_getRewarfItem(arg_21_1):checkBonus()
end

function var_0_0._refreshProgress(arg_22_0, arg_22_1)
	local var_22_0 = (arg_22_1 - 1) / (arg_22_0.allRewardCount - 1)

	arg_22_0._sliderprogress:SetValue(GameUtil.clamp(var_22_0, 0, 1))
end

function var_0_0._onRefreshRewardItems(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = Activity165Model.instance:getStoryMo(arg_23_1, arg_23_2):getAllEndingRewardCo()
	local var_23_1 = 1

	if var_23_0 then
		for iter_23_0, iter_23_1 in pairs(var_23_0) do
			arg_23_0:_getRewarfItem(iter_23_0):onUpdateParam(var_23_1, iter_23_1)

			var_23_1 = var_23_1 + 1
		end
	end

	local var_23_2 = var_23_0 and #var_23_0 or 0

	if var_23_2 < (arg_23_0._rewardsItemList and #arg_23_0._rewardsItemList or 0) then
		for iter_23_2, iter_23_3 in pairs(arg_23_0._rewardsItemList) do
			if var_23_2 < iter_23_2 then
				gohelper.setActive(iter_23_3.viewGO, false)
			end
		end
	end
end

function var_0_0._getRewarfItem(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._rewardsItemList[arg_24_1]

	if not var_24_0 then
		local var_24_1 = gohelper.cloneInPlace(arg_24_0._gorewarditem, "item_" .. arg_24_1)

		var_24_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_24_1, Activity165StoryRewardItem)
		arg_24_0._rewardsItemList[arg_24_1] = var_24_0
	end

	return var_24_0
end

function var_0_0.onRefreshActivity(arg_25_0, arg_25_1)
	if arg_25_1 == Activity165Model.instance:getActivityId() and not (ActivityHelper.getActivityStatusAndToast(arg_25_1) == ActivityEnum.ActivityStatus.Normal) then
		arg_25_0:closeThis()
		GameFacade.showToast(ToastEnum.ActivityEnd)
	end
end

function var_0_0._checkRedDot(arg_26_0)
	gohelper.setActive(arg_26_0._goreviewreddot, Activity165Model.instance:getEndingRedDotIndex() ~= nil)
end

function var_0_0.onClose(arg_27_0)
	Activity165Controller.instance:dispatchEvent(Activity165Event.refreshStoryReddot)
end

function var_0_0.onDestroyView(arg_28_0)
	return
end

return var_0_0
