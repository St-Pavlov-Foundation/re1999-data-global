module("modules.logic.store.view.NormalStoreGoodsViewContainer", package.seeall)

local var_0_0 = class("NormalStoreGoodsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "#go_topright"))
	table.insert(var_1_0, NormalStoreGoodsView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0._currencyView = CurrencyView.New({})

	return {
		arg_2_0._currencyView
	}
end

function var_0_0.setCurrencyType(arg_3_0, arg_3_1)
	local var_3_0 = {
		arg_3_1
	}

	if CurrencyEnum.CurrencyType.FreeDiamondCoupon == arg_3_1 then
		var_3_0 = {
			CurrencyEnum.CurrencyType.Diamond,
			CurrencyEnum.CurrencyType.FreeDiamondCoupon
		}
	end

	if arg_3_0._currencyView then
		arg_3_0._currencyView:setCurrencyType(var_3_0)
	end
end

function var_0_0.setCurrencyTypes(arg_4_0, arg_4_1)
	if arg_4_0._currencyView then
		arg_4_0._currencyView:setCurrencyType(arg_4_1)
	end
end

function var_0_0.onContainerClickModalMask(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_5_0:closeThis()
end

return var_0_0
