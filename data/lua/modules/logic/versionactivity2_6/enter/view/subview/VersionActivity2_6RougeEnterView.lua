module("modules.logic.versionactivity2_6.enter.view.subview.VersionActivity2_6RougeEnterView", package.seeall)

local var_0_0 = class("VersionActivity2_6RougeEnterView", BaseView)
local var_0_1 = 103

function var_0_0._gostartreddotRefreshCb(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:forceCheckDotIsShow()

	gohelper.setActive(arg_1_0._gostartreddot, var_1_0)
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._btnEnter = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "Right/#btn_start")
	arg_2_0._btnReward = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "Right/#btn_reward")
	arg_2_0._goRewardNew = gohelper.findChild(arg_2_0.viewGO, "Right/#btn_reward/#go_new")
	arg_2_0._txtRewardNum = gohelper.findChildText(arg_2_0.viewGO, "Right/#btn_reward/#txt_RewardNum")
	arg_2_0._btnlock = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "Right/#btn_locked")
	arg_2_0._txtUnlockedTips = gohelper.findChildText(arg_2_0.viewGO, "Right/#btn_locked/#txt_UnLockedTips")
	arg_2_0._btndlc = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "Right/#btn_dlc")
	arg_2_0._gostartreddot = gohelper.findChild(arg_2_0.viewGO, "Right/#btn_start/#go_new")
	arg_2_0._goclosetipseffect = gohelper.findChild(arg_2_0.viewGO, "Right/vx_glow")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnEnter:AddClickListener(arg_3_0._btnEnterOnClick, arg_3_0)
	arg_3_0._btnReward:AddClickListener(arg_3_0._btnRewardOnClick, arg_3_0)
	arg_3_0._btnlock:AddClickListener(arg_3_0._btnLockOnClick, arg_3_0)
	arg_3_0._btndlc:AddClickListener(arg_3_0._btndlcOnClick, arg_3_0)
	arg_3_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, arg_3_0.refreshReward, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinishCallback, arg_3_0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, arg_3_0.refreshLock, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnEnter:RemoveClickListener()
	arg_4_0._btnReward:RemoveClickListener()
	arg_4_0._btnlock:RemoveClickListener()
	arg_4_0._btndlc:RemoveClickListener()
	arg_4_0:removeEventCb(RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, arg_4_0.refreshReward, arg_4_0)
	OpenController.instance:unregisterCallback(OpenEvent.NewFuncUnlock, arg_4_0.refreshLock, arg_4_0)
end

function var_0_0._btnEnterOnClick(arg_5_0)
	RougeController.instance:openRougeMainView()
end

function var_0_0._btnRewardOnClick(arg_6_0)
	RougeController.instance:openRougeRewardView()
end

function var_0_0._btnLockOnClick(arg_7_0)
	local var_7_0, var_7_1 = OpenHelper.getToastIdAndParam(arg_7_0.config.openId)

	GameFacade.showToastWithTableParam(var_7_0, var_7_1)
end

function var_0_0._btndlcOnClick(arg_8_0)
	if not var_0_1 or var_0_1 == 0 then
		return
	end

	local var_8_0 = {
		dlcId = var_0_1
	}

	ViewMgr.instance:openView(ViewName.RougeDLCTipsView, var_8_0)
	gohelper.setActive(arg_8_0._goclosetipseffect, false)
end

function var_0_0._editableInitView(arg_9_0)
	gohelper.setActive(arg_9_0._gostartreddot, false)
	RougeOutsideController.instance:initDLCReddotInfo()

	arg_9_0.animComp = VersionActivitySubAnimatorComp.get(arg_9_0.viewGO, arg_9_0)

	RedDotController.instance:addRedDot(arg_9_0._gostartreddot, RedDotEnum.DotNode.RougeDLCNew, nil, arg_9_0._gostartreddotRefreshCb, arg_9_0)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._season = RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(arg_10_0._season)
	arg_10_0.animComp:playOpenAnim()

	arg_10_0.actId = arg_10_0.viewContainer.activityId
	arg_10_0.config = ActivityConfig.instance:getActivityCo(arg_10_0.actId)

	arg_10_0:refreshLock()
	arg_10_0:refreshReward()
	arg_10_0:checkOpenDLCTipsView()
end

function var_0_0.refreshLock(arg_11_0)
	local var_11_0 = arg_11_0.config.openId
	local var_11_1 = var_11_0 ~= 0 and not OpenModel.instance:isFunctionUnlock(var_11_0)

	gohelper.setActive(arg_11_0._btnlock, var_11_1)
	gohelper.setActive(arg_11_0._btnReward.gameObject, not var_11_1)

	if var_11_1 then
		local var_11_2, var_11_3 = OpenHelper.getToastIdAndParam(arg_11_0.config.openId)
		local var_11_4 = ToastConfig.instance:getToastCO(var_11_2).tips
		local var_11_5 = GameUtil.getSubPlaceholderLuaLang(var_11_4, var_11_3)

		arg_11_0._txtUnlockedTips.text = var_11_5
	else
		arg_11_0._txtUnlockedTips.text = ""
	end
end

function var_0_0.refreshReward(arg_12_0)
	arg_12_0._txtRewardNum.text = RougeRewardModel.instance:getRewardPoint()

	local var_12_0 = RougeRewardModel.instance:checkIsNewStage()

	gohelper.setActive(arg_12_0._goRewardNew, var_12_0)
end

function var_0_0.checkOpenDLCTipsView(arg_13_0)
	if not var_0_1 or var_0_1 == 0 then
		return
	end

	local var_13_0 = string.format("%s#%s#%s", PlayerPrefsKey.RougePopUpDLCTipsId, PlayerModel.instance:getMyUserId(), var_0_1)

	if string.nilorempty(PlayerPrefsHelper.getString(var_13_0, "")) then
		local var_13_1 = {
			dlcId = var_0_1
		}

		ViewMgr.instance:openView(ViewName.RougeDLCTipsView, var_13_1)
		PlayerPrefsHelper.setString(var_13_0, "true")
	end
end

function var_0_0._onCloseViewFinishCallback(arg_14_0, arg_14_1)
	if arg_14_1 ~= ViewName.RougeDLCTipsView then
		return
	end

	gohelper.setActive(arg_14_0._goclosetipseffect, true)
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0.animComp:destroy()
end

return var_0_0
