module("modules.logic.summon.view.SummonConfirmViewContainer", package.seeall)

slot0 = class("SummonConfirmViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "#go_topright"))
	table.insert(slot1, SummonConfirmView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		if SummonMainModel.instance:getCurPool() then
			slot3 = {}

			SummonMainModel.addCurrencyByCostStr(slot3, slot2.cost1, {})
			table.insert(slot3, CurrencyEnum.CurrencyType.FreeDiamondCoupon)

			slot0._currencyView = CurrencyView.New(slot3, nil, , , true)
		else
			slot0._currencyView = CurrencyView.New({
				{
					id = 140001,
					isIcon = true,
					type = MaterialEnum.MaterialType.Item
				},
				CurrencyEnum.CurrencyType.FreeDiamondCoupon
			}, nil, , , true)
		end

		return {
			slot0._currencyView
		}
	end
end

return slot0
