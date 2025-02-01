module("modules.logic.seasonver.act123.view.Season123DecomposeFilterViewContainer", package.seeall)

slot0 = class("Season123DecomposeFilterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123DecomposeFilterView.New()
	}
end

return slot0
