module("modules.logic.messagebox.view.MessageBoxViewContainer", package.seeall)

local var_0_0 = class("MessageBoxViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		MessageBoxView.New()
	}
end

return var_0_0
