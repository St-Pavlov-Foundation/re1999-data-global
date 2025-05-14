module("modules.logic.help.view.LawDescriptionViewContainer", package.seeall)

local var_0_0 = class("LawDescriptionViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		(LawDescriptionView.New())
	}
end

return var_0_0
