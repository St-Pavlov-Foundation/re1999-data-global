module("modules.logic.versionactivity1_4.act132.view.Activity132CollectViewContainer", package.seeall)

slot0 = class("Activity132CollectViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Activity132CollectView.New(),
		TabViewGroup.New(1, "#go_topleft")
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
