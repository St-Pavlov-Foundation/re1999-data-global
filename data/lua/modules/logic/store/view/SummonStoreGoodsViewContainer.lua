module("modules.logic.store.view.SummonStoreGoodsViewContainer", package.seeall)

local var_0_0 = class("SummonStoreGoodsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "#go_topright"))
	table.insert(var_1_0, SummonStoreGoodsView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0._currencyView = CurrencyView.New({})

	return {
		arg_2_0._currencyView
	}
end

function var_0_0.setCurrencyType(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0

	if CurrencyEnum.CurrencyType.FreeDiamondCoupon == arg_3_1 then
		var_3_0 = {
			CurrencyEnum.CurrencyType.Diamond,
			CurrencyEnum.CurrencyType.FreeDiamondCoupon
		}
	else
		var_3_0 = {
			{
				isCurrencySprite = true,
				id = arg_3_1,
				icon = arg_3_3,
				type = MaterialEnum.MaterialType.Item
			}
		}
	end

	if arg_3_0._currencyView then
		arg_3_0._currencyView:setCurrencyType(var_3_0)
	end
end

function var_0_0.onContainerClickModalMask(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_4_0:closeThis()
end

return var_0_0
