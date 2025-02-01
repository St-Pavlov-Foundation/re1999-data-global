module("modules.logic.dungeon.view.puzzle.PutCubeGameViewContainer", package.seeall)

slot0 = class("PutCubeGameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TabViewGroup.New(1, "#go_btns"),
		PutCubeGameView.New()
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
