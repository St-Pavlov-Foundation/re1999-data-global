module("modules.logic.mainuiswitch.view.MainUISkinMaterialTipViewContainer", package.seeall)

local var_0_0 = class("MainUISkinMaterialTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, MainUISkinMaterialTipView.New())
	table.insert(var_1_0, MainUISkinMaterialTipViewBanner.New())

	return var_1_0
end

return var_0_0
