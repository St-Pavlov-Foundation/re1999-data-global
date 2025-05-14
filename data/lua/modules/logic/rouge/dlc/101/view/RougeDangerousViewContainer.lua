module("modules.logic.rouge.dlc.101.view.RougeDangerousViewContainer", package.seeall)

local var_0_0 = class("RougeDangerousViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeDangerousView.New())

	return var_1_0
end

function var_0_0.playOpenTransition(arg_2_0)
	var_0_0.super.playOpenTransition(arg_2_0, {
		noBlock = true,
		duration = RougeDangerousView.OpenViewDuration
	})
end

return var_0_0
