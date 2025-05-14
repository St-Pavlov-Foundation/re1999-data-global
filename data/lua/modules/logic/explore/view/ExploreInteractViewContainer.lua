module("modules.logic.explore.view.ExploreInteractViewContainer", package.seeall)

local var_0_0 = class("ExploreInteractViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ExploreInteractView.New()
	}
end

return var_0_0
