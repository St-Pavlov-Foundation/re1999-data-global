module("modules.logic.limited.view.LimitedRoleViewContainer", package.seeall)

local var_0_0 = class("LimitedRoleViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		LimitedRoleView.New()
	}
end

return var_0_0
