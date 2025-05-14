module("modules.logic.dungeon.view.puzzle.PutCubeGameViewContainer", package.seeall)

local var_0_0 = class("PutCubeGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		TabViewGroup.New(1, "#go_btns"),
		PutCubeGameView.New()
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
