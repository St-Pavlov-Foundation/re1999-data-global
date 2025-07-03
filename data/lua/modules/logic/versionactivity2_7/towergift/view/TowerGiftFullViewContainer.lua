module("modules.logic.versionactivity2_7.towergift.view.TowerGiftFullViewContainer", package.seeall)

local var_0_0 = class("TowerGiftFullViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TowerGiftFullView.New())

	return var_1_0
end

return var_0_0
