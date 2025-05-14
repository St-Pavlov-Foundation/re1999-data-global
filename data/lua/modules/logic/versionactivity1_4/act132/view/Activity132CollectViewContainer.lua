module("modules.logic.versionactivity1_4.act132.view.Activity132CollectViewContainer", package.seeall)

local var_0_0 = class("Activity132CollectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Activity132CollectView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return var_0_0
