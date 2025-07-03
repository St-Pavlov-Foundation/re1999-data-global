module("modules.logic.versionactivity2_7.act191.view.Act191BuffTipViewContainer", package.seeall)

local var_0_0 = class("Act191BuffTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Act191BuffTipView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
