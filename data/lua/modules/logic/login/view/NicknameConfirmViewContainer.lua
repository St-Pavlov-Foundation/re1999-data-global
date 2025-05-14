module("modules.logic.login.view.NicknameConfirmViewContainer", package.seeall)

local var_0_0 = class("NicknameConfirmViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		NickNameConfirmView.New()
	}
end

return var_0_0
