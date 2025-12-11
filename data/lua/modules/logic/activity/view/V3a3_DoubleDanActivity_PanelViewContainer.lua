module("modules.logic.activity.view.V3a3_DoubleDanActivity_PanelViewContainer", package.seeall)

local var_0_0 = class("V3a3_DoubleDanActivity_PanelViewContainer", V3a3_DoubleDanActivityViewImplContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, V3a3_DoubleDanActivity_PanelView.New())

	return var_1_0
end

return var_0_0
