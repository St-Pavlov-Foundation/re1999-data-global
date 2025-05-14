module("modules.logic.dungeon.view.puzzle.DungeonPuzzleQuestionViewContainer", package.seeall)

local var_0_0 = class("DungeonPuzzleQuestionViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		DungeonPuzzleQuestionView.New(),
		TabViewGroup.New(1, "#go_btns")
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
