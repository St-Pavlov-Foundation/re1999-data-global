module("modules.logic.social.view.SocialRemarkTipViewContainer", package.seeall)

local var_0_0 = class("SocialRemarkTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SocialRemarkTipView.New()
	}
end

return var_0_0
