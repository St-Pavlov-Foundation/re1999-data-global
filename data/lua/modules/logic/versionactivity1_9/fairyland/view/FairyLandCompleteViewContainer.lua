module("modules.logic.versionactivity1_9.fairyland.view.FairyLandCompleteViewContainer", package.seeall)

local var_0_0 = class("FairyLandCompleteViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, FairyLandCompleteView.New())

	return var_1_0
end

return var_0_0
