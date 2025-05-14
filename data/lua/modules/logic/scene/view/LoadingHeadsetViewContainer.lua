module("modules.logic.scene.view.LoadingHeadsetViewContainer", package.seeall)

local var_0_0 = class("LoadingHeadsetViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		LoadingHeadsetView.New()
	}
end

return var_0_0
