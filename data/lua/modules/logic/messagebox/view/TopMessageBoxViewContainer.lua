module("modules.logic.messagebox.view.TopMessageBoxViewContainer", package.seeall)

local var_0_0 = class("TopMessageBoxViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		MessageBoxView.New()
	}
end

return var_0_0
