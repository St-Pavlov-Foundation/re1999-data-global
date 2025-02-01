module("modules.logic.explore.view.ExploreGetItemViewContainer", package.seeall)

slot0 = class("ExploreGetItemViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ExploreGetItemView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
