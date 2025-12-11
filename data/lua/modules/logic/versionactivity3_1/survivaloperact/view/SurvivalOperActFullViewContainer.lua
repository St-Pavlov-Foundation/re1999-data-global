module("modules.logic.versionactivity3_1.survivaloperact.view.SurvivalOperActFullViewContainer", package.seeall)

local var_0_0 = class("SurvivalOperActFullViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, SurvivalOperActFullView.New())

	return var_1_0
end

return var_0_0
