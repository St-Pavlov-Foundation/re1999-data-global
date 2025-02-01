module("modules.logic.seasonver.act123.view1_8.Season123_1_8EntryOverviewContainer", package.seeall)

slot0 = class("Season123_1_8EntryOverviewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_1_8CheckCloseView.New(),
		Season123_1_8EntryOverview.New()
	}
end

return slot0
