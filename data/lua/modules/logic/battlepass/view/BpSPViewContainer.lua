module("modules.logic.battlepass.view.BpSPViewContainer", package.seeall)

local var_0_0 = class("BpSPViewContainer", BaseViewContainer)
local var_0_1 = 1
local var_0_2 = 2

function var_0_0.buildViews(arg_1_0)
	return {
		BpBuyBtn.New(),
		TabViewGroup.New(var_0_1, "#go_btns"),
		BPTabViewGroup.New(var_0_2, "#go_container"),
		BpSPView.New()
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
			BpSPBonusView.New()
		}
	end
end

function var_0_0.playOpenTransition(arg_3_0)
	local var_3_0 = "open"

	if arg_3_0.viewParam and arg_3_0.viewParam.isSwitch then
		var_3_0 = "switch"
	end

	var_0_0.super.playOpenTransition(arg_3_0, {
		duration = 1,
		anim = var_3_0
	})
end

function var_0_0.playCloseTransition(arg_4_0)
	arg_4_0:onPlayCloseTransitionFinish()
end

return var_0_0
