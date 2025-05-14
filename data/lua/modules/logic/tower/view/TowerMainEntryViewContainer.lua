module("modules.logic.tower.view.TowerMainEntryViewContainer", package.seeall)

local var_0_0 = class("TowerMainEntryViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TowerMainEntryView.New())

	return var_1_0
end

return var_0_0
