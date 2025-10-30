module("modules.logic.login.view.LoginViewContainer", package.seeall)

local var_0_0 = class("LoginViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		LoginBgView.New("#go_bg"),
		LoginView.New(),
		LoginVideoView.New()
	}
end

function var_0_0.setSetting(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.setSetting(arg_2_0, arg_2_1, arg_2_2)

	local var_2_0 = LoginController.instance:isShowLoginVideo()

	if arg_2_2 then
		arg_2_2.otherRes = {}
		arg_2_2.otherRes[1] = string.format("ui/viewres/login/%s.prefab", var_2_0 and "loginbgvideo" or "loginbgtype")

		if var_2_0 then
			arg_2_2.otherRes[2] = ResUrl.getLoginBg("bg_denglubeijing_b02")
		end
	end
end

return var_0_0
