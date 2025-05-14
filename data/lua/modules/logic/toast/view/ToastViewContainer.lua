module("modules.logic.toast.view.ToastViewContainer", package.seeall)

local var_0_0 = class("ToastViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		ToastView.New()
	}
end

return var_0_0
