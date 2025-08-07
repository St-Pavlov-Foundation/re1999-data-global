module("modules.logic.sp01.assassin2.outside.view.AssassinLoginViewContainer", package.seeall)

local var_0_0 = class("AssassinLoginViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, AssassinLoginView.New())

	return var_1_0
end

return var_0_0
