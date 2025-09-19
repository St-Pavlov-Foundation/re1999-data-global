module("modules.logic.store.view.DecorateStoreGoodsBuyViewContainer", package.seeall)

local var_0_0 = class("DecorateStoreGoodsBuyViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, DecorateStoreGoodsBuyView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._currencyView = CurrencyView.New({})

		return {
			arg_2_0._currencyView
		}
	end
end

function var_0_0.setCurrencyType(arg_3_0, arg_3_1)
	if arg_3_0._currencyView then
		arg_3_0._currencyView:setCurrencyType(arg_3_1)
	end
end

return var_0_0
