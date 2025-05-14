module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsReadViewContainer", package.seeall)

local var_0_0 = class("SportsNewsReadViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, SportsNewsReadView.New())

	return var_1_0
end

return var_0_0
