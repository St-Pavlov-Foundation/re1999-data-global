module("modules.logic.rouge.dlc.101.view.RougeLimiterLockedTipsViewContainer", package.seeall)

local var_0_0 = class("RougeLimiterLockedTipsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeLimiterLockedTipsView.New())

	return var_1_0
end

return var_0_0
