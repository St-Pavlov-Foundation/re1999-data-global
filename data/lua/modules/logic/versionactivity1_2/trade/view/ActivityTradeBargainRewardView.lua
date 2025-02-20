module("modules.logic.versionactivity1_2.trade.view.ActivityTradeBargainRewardView", package.seeall)

slot0 = class("ActivityTradeBargainRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollrewards = gohelper.findChild(slot0.viewGO, "#scroll_rewards")
	slot0._gogetall = gohelper.findChild(slot0.viewGO, "#scroll_rewards/Viewport/Content/#go_getall")
	slot0._simagegetallbg = gohelper.findChildSingleImage(slot0.viewGO, "#scroll_rewards/Viewport/Content/#go_getall/#simage_getallbg")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "#scroll_rewards/Viewport/Content/#go_rewarditem")

	gohelper.setActive(slot0._gorewarditem, false)

	slot0._btnClaimall = gohelper.findChildButtonWithAudio(slot0._gogetall, "btn_claimall")

	slot0._btnClaimall:AddClickListener(slot0.onClickGetAllReward, slot0)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._rewardItems = {}

	slot0._simagegetallbg:LoadImage(ResUrl.getVersionTradeBargainBg("img_yijian"))
end

function slot0.onDestroyView(slot0)
	UIBlockMgr.instance:endBlock("BargainReward")
	TaskDispatcher.cancelTask(slot0._sendGetBonus, slot0)
	slot0._simagegetallbg:UnLoadImage()

	if slot0._rewardItems then
		for slot4, slot5 in pairs(slot0._rewardItems) do
			slot5:destory()
		end

		slot0._rewardItems = nil
	end

	slot0._btnClaimall:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewContainer:getActId()

	slot0:addEventCb(Activity117Controller.instance, Activity117Event.ReceiveInfos, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity117Controller.instance, Activity117Event.ReceiveGetBonus, slot0.onFinish, slot0)
	slot0:_refreshUI()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(Activity117Controller.instance, Activity117Event.ReceiveInfos, slot0.refreshUI, slot0)
	slot0:removeEventCb(Activity117Controller.instance, Activity117Event.ReceiveGetBonus, slot0.onFinish, slot0)
end

function slot0.refreshUI(slot0, slot1)
	if slot1 ~= slot0.actId then
		return
	end

	slot0:refreshRewardItems()
end

function slot0._refreshUI(slot0)
	slot0:refreshRewardItems()
end

function slot0.onFinish(slot0, slot1, slot2)
	if slot1 ~= slot0.actId then
		return
	end

	slot0:refreshRewardItems()
end

function slot0.refreshRewardItems(slot0)
	slot1, slot2 = Activity117Model.instance:getRewardList(slot0.actId)

	gohelper.setActive(slot0._gogetall, slot2 > 1)

	slot6 = #slot1

	for slot6 = 1, math.max(slot6, #slot0._rewardItems) do
		if not slot0._rewardItems[slot6] then
			slot0._rewardItems[slot6] = ActivityTradeBargainRewardItem.New(gohelper.cloneInPlace(slot0._gorewarditem, "reward_item" .. tostring(slot6)), slot0._scrollrewards)
		end

		slot7:setData(slot1[slot6])
	end
end

function slot0.onClickGetAllReward(slot0)
	for slot4, slot5 in ipairs(slot0._rewardItems) do
		if slot5.data and slot5.data:getStatus() == Activity117Enum.Status.CanGet then
			slot5:onFinish()
		end
	end

	UIBlockMgr.instance:startBlock("BargainReward")
	TaskDispatcher.cancelTask(slot0._sendGetBonus, slot0)
	TaskDispatcher.runDelay(slot0._sendGetBonus, slot0, 0.6)
end

function slot0._sendGetBonus(slot0)
	UIBlockMgr.instance:endBlock("BargainReward")
	Activity117Rpc.instance:sendAct117GetBonusRequest(slot0.actId)
end

return slot0
