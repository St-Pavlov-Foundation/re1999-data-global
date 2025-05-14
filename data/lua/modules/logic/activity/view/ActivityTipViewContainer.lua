module("modules.logic.activity.view.ActivityTipViewContainer", package.seeall)

local var_0_0 = class("ActivityTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ActivityTipView.New()
	}
end

return var_0_0
