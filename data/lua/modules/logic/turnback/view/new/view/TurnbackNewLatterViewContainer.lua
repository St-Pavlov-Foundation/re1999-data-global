module("modules.logic.turnback.view.new.view.TurnbackNewLatterViewContainer", package.seeall)

local var_0_0 = class("TurnbackNewLatterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TurnbackNewLatterView.New())

	return var_1_0
end

return var_0_0
