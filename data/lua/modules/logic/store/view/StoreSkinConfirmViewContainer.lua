module("modules.logic.store.view.StoreSkinConfirmViewContainer", package.seeall)

slot0 = class("StoreSkinConfirmViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "#go_topright"))
	table.insert(slot1, StoreSkinConfirmView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.Diamond,
			CurrencyEnum.CurrencyType.SkinCard
		}, nil, , , true)

		return {
			slot0._currencyView
		}
	end
end

return slot0
