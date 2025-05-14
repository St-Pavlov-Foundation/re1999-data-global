module("modules.logic.investigate.view.InvestigateRoleStoryViewContainer", package.seeall)

local var_0_0 = class("InvestigateRoleStoryViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, InvestigateRoleStoryView.New())

	return var_1_0
end

return var_0_0
