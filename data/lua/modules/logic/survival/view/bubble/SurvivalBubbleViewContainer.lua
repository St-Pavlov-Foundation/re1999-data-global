module("modules.logic.survival.view.bubble.SurvivalBubbleViewContainer", package.seeall)

local var_0_0 = class("SurvivalBubbleViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalBubbleView.New()
	}
end

return var_0_0
