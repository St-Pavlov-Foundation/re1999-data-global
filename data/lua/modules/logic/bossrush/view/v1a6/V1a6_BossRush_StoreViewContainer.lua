module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_StoreViewContainer", package.seeall)

slot0 = class("V1a6_BossRush_StoreViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a6_BossRush_StoreView.New(),
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end

	if slot1 == 2 then
		slot0._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.BossRushStore
		}, slot0._onCurrencyCallback, slot0)
		slot0._currencyView.foreHideBtn = true

		return {
			slot0._currencyView
		}
	end
end

function slot0._onCurrencyCallback(slot0)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnHandleInStoreView)
end

return slot0
