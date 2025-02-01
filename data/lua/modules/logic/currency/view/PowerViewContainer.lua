module("modules.logic.currency.view.PowerViewContainer", package.seeall)

slot0 = class("PowerViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, PowerView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_righttop"))

	return slot1
end

slot1 = {
	duration = 0.01
}

function slot0.playOpenTransition(slot0)
	uv0.super.playOpenTransition(slot0, uv1)
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
