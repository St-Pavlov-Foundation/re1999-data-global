module("modules.logic.versionactivity2_1.activity165.view.Activity165StoryEnterView", package.seeall)

slot0 = class("Activity165StoryEnterView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_title")
	slot0._gostorynode = gohelper.findChild(slot0.viewGO, "#go_storynode")
	slot0._gostory1 = gohelper.findChild(slot0.viewGO, "#go_storynode/#go_story1")
	slot0._simagepic = gohelper.findChildSingleImage(slot0.viewGO, "#go_storynode/#go_story1/#simage_pic")
	slot0._simagepiclocked = gohelper.findChildSingleImage(slot0.viewGO, "#go_storynode/#go_story1/#simage_pic_locked")
	slot0._btnreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_review")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._gorewardwindow = gohelper.findChild(slot0.viewGO, "#go_rewardwindow")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rewardwindow/#btn_close")
	slot0._sliderprogress = gohelper.findChildSlider(slot0.viewGO, "#go_rewardwindow/Content/#slider_progress")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "#go_rewardwindow/Content/#go_rewardContent")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "#go_rewardwindow/Content/#go_rewardContent/#go_rewarditem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreview:AddClickListener(slot0._btnreviewOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:_addEvents()
end

function slot0.removeEvents(slot0)
	slot0._btnreview:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0:_removeEvents()
end

function slot0._btnclickOnClick(slot0)
end

function slot0._btnrewordOnClick(slot0)
end

