module("modules.logic.battlepass.view.BpVideoViewContainer", package.seeall)

local var_0_0 = class("BpVideoViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		BpVideoView.New()
	}
end

return var_0_0
