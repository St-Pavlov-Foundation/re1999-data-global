module("modules.logic.seasonver.act123.view2_1.Season123_2_1EntryOverviewContainer", package.seeall)

slot0 = class("Season123_2_1EntryOverviewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_2_1CheckCloseView.New(),
		Season123_2_1EntryOverview.New()
	}
end

return slot0
