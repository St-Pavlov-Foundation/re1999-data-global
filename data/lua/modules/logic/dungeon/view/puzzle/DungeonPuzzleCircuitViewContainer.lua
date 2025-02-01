module("modules.logic.dungeon.view.puzzle.DungeonPuzzleCircuitViewContainer", package.seeall)

slot0 = class("DungeonPuzzleCircuitViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		DungeonPuzzleCircuit.New(),
		DungeonPuzzleCircuitView.New()
	}
end

return slot0
