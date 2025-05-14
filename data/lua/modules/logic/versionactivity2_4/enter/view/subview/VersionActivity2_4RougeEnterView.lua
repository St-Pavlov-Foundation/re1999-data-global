module("modules.logic.versionactivity2_4.enter.view.subview.VersionActivity2_4RougeEnterView", package.seeall)

local var_0_0 = class("VersionActivity2_4RougeEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_start")
	arg_1_0._btnReward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_reward")
	arg_1_0._goRewardNew = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_reward/#go_new")
	arg_1_0._txtRewardNum = gohelper.findChildText(arg_1_0.viewGO, "Right/#btn_reward/#txt_RewardNum")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Right/txt_Descr")
	arg_1_0._btnlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_locked")
	arg_1_0._txtUnlockedTips = gohelper.findChildText(arg_1_0.viewGO, "Right/#btn_locked/#txt_UnLockedTips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._btnEnterOnClick, arg_2_0)
	arg_2_0._btnReward:AddClickListener(arg_2_0._btnRewardOnClick, arg_2_0)
	arg_2_0._btnlock:AddClickListener(arg_2_0._btnLockOnClick, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, arg_2_0.refreshReward, arg_2_0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, arg_2_0.refreshLock, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEnter:RemoveClickListener()
	arg_3_0._btnReward:RemoveClickListener()
	arg_3_0._btnlock:RemoveClickListener()
	arg_3_0:removeEventCb(RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, arg_3_0.refreshReward, arg_3_0)
	OpenController.instance:unregisterCallback(OpenEvent.NewFuncUnlock, arg_3_0.refreshLock, arg_3_0)
end

function var_0_0._btnEnterOnClick(arg_4_0)
	RougeController.instance:openRougeMainView()
end

function var_0_0._btnRewardOnClick(arg_5_0)
	RougeController.instance:openRougeRewardView()
end

function var_0_0._btnLockOnClick(arg_6_0)
	local var_6_0, var_6_1 = OpenHelper.getToastIdAndParam(arg_6_0.config.openId)

	GameFacade.showToastWithTableParam(var_6_0, var_6_1)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.animComp = VersionActivitySubAnimatorComp.get(arg_7_0.viewGO, arg_7_0)
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._season = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(arg_8_0._season)
	arg_8_0.animComp:playOpenAnim()

	arg_8_0.config = ActivityConfig.instance:getActivityCo(VersionActivity2_1Enum.ActivityId.RougeDlc1)
	arg_8_0._txtDescr.text = arg_8_0.config.actDesc

	arg_8_0:refreshLock()
	arg_8_0:refreshReward()
end

function var_0_0.refreshLock(arg_9_0)
	local var_9_0 = arg_9_0.config.openId
	local var_9_1 = var_9_0 ~= 0 and not OpenModel.instance:isFunctionUnlock(var_9_0)

	gohelper.setActive(arg_9_0._btnlock, var_9_1)
	gohelper.setActive(arg_9_0._btnReward.gameObject, not var_9_1)

	if var_9_1 then
		local var_9_2, var_9_3 = OpenHelper.getToastIdAndParam(arg_9_0.config.openId)
		local var_9_4 = ToastConfig.instance:getToastCO(var_9_2).tips
		local var_9_5 = GameUtil.getSubPlaceholderLuaLang(var_9_4, var_9_3)

		arg_9_0._txtUnlockedTips.text = var_9_5
	else
		arg_9_0._txtUnlockedTips.text = ""
	end
end

function var_0_0.refreshReward(arg_10_0)
	arg_10_0._txtRewardNum.text = RougeRewardModel.instance:getRewardPoint()

	local var_10_0 = RougeRewardModel.instance:checkIsNewStage()

	gohelper.setActive(arg_10_0._goRewardNew, var_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0.animComp:destroy()
end

return var_0_0
