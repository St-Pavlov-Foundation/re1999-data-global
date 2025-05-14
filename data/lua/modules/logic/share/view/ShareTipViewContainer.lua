module("modules.logic.share.view.ShareTipViewContainer", package.seeall)

local var_0_0 = class("ShareTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ShareTipView.New()
	}
end

return var_0_0
