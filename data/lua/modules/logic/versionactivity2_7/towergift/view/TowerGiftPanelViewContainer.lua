module("modules.logic.versionactivity2_7.towergift.view.TowerGiftPanelViewContainer", package.seeall)

local var_0_0 = class("TowerGiftPanelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TowerGiftPanelView.New())

	return var_1_0
end

return var_0_0
