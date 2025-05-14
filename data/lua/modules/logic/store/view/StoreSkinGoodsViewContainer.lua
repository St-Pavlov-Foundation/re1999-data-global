module("modules.logic.store.view.StoreSkinGoodsViewContainer", package.seeall)

local var_0_0 = class("StoreSkinGoodsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "#go_topright"))
	table.insert(var_1_0, StoreSkinGoodsView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0._currencyView = CurrencyView.New({})

	return {
		arg_2_0._currencyView
	}
end

function var_0_0.setCurrencyType(arg_3_0, arg_3_1)
	if arg_3_0._currencyView then
		arg_3_0._currencyView:setCurrencyType(arg_3_1)
	end
end

function var_0_0.onContainerClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

return var_0_0
