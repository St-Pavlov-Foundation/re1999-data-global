module("modules.logic.explore.view.ExploreBonusSceneViewContainer", package.seeall)

local var_0_0 = class("ExploreBonusSceneViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ExploreBonusSceneView.New(),
		TabViewGroup.New(1, "#go_btns")
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
