module("modules.logic.store.view.NormalStoreGoodsViewContainer", package.seeall)

slot0 = class("NormalStoreGoodsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "#go_topright"))
	table.insert(slot1, NormalStoreGoodsView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0._currencyView = CurrencyView.New({})

	return {
		slot0._currencyView
	}
end

function slot0.setCurrencyType(slot0, slot1)
	slot2 = {
		slot1
	}

	if CurrencyEnum.CurrencyType.FreeDiamondCoupon == slot1 then
		slot2 = {
			CurrencyEnum.CurrencyType.Diamond,
			CurrencyEnum.CurrencyType.FreeDiamondCoupon
		}
	end

	if slot0._currencyView then
		slot0._currencyView:setCurrencyType(slot2)
	end
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

return slot0
