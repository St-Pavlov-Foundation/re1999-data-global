module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEnterViewContainer", package.seeall)

slot0 = class("V1a6_CachotEnterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a6_CachotEnterView.New(),
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
