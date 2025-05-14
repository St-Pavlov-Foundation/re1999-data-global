module("modules.logic.turnback.view.TurnbackRecommendViewContainer", package.seeall)

local var_0_0 = class("TurnbackRecommendViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		TurnbackRecommendView.New()
	}
end

return var_0_0
