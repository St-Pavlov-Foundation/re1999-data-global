module("modules.logic.sp01.assassin2.outside.view.AssassinTechniqueViewContainer", package.seeall)

local var_0_0 = class("AssassinTechniqueViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, AssassinTechniqueView.New())

	return var_1_0
end

return var_0_0
