module("modules.logic.scene.view.LoadingViewContainer", package.seeall)

local var_0_0 = class("LoadingViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		LoadingView.New()
	}
end

return var_0_0
