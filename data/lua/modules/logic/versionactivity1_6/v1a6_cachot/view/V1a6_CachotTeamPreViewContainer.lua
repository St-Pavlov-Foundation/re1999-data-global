module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamPreViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotTeamPreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		V1a6_CachotTeamPreView.New()
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
