module("modules.logic.login.view.NicknameViewContainer", package.seeall)

local var_0_0 = class("NicknameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		NicknameView.New()
	}
end

return var_0_0
