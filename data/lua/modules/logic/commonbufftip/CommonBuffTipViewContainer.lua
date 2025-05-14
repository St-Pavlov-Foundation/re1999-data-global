module("modules.logic.commonbufftip.CommonBuffTipViewContainer", package.seeall)

local var_0_0 = class("CommonBuffTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CommonBuffTipView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
