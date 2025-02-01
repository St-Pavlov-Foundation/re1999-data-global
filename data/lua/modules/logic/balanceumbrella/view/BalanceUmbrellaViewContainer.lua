module("modules.logic.balanceumbrella.view.BalanceUmbrellaViewContainer", package.seeall)

slot0 = class("BalanceUmbrellaViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		BalanceUmbrellaView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		slot0.navigateView
	}
end

return slot0
