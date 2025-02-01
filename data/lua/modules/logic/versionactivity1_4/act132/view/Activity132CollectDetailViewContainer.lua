module("modules.logic.versionactivity1_4.act132.view.Activity132CollectDetailViewContainer", package.seeall)

slot0 = class("Activity132CollectDetailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Activity132CollectDetailView.New(),
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

function slot0.onContainerClose(slot0)
	Activity132Controller.instance:dispatchEvent(Activity132Event.OnForceClueItem)
end

return slot0
