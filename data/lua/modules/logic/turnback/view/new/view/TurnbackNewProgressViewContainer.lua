module("modules.logic.turnback.view.new.view.TurnbackNewProgressViewContainer", package.seeall)

local var_0_0 = class("TurnbackNewProgressViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TurnbackNewProgressView.New())

	return var_1_0
end

return var_0_0
