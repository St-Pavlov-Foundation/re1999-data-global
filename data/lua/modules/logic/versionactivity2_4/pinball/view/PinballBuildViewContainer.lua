module("modules.logic.versionactivity2_4.pinball.view.PinballBuildViewContainer", package.seeall)

local var_0_0 = class("PinballBuildViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		PinballBuildView.New()
	}
end

return var_0_0
