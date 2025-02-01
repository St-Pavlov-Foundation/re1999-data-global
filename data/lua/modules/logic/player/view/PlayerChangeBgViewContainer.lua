module("modules.logic.player.view.PlayerChangeBgViewContainer", package.seeall)

slot0 = class("PlayerChangeBgViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		PlayerChangeBgView.New(),
		TabViewGroup.New(1, "root/#go_topleft")
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