function slot0._btnreviewOnClick(slot0)
	Activity165Controller.instance:openActivity165ReviewView(Activity165Model.instance:getEndingRedDotIndex() or 1, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:_onCloseRewardWindow()
end

function slot0._editableInitView(slot0)
	slot0._goReward = gohelper.findChild(slot0.viewGO, "#go_rewardwindow/Content")
	slot0._goreviewreddot = gohelper.findChild(slot0.viewGO, "#btn_review/#go_reddot")
	slot0._contentBg = gohelper.findChild(slot0.viewGO, "#go_rewardwindow/Content/bg")
	slot0._progressbg = gohelper.findChild(slot0.viewGO, "#go_rewardwindow/Content/#slider_progress/Background")

	gohelper.setActive(slot0._gorewarditem, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0._addEvents(slot0)
	slot0:addEventCb(Activity165Controller.instance, Activity165Event.Act165GetInfoReply, slot0._onGetInfo, slot0)
	slot0:addEventCb(Activity165Controller.instance, Activity165Event.Act165GainMilestoneRewardReply, slot0._Act165GainMilestoneRewardReply, slot0)
	slot0:addEventCb(Activity165Controller.instance, Activity165Event.Act165GenerateEndingReply, slot0._Act165GenerateEndingReply, slot0)
	slot0:addEventCb(Activity165Controller.instance, Activity165Event.onClickOpenStoryRewardBtn, slot0._onClickOpenStoryRewardBtn, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivity, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(Activity165Controller.instance, Activity165Event.Act165GetInfoReply, slot0._onGetInfo, slot0)
	slot0:removeEventCb(Activity165Controller.instance, Activity165Event.Act165GainMilestoneRewardReply, slot0._Act165GainMilestoneRewardReply, slot0)
	slot0:removeEventCb(Activity165Controller.instance, Activity165Event.Act165GenerateEndingReply, slot0._Act165GenerateEndingReply, slot0)
	slot0:removeEventCb(Activity165Controller.instance, Activity165Event.onClickOpenStoryRewardBtn, slot0._onClickOpenStoryRewardBtn, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivity, slot0)
end

function slot0._onGetInfo(slot0, slot1)
	for slot5 = 1, 3 do
		slot0:_refreshStoryItem(slot5)
	end

	slot0:_refreshView()
end

function slot0._Act165GainMilestoneRewardReply(slot0, slot1)
	slot3 = slot1.storyId

	slot0:_getStoryItem(slot3):refreshRewardState()
	slot0:_onRefreshRewardItems(slot1.activityId, slot3)
	slot0:_refreshProgress(slot1.gainedEndingCount)
end

function slot0._onClickOpenStoryRewardBtn(slot0, slot1)
	slot0:_onOpenRewardWindow(slot1)
end

function slot0._Act165GenerateEndingReply(slot0, slot1)
	slot3 = slot1.storyId

	slot0:_checkRedDot()
	slot0:_refreshStoryItem(slot3)
	slot0:_onRefreshRewardItems(slot1.activityId, slot3)
	gohelper.setActive(slot0._btnreview.gameObject, true)
end

function slot0.onOpen(slot0)
	slot0._rewardsItemList = slot0:getUserDataTb_()
	slot0._storyItemList = slot0:getUserDataTb_()

	slot0:_checkRedDot()
	slot0:_onCloseRewardWindow()

	slot0._actId = Activity165Model.instance:getActivityId()

	slot0:_refreshView()
end

function slot0._refreshStoryItem(slot0, slot1)
	slot0:_getStoryItem(slot1):onUpdateMO(Activity165Model.instance:getStoryMo(slot0._actId, slot1), slot1)
end

function slot0._getStoryItem(slot0, slot1)
	if not slot0._storyItemList[slot1] then
		slot0._storyItemList[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot0.viewGO, "#go_storynode/#go_story" .. slot1), Activity165StoryItem)
	end

	return slot2
end

function slot0._refreshView(slot0)
	for slot4 = 1, 3 do
		slot0:_refreshStoryItem(slot4)
	end

	gohelper.setActive(slot0._btnreview.gameObject, Activity165Model.instance:isHasUnlockEnding())
end

function slot0._onCloseRewardWindow(slot0)
	gohelper.setActive(slot0._gorewardwindow, false)
end

slot1 = {
	-750,
	-100,
	346.3
}

function slot0._onOpenRewardWindow(slot0, slot1)
	slot0:_onRefreshRewardItems(slot0._actId, slot1)

	slot0.storyMo = Activity165Model.instance:getStoryMo(slot0._actId, slot1)
	slot0.allRewardCount = slot0.storyMo:getAllEndingRewardCo() and tabletool.len(slot2) or 0

	slot0:_refreshProgress(slot0.storyMo:getclaimRewardCount() or 0)
	recthelper.setWidth(slot0._contentBg.transform, GameUtil.clamp(slot0.allRewardCount * 250, 500, 672))

	slot5 = 203 * (slot0.allRewardCount - 1)

	recthelper.setWidth(slot0._sliderprogress.transform, slot5)
	recthelper.setWidth(slot0._progressbg.transform, slot5)
	transformhelper.setLocalPosXY(slot0._goReward.transform, uv0[slot1], -376.9)
	gohelper.setActive(slot0._gorewardwindow, true)
	slot0:_getRewarfItem(slot1):checkBonus()
end

function slot0._refreshProgress(slot0, slot1)
	slot0._sliderprogress:SetValue(GameUtil.clamp((slot1 - 1) / (slot0.allRewardCount - 1), 0, 1))
end

function slot0._onRefreshRewardItems(slot0, slot1, slot2)
	slot5 = 1

	if Activity165Model.instance:getStoryMo(slot1, slot2):getAllEndingRewardCo() then
		for slot9, slot10 in pairs(slot4) do
			slot0:_getRewarfItem(slot9):onUpdateParam(slot5, slot10)

			slot5 = slot5 + 1
		end
	end

	if (slot4 and #slot4 or 0) < (slot0._rewardsItemList and #slot0._rewardsItemList or 0) then
		for slot11, slot12 in pairs(slot0._rewardsItemList) do
			if slot6 < slot11 then
				gohelper.setActive(slot12.viewGO, false)
			end
		end
	end
end

function slot0._getRewarfItem(slot0, slot1)
	if not slot0._rewardsItemList[slot1] then
		slot0._rewardsItemList[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._gorewarditem, "item_" .. slot1), Activity165StoryRewardItem)
	end

	return slot2
end

function slot0.onRefreshActivity(slot0, slot1)
	if slot1 == Activity165Model.instance:getActivityId() and not (ActivityHelper.getActivityStatusAndToast(slot1) == ActivityEnum.ActivityStatus.Normal) then
		slot0:closeThis()
		GameFacade.showToast(ToastEnum.ActivityEnd)
	end
end

function slot0._checkRedDot(slot0)
	gohelper.setActive(slot0._goreviewreddot, Activity165Model.instance:getEndingRedDotIndex() ~= nil)
end

function slot0.onClose(slot0)
	Activity165Controller.instance:dispatchEvent(Activity165Event.refreshStoryReddot)
end

function slot0.onDestroyView(slot0)
end

return slot0
