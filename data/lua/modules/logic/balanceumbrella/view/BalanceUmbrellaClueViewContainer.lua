module("modules.logic.balanceumbrella.view.BalanceUmbrellaClueViewContainer", package.seeall)

slot0 = class("BalanceUmbrellaClueViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		BalanceUmbrellaClueView.New()
	}
end

return slot0
