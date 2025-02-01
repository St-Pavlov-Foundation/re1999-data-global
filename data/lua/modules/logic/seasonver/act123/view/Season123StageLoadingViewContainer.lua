module("modules.logic.seasonver.act123.view.Season123StageLoadingViewContainer", package.seeall)

slot0 = class("Season123StageLoadingViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123StageLoadingView.New()
	}
end

return slot0
