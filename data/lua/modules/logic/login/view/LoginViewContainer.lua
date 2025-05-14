module("modules.logic.login.view.LoginViewContainer", package.seeall)

local var_0_0 = class("LoginViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		LoginBgView.New("#go_bg"),
		LoginView.New()
	}
end

return var_0_0
