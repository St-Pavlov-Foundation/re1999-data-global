module("modules.logic.versionactivity3_1.nationalgift.view.NationalGiftFullViewContainer", package.seeall)

local var_0_0 = class("NationalGiftFullViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, NationalGiftFullView.New())

	return var_1_0
end

return var_0_0
