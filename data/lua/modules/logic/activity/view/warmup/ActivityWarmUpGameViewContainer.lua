module("modules.logic.activity.view.warmup.ActivityWarmUpGameViewContainer", package.seeall)

slot0 = class("ActivityWarmUpGameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityWarmUpGameView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigationView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		slot0.navigationView
	}
end

return slot0
