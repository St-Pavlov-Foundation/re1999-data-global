module("modules.logic.dungeon.view.puzzle.DungeonPuzzleChangeColorViewContainer", package.seeall)

local var_0_0 = class("DungeonPuzzleChangeColorViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))
	table.insert(var_1_0, DungeonPuzzleChangeColorView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		}, 100)
	}
end

return var_0_0
