module("modules.logic.common.view.CommonExchangeViewContainer", package.seeall)

local var_0_0 = class("CommonExchangeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, CommonExchangeView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_righttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return arg_2_0:_buildCurrency()
	end
end

function var_0_0._buildCurrency(arg_3_0)
	local var_3_0 = arg_3_0.viewParam.costMatData

	arg_3_0._currencyView = CurrencyView.New({
		{
			isHideAddBtn = true,
			type = var_3_0.materilType,
			id = var_3_0.materilId
		}
	}, nil, nil, nil, true)

	return {
		arg_3_0._currencyView
	}
end

return var_0_0
