module("modules.logic.summon.view.SummonResultViewContainer", package.seeall)

local var_0_0 = class("SummonResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, SummonResultView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_righttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return arg_2_0:_buildCurrency()
	end
end

function var_0_0._buildCurrency(arg_3_0)
	arg_3_0._currencyView = CurrencyView.New({
		CurrencyEnum.CurrencyType.Diamond,
		CurrencyEnum.CurrencyType.FreeDiamondCoupon,
		{
			id = 140001,
			isIcon = true,
			type = MaterialEnum.MaterialType.Item
		}
	}, nil, nil, nil, false)

	return {
		arg_3_0._currencyView
	}
end

return var_0_0
