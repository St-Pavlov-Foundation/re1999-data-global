module("modules.logic.necrologiststory.view.NecrologistStoryTipViewContainer", package.seeall)

local var_0_0 = class("NecrologistStoryTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, NecrologistStoryTipView.New())

	return var_1_0
end

return var_0_0
