module("modules.logic.seasonver.act123.view.Season123EpisodeLoadingViewContainer", package.seeall)

slot0 = class("Season123EpisodeLoadingViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123EpisodeLoadingView.New()
	}
end

return slot0
