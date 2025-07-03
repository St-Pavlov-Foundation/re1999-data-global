module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandLevelViewContainer", package.seeall)

local var_0_0 = class("CooperGarlandLevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._levelView = CooperGarlandLevelView.New()

	table.insert(var_1_0, arg_1_0._levelView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.setVisibleInternal(arg_3_0, arg_3_1)
	var_0_0.super.setVisibleInternal(arg_3_0, arg_3_1)

	arg_3_0._levelView.openAnimComplete = false

	if arg_3_1 then
		arg_3_0:playAnim(UIAnimationName.Open, arg_3_0._playOpenAnimFinish, arg_3_0)
	end
end

function var_0_0._playOpenAnimFinish(arg_4_0)
	if not arg_4_0._levelView then
		return
	end

	arg_4_0._levelView.openAnimComplete = true

	arg_4_0._levelView:playEpisodeFinishAnim()
end

function var_0_0.playAnim(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_5_0.viewGO)

	if arg_5_0.animatorPlayer then
		arg_5_0.animatorPlayer:Play(arg_5_1, arg_5_2, arg_5_3)
	end
end

return var_0_0
