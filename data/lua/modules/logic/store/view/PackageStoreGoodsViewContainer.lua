module("modules.logic.store.view.PackageStoreGoodsViewContainer", package.seeall)

local var_0_0 = class("PackageStoreGoodsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "#go_topright"))
	table.insert(var_1_0, PackageStoreGoodsView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0._currencyView = CurrencyView.New({})

	local var_2_0 = CurrencyEnum.CurrencyType

	arg_2_0._currencyView:setCurrencyType({
		var_2_0.Diamond,
		var_2_0.FreeDiamondCoupon
	})

	return {
		arg_2_0._currencyView
	}
end

function var_0_0.onContainerClickModalMask(arg_3_0)
	arg_3_0:closeThis()
end

return var_0_0
