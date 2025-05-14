module("modules.logic.dungeon.view.puzzle.DungeonPuzzleCircuitViewContainer", package.seeall)

local var_0_0 = class("DungeonPuzzleCircuitViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		DungeonPuzzleCircuit.New(),
		DungeonPuzzleCircuitView.New()
	}
end

return var_0_0
