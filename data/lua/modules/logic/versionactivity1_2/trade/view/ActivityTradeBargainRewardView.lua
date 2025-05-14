module("modules.logic.versionactivity1_2.trade.view.ActivityTradeBargainRewardView", package.seeall)

local var_0_0 = class("ActivityTradeBargainRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollrewards = gohelper.findChild(arg_1_0.viewGO, "#scroll_rewards")
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#scroll_rewards/Viewport/Content/#go_getall")
	arg_1_0._simagegetallbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#scroll_rewards/Viewport/Content/#go_getall/#simage_getallbg")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "#scroll_rewards/Viewport/Content/#go_rewarditem")

	gohelper.setActive(arg_1_0._gorewarditem, false)

	arg_1_0._btnClaimall = gohelper.findChildButtonWithAudio(arg_1_0._gogetall, "btn_claimall")

	arg_1_0._btnClaimall:AddClickListener(arg_1_0.onClickGetAllReward, arg_1_0)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._rewardItems = {}

	arg_4_0._simagegetallbg:LoadImage(ResUrl.getVersionTradeBargainBg("img_yijian"))
end

function var_0_0.onDestroyView(arg_5_0)
	UIBlockMgr.instance:endBlock("BargainReward")
	TaskDispatcher.cancelTask(arg_5_0._sendGetBonus, arg_5_0)
	arg_5_0._simagegetallbg:UnLoadImage()

	if arg_5_0._rewardItems then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._rewardItems) do
			iter_5_1:destory()
		end

		arg_5_0._rewardItems = nil
	end

	arg_5_0._btnClaimall:RemoveClickListener()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.actId = arg_6_0.viewContainer:getActId()

	arg_6_0:addEventCb(Activity117Controller.instance, Activity117Event.ReceiveInfos, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(Activity117Controller.instance, Activity117Event.ReceiveGetBonus, arg_6_0.onFinish, arg_6_0)
	arg_6_0:_refreshUI()
end

function var_0_0.onClose(arg_7_0)
	arg_7_0:removeEventCb(Activity117Controller.instance, Activity117Event.ReceiveInfos, arg_7_0.refreshUI, arg_7_0)
	arg_7_0:removeEventCb(Activity117Controller.instance, Activity117Event.ReceiveGetBonus, arg_7_0.onFinish, arg_7_0)
end

function var_0_0.refreshUI(arg_8_0, arg_8_1)
	if arg_8_1 ~= arg_8_0.actId then
		return
	end

	arg_8_0:refreshRewardItems()
end

function var_0_0._refreshUI(arg_9_0)
	arg_9_0:refreshRewardItems()
end

function var_0_0.onFinish(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= arg_10_0.actId then
		return
	end

	arg_10_0:refreshRewardItems()
end

function var_0_0.refreshRewardItems(arg_11_0)
	local var_11_0, var_11_1 = Activity117Model.instance:getRewardList(arg_11_0.actId)

	gohelper.setActive(arg_11_0._gogetall, var_11_1 > 1)

	for iter_11_0 = 1, math.max(#var_11_0, #arg_11_0._rewardItems) do
		local var_11_2 = arg_11_0._rewardItems[iter_11_0]

		if not var_11_2 then
			local var_11_3 = gohelper.cloneInPlace(arg_11_0._gorewarditem, "reward_item" .. tostring(iter_11_0))

			var_11_2 = ActivityTradeBargainRewardItem.New(var_11_3, arg_11_0._scrollrewards)
			arg_11_0._rewardItems[iter_11_0] = var_11_2
		end

		var_11_2:setData(var_11_0[iter_11_0])
	end
end

function var_0_0.onClickGetAllReward(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0._rewardItems) do
		if iter_12_1.data and iter_12_1.data:getStatus() == Activity117Enum.Status.CanGet then
			iter_12_1:onFinish()
		end
	end

	UIBlockMgr.instance:startBlock("BargainReward")
	TaskDispatcher.cancelTask(arg_12_0._sendGetBonus, arg_12_0)
	TaskDispatcher.runDelay(arg_12_0._sendGetBonus, arg_12_0, 0.6)
end

function var_0_0._sendGetBonus(arg_13_0)
	UIBlockMgr.instance:endBlock("BargainReward")
	Activity117Rpc.instance:sendAct117GetBonusRequest(arg_13_0.actId)
end

return var_0_0
