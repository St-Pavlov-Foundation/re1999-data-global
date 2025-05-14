module("modules.logic.rouge.map.view.fightsucc.RougeFightSuccessViewContainer", package.seeall)

local var_0_0 = class("RougeFightSuccessViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeFightSuccessView.New())

	return var_1_0
end

return var_0_0
