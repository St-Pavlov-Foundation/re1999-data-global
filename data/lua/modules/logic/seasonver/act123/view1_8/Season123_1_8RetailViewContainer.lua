module("modules.logic.seasonver.act123.view1_8.Season123_1_8RetailViewContainer", package.seeall)

local var_0_0 = class("Season123_1_8RetailViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123_1_8CheckCloseView.New(),
		Season123_1_8RetailView.New(),
		TabViewGroup.New(1, "#go_lefttop"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0._navigateButtonView
		}
	elseif arg_2_1 == 2 then
		return arg_2_0:buildCurrency()
	end
end

function var_0_0.buildCurrency(arg_3_0)
	arg_3_0._currencyView = CurrencyView.New({}, nil, nil, nil, true)
	arg_3_0._currencyView.foreHideBtn = true

	return {
		arg_3_0._currencyView
	}
end

function var_0_0.refreshCurrencyType(arg_4_0)
	if arg_4_0._currencyView then
		local var_4_0 = Season123RetailModel.instance.activityId
		local var_4_1 = Season123Config.instance:getEquipItemCoin(var_4_0, Activity123Enum.Const.UttuTicketsCoin)

		arg_4_0._currencyView:setCurrencyType({
			var_4_1
		})
	end
end

return var_0_0
