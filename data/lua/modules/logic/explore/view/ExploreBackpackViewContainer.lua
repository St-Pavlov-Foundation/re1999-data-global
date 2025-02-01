module("modules.logic.explore.view.ExploreBackpackViewContainer", package.seeall)

slot0 = class("ExploreBackpackViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ExploreBackpackView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
