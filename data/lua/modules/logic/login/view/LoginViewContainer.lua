module("modules.logic.login.view.LoginViewContainer", package.seeall)

slot0 = class("LoginViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		LoginBgView.New("#go_bg"),
		LoginView.New()
	}
end

return slot0
