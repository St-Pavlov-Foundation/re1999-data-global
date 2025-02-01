module("modules.logic.toughbattle.view.ToughBattleEnterViewContainer", package.seeall)

slot0 = class("ToughBattleEnterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ToughBattleEnterView.New(),
		TabViewGroup.New(1, "root/#go_btns"),
		ToughBattleWordView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		slot0.navigateView
	}
end

return slot0
