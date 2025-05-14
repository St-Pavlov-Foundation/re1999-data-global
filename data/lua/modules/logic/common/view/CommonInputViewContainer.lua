module("modules.logic.common.view.CommonInputViewContainer", package.seeall)

local var_0_0 = class("CommonInputViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CommonInputView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
