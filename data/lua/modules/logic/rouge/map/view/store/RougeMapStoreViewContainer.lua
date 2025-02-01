module("modules.logic.rouge.map.view.store.RougeMapStoreViewContainer", package.seeall)

slot0 = class("RougeMapStoreViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeMapStoreView.New())
	table.insert(slot1, RougeMapCoinView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	slot0.navigateView:setOverrideClose(RougeMapHelper.backToMainScene)

	return {
		slot0.navigateView
	}
end

return slot0
