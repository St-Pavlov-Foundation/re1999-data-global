module("modules.logic.sp01.act204.view.Activity204EntranceViewContainer", package.seeall)

local var_0_0 = class("Activity204EntranceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Activity204EntranceView.New())
	table.insert(var_1_0, Activity204EntranceHeroView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.playCloseTransition(arg_3_0)
	arg_3_0:onPlayCloseTransitionFinish()
end

return var_0_0
