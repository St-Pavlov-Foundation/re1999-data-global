module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsTipsContainer", package.seeall)

local var_0_0 = class("SportsNewsTipsContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, SportsNewsTips.New())

	return var_1_0
end

return var_0_0
