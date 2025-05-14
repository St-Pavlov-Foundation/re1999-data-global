module("modules.logic.seasonver.act123.view2_0.Season123_2_0EntryOverviewContainer", package.seeall)

local var_0_0 = class("Season123_2_0EntryOverviewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123_2_0CheckCloseView.New(),
		Season123_2_0EntryOverview.New()
	}
end

return var_0_0
