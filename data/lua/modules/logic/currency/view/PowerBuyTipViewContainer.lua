module("modules.logic.currency.view.PowerBuyTipViewContainer", package.seeall)

local var_0_0 = class("PowerBuyTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, PowerBuyTipView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_righttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = CurrencyEnum.CurrencyType
	local var_2_1 = {
		var_2_0.Diamond,
		var_2_0.FreeDiamondCoupon
	}

	return {
		CurrencyView.New(var_2_1)
	}
end

return var_0_0
