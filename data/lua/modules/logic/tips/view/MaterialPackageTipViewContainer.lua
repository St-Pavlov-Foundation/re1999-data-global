module("modules.logic.tips.view.MaterialPackageTipViewContainer", package.seeall)

local var_0_0 = class("MaterialPackageTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		MaterialTipView.New()
	}
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0
