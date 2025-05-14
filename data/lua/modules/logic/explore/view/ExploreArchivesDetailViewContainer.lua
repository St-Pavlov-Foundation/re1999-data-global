module("modules.logic.explore.view.ExploreArchivesDetailViewContainer", package.seeall)

local var_0_0 = class("ExploreArchivesDetailViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ExploreArchivesDetailView.New()
	}
end

return var_0_0
