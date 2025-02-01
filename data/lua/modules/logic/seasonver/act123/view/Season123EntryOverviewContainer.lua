module("modules.logic.seasonver.act123.view.Season123EntryOverviewContainer", package.seeall)

slot0 = class("Season123EntryOverviewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123CheckCloseView.New(),
		Season123EntryOverview.New()
	}
end

return slot0
