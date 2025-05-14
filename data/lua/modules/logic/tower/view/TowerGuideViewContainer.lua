module("modules.logic.tower.view.TowerGuideViewContainer", package.seeall)

local var_0_0 = class("TowerGuideViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TowerGuideView.New())

	return var_1_0
end

return var_0_0
