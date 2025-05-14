module("modules.logic.summon.view.SummonConfirmViewContainer", package.seeall)

local var_0_0 = class("SummonConfirmViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "#go_topright"))
	table.insert(var_1_0, SummonConfirmView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = SummonMainModel.instance:getCurPool()

		if var_2_0 then
			local var_2_1 = {}
			local var_2_2 = {}

			SummonMainModel.addCurrencyByCostStr(var_2_1, var_2_0.cost1, var_2_2)
			table.insert(var_2_1, CurrencyEnum.CurrencyType.FreeDiamondCoupon)

			arg_2_0._currencyView = CurrencyView.New(var_2_1, nil, nil, nil, true)
		else
			arg_2_0._currencyView = CurrencyView.New({
				{
					id = 140001,
					isIcon = true,
					type = MaterialEnum.MaterialType.Item
				},
				CurrencyEnum.CurrencyType.FreeDiamondCoupon
			}, nil, nil, nil, true)
		end

		return {
			arg_2_0._currencyView
		}
	end
end

return var_0_0
