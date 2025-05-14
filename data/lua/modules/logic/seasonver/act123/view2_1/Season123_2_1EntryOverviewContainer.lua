module("modules.logic.seasonver.act123.view2_1.Season123_2_1EntryOverviewContainer", package.seeall)

local var_0_0 = class("Season123_2_1EntryOverviewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123_2_1CheckCloseView.New(),
		Season123_2_1EntryOverview.New()
	}
end

return var_0_0
