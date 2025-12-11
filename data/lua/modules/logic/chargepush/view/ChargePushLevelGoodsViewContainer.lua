module("modules.logic.chargepush.view.ChargePushLevelGoodsViewContainer", package.seeall)

local var_0_0 = class("ChargePushLevelGoodsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, ChargePushLevelGoodsView.New())

	return var_1_0
end

return var_0_0
