module("modules.logic.turnback.view.new.view.TurnbackNewSignInViewContainer", package.seeall)

local var_0_0 = class("TurnbackNewSignInViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TurnbackNewSignInView.New())

	return var_1_0
end

return var_0_0
