module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotTeamViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		V1a6_CachotTeamItemListView.New(),
		V1a6_CachotTeamView.New(),
		TabViewGroup.New(1, "#go_topleft")
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
