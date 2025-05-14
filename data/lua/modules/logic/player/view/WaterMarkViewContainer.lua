module("modules.logic.player.view.WaterMarkViewContainer", package.seeall)

local var_0_0 = class("WaterMarkViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.waterMarkView = WaterMarkView.New()

	table.insert(var_1_0, arg_1_0.waterMarkView)

	return var_1_0
end

return var_0_0
