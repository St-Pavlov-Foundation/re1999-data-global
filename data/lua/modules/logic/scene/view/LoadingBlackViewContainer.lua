module("modules.logic.scene.view.LoadingBlackViewContainer", package.seeall)

local var_0_0 = class("LoadingBlackViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		LoadingBlackView.New()
	}
end

return var_0_0
