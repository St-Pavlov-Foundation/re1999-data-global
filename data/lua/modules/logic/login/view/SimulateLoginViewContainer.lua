module("modules.logic.login.view.SimulateLoginViewContainer", package.seeall)

local var_0_0 = class("SimulateLoginViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SimulateLoginView.New()
	}
end

return var_0_0
