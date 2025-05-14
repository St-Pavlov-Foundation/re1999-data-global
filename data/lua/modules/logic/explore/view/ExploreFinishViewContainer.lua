module("modules.logic.explore.view.ExploreFinishViewContainer", package.seeall)

local var_0_0 = class("ExploreFinishViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ExploreFinishView.New()
	}
end

return var_0_0
