module("modules.logic.seasonver.act123.view2_0.Season123_2_0EntryOverviewContainer", package.seeall)

slot0 = class("Season123_2_0EntryOverviewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_2_0CheckCloseView.New(),
		Season123_2_0EntryOverview.New()
	}
end

return slot0
