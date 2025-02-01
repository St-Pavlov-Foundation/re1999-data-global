module("modules.logic.currency.view.PowerBuyTipViewContainer", package.seeall)

slot0 = class("PowerBuyTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, PowerBuyTipView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_righttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot2 = CurrencyEnum.CurrencyType

	return {
		CurrencyView.New({
			slot2.Diamond,
			slot2.FreeDiamondCoupon
		})
	}
end

return slot0
