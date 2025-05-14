module("modules.logic.currency.view.CurrencyExchangeViewContainer", package.seeall)

local var_0_0 = class("CurrencyExchangeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CurrencyExchangeView.New(),
		TabViewGroup.New(1, "#go_righttop")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return arg_2_0:_buildCurrency()
	end
end

function var_0_0._buildCurrency(arg_3_0)
	arg_3_0._currencyView = CurrencyView.New({
		CurrencyEnum.CurrencyType.Diamond,
		CurrencyEnum.CurrencyType.FreeDiamondCoupon
	}, nil, nil, nil, true)

	return {
		arg_3_0._currencyView
	}
end

return var_0_0
