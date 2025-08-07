module("modules.logic.mainuiswitch.view.MainUISwitchInfoBlurMaskViewContainer", package.seeall)

local var_0_0 = class("MainUISwitchInfoBlurMaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	if not arg_1_0.viewParam or arg_1_0.viewParam.isNotShowHero ~= true then
		table.insert(var_1_0, MainUISwitchInfoHeroView.New())
	end

	table.insert(var_1_0, MainUISwitchInfoBlurMaskView.New())

	return var_1_0
end

return var_0_0
