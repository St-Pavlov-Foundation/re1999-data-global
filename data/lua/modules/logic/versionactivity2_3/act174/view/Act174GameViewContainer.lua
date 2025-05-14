module("modules.logic.versionactivity2_3.act174.view.Act174GameViewContainer", package.seeall)

local var_0_0 = class("Act174GameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.mainView = Act174GameView.New()

	table.insert(var_1_0, arg_1_0.mainView)
	table.insert(var_1_0, Act174GameShopView.New())
	table.insert(var_1_0, Act174GameWarehouseView.New())
	table.insert(var_1_0, Act174GameTeamView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		}, nil, arg_2_0.OnClickClose, nil, nil, arg_2_0)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.OnClickClose(arg_3_0)
	local var_3_0 = Activity174Model.instance:getCurActId()

	Activity174Controller.instance:syncLocalTeam2Server(var_3_0)
end

function var_0_0.playCloseTransition(arg_4_0)
	arg_4_0.mainView.anim:Play(UIAnimationName.Close)
	TaskDispatcher.runDelay(arg_4_0.onPlayCloseTransitionFinish, arg_4_0, 0.2)
end

return var_0_0
