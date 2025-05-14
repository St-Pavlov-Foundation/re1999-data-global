module("modules.logic.player.view.PlayerChangeBgViewContainer", package.seeall)

local var_0_0 = class("PlayerChangeBgViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		PlayerChangeBgView.New(),
		TabViewGroup.New(1, "root/#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return var_0_0
