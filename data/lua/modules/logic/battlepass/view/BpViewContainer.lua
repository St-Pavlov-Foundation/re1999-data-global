module("modules.logic.battlepass.view.BpViewContainer", package.seeall)

local var_0_0 = class("BpViewContainer", BaseViewContainer)
local var_0_1 = 1
local var_0_2 = 2

function var_0_0.buildViews(arg_1_0)
	BpModel.instance.isViewLoading = true

	return {
		BpBuyBtn.New(),
		TabViewGroup.New(var_0_1, "#go_btns"),
		BPTabViewGroup.New(var_0_2, "#go_container"),
		BpView.New(),
		ToggleListView.New(var_0_2, "right/toggleGroup")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == var_0_1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0._navigateButtonView
		}
	elseif arg_2_1 == var_0_2 then
		return {
			BpBonusView.New(),
			BpTaskView.New()
		}
	end
end

function var_0_0.playOpenTransition(arg_3_0)
	local var_3_0 = "tarotopen"
	local var_3_1 = 1

	if arg_3_0.viewParam and arg_3_0.viewParam.isSwitch then
		var_3_0 = "switch"
	end

	local var_3_2 = not arg_3_0.viewParam or arg_3_0.viewParam.isPlayDayFirstAnim

	if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay and TimeUtil.getWeekFirstLoginRed("BpViewOpenAnim") and TimeUtil.getDayFirstLoginRed("BpViewOpenAnim") then
		if var_3_2 then
			AudioMgr.instance:trigger(AudioEnum2_6.BP.BpDayFirstAnim)
			UIBlockMgrExtend.setNeedCircleMv(false)

			var_3_0 = "tarotopen1"
			var_3_1 = 3

			TimeUtil.setWeekFirstLoginRed("BpViewOpenAnim")
		else
			ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_3_0._checkPlayDayAnim, arg_3_0)
		end
	end

	var_0_0.super.playOpenTransition(arg_3_0, {
		anim = var_3_0,
		duration = var_3_1
	})
end

function var_0_0._checkPlayDayAnim(arg_4_0)
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.BpView) then
		return
	end

	if arg_4_0.viewParam and not arg_4_0.viewParam.isPlayDayFirstAnim then
		arg_4_0.viewParam.isPlayDayFirstAnim = true
	end

	arg_4_0:playOpenTransition()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_4_0._checkPlayDayAnim, arg_4_0)
end

function var_0_0.onPlayOpenTransitionFinish(arg_5_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	var_0_0.super.onPlayOpenTransitionFinish(arg_5_0)
end

function var_0_0.playCloseTransition(arg_6_0)
	arg_6_0:onPlayCloseTransitionFinish()
end

function var_0_0.onContainerClose(arg_7_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_7_0._checkPlayDayAnim, arg_7_0)
	var_0_0.super.onContainerClose(arg_7_0)
end

return var_0_0
