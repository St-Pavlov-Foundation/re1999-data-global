module("modules.logic.rouge.dlc.101.view.RougeFactionLockedTipsContainer", package.seeall)

local var_0_0 = class("RougeFactionLockedTipsContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeFactionLockedTips.New())

	return var_1_0
end

return var_0_0
