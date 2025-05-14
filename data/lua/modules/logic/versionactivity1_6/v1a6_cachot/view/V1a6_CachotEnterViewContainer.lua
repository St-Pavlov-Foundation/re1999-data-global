module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEnterViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotEnterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		V1a6_CachotEnterView.New(),
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
