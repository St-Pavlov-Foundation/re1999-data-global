module("modules.logic.player.view.PlayerIdViewContainer", package.seeall)

local var_0_0 = class("PlayerIdViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.PlayerIdView = PlayerIdView.New()

	table.insert(var_1_0, arg_1_0.PlayerIdView)

	return var_1_0
end

return var_0_0
