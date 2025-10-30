module("modules.logic.versionactivity3_0.karong.view.KaRongRoleTagViewContainer", package.seeall)

local var_0_0 = class("KaRongRoleTagViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, KaRongRoleTagView.New())

	return var_1_0
end

return var_0_0
