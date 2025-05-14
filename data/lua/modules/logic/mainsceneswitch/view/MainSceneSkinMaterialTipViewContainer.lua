module("modules.logic.mainsceneswitch.view.MainSceneSkinMaterialTipViewContainer", package.seeall)

local var_0_0 = class("MainSceneSkinMaterialTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, MainSceneSkinMaterialTipView.New())
	table.insert(var_1_0, MainSceneSkinMaterialTipViewBanner.New())

	return var_1_0
end

return var_0_0
