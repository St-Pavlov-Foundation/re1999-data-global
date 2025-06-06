﻿module("modules.logic.store.view.DecorateStoreGoodsViewContainer", package.seeall)

local var_0_0 = class("DecorateStoreGoodsViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "#go_topright"))
	table.insert(var_1_0, DecorateStoreGoodsView.New())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._currencyView = CurrencyView.New({})

		return {
			arg_3_0._currencyView
		}
	end
end

function var_0_0.setCurrencyType(arg_4_0, arg_4_1)
	if arg_4_0._currencyView then
		arg_4_0._currencyView:setCurrencyType(arg_4_1)
	end
end

return var_0_0
