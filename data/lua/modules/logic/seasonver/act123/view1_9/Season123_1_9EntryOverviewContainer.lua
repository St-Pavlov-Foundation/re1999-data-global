module("modules.logic.seasonver.act123.view1_9.Season123_1_9EntryOverviewContainer", package.seeall)

local var_0_0 = class("Season123_1_9EntryOverviewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123_1_9CheckCloseView.New(),
		Season123_1_9EntryOverview.New()
	}
end

return var_0_0
