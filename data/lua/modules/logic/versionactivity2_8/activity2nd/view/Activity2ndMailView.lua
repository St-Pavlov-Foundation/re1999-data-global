module("modules.logic.versionactivity2_8.activity2nd.view.Activity2ndMailView", package.seeall)

local var_0_0 = class("Activity2ndMailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simagePaper3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#simage_Paper3")
	arg_1_0._simagePaper2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#simage_Paper2")
	arg_1_0._simagePaper1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#simage_Paper1")
	arg_1_0._scrollDescr = gohelper.findChildScrollRect(arg_1_0.viewGO, "Panel/#scroll_Descr")
	arg_1_0._scrollReward = gohelper.findChildScrollRect(arg_1_0.viewGO, "Panel/#scroll_Reward")
	arg_1_0._gorewarditemcontent = gohelper.findChild(arg_1_0.viewGO, "Panel/#scroll_Reward/Viewport/Content")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "Panel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	arg_1_0._btnclose = gohelper.findChildButton(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.onRefreshActivity, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._rewardList = {}
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.refreshUI(arg_6_0)
	if arg_6_0:checkReceied() then
		arg_6_0:setReceived()
	end
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._actId = arg_7_0.viewParam.actId

	Activity101Rpc.instance:sendGet101InfosRequest(arg_7_0._actId, arg_7_0._tryGetReward, arg_7_0)

	arg_7_0._config = ActivityConfig.instance:getNorSignActivityCo(arg_7_0._actId, 1)

	if not arg_7_0._config then
		logError("没有活动" .. arg_7_0._actId .. "的配置")

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
	arg_7_0:_initReward()
	arg_7_0:_tryGetReward()
end

function var_0_0._tryGetReward(arg_8_0)
	if arg_8_0:checkCanGet() then
		TaskDispatcher.runDelay(arg_8_0._getReward, arg_8_0, 0.8)
	end
end

function var_0_0._getReward(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._getReward, arg_9_0)
	Activity101Rpc.instance:sendGet101BonusRequest(arg_9_0._actId, 1)
end

function var_0_0._initReward(arg_10_0)
	local var_10_0 = GameUtil.splitString2(arg_10_0._config.bonus, true)

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if not arg_10_0._rewardList[iter_10_0] then
			local var_10_1 = arg_10_0:getUserDataTb_()

			var_10_1.go = gohelper.clone(arg_10_0._gorewarditem, arg_10_0._gorewarditemcontent, "reward" .. iter_10_0)
			var_10_1.goreceive = gohelper.findChild(var_10_1.go, "go_receive")
			var_10_1.goitem = gohelper.findChild(var_10_1.go, "go_icon")
			var_10_1.gocanget = gohelper.findChild(var_10_1.go, "go_canget")
			var_10_1.goitemcomp = IconMgr.instance:getCommonPropItemIcon(var_10_1.goitem)

			if iter_10_1 and #iter_10_1 > 0 then
				var_10_1.goitemcomp:setMOValue(iter_10_1[1], iter_10_1[2], iter_10_1[3], nil, true)
			end

			gohelper.setActive(var_10_1.go, true)
			table.insert(arg_10_0._rewardList, var_10_1)
		end
	end
end

function var_0_0._onCloseView(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.CommonPropView then
		arg_11_0:setReceived()
	end
end

function var_0_0.setReceived(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0._rewardList) do
		gohelper.setActive(iter_12_1.goreceive, true)
		gohelper.setActive(iter_12_1.gocanget, false)
	end
end

function var_0_0.checkReceied(arg_13_0)
	return (ActivityType101Model.instance:isType101RewardGet(arg_13_0._actId, 1))
end

function var_0_0.checkCanGet(arg_14_0)
	return (ActivityType101Model.instance:isType101RewardCouldGet(arg_14_0._actId, 1))
end

function var_0_0.onClose(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._getReward, arg_15_0)
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

function var_0_0.onRefreshActivity(arg_17_0)
	local var_17_0 = ActivityHelper.getActivityStatus(arg_17_0._actId)

	if var_17_0 == ActivityEnum.ActivityStatus.NotOnLine or var_17_0 == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

return var_0_0
