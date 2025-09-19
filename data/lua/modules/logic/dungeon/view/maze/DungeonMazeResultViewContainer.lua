module("modules.logic.dungeon.view.maze.DungeonMazeResultViewContainer", package.seeall)

local var_0_0 = class("DungeonMazeResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		DungeonMazeResultView.New()
	}
end

return var_0_0
