module("modules.logic.store.view.StoreSkinConfirmViewContainer", package.seeall)

local var_0_0 = class("StoreSkinConfirmViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "#go_topright"))
	table.insert(var_1_0, StoreSkinConfirmView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.Diamond,
			CurrencyEnum.CurrencyType.SkinCard
		}, nil, nil, nil, true)

		return {
			arg_2_0._currencyView
		}
	end
end

return var_0_0
