module("modules.logic.rouge.map.view.levelup.RougeLevelUpViewContainer", package.seeall)

local var_0_0 = class("RougeLevelUpViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeLevelUpView.New())

	return var_1_0
end

return var_0_0
