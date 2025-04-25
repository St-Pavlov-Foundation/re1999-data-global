module("modules.logic.store.view.DecorateStoreGoodsViewContainer", package.seeall)

slot0 = class("DecorateStoreGoodsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "#go_topright"))
	table.insert(slot1, DecorateStoreGoodsView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._currencyView = CurrencyView.New({})

		return {
			slot0._currencyView
		}
	end
end

function slot0.setCurrencyType(slot0, slot1)
	if slot0._currencyView then
		slot0._currencyView:setCurrencyType(slot1)
	end
end

return slot0
