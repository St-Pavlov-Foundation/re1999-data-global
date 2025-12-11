module("modules.logic.necrologiststory.game.v3a1.V3A1_RoleStoryFailViewContainer", package.seeall)

local var_0_0 = class("V3A1_RoleStoryFailViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, V3A1_RoleStoryFailView.New())

	return var_1_0
end

return var_0_0
