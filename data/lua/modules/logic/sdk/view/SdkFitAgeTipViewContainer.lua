module("modules.logic.sdk.view.SdkFitAgeTipViewContainer", package.seeall)

local var_0_0 = class("SdkFitAgeTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SdkFitAgeTipView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
