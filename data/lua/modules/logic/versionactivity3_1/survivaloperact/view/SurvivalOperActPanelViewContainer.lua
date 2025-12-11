module("modules.logic.versionactivity3_1.survivaloperact.view.SurvivalOperActPanelViewContainer", package.seeall)

local var_0_0 = class("SurvivalOperActPanelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, SurvivalOperActPanelView.New())

	return var_1_0
end

return var_0_0
