module("modules.logic.dungeon.view.puzzle.DungeonPuzzleMazeDrawViewContainer", package.seeall)

slot0 = class("DungeonPuzzleMazeDrawViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		DungeonPuzzleMazeDraw.New(),
		DungeonPuzzleMazeDrawView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return slot0
