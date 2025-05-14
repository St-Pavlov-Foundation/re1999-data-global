module("modules.logic.seasonver.act123.view1_8.Season123_1_8EntryOverviewContainer", package.seeall)

local var_0_0 = class("Season123_1_8EntryOverviewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123_1_8CheckCloseView.New(),
		Season123_1_8EntryOverview.New()
	}
end

return var_0_0
