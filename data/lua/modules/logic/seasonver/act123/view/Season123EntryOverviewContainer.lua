module("modules.logic.seasonver.act123.view.Season123EntryOverviewContainer", package.seeall)

local var_0_0 = class("Season123EntryOverviewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123CheckCloseView.New(),
		Season123EntryOverview.New()
	}
end

return var_0_0
