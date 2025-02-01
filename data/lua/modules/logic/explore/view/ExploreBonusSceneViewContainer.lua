module("modules.logic.explore.view.ExploreBonusSceneViewContainer", package.seeall)

slot0 = class("ExploreBonusSceneViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ExploreBonusSceneView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return slot0
