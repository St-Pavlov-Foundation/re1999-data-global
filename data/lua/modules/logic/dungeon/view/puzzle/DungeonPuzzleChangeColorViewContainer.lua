module("modules.logic.dungeon.view.puzzle.DungeonPuzzleChangeColorViewContainer", package.seeall)

slot0 = class("DungeonPuzzleChangeColorViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))
	table.insert(slot1, DungeonPuzzleChangeColorView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		}, 100)
	}
end

return slot0
