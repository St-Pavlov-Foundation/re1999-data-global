module("modules.logic.season.view1_3.Season1_3RetailLevelInfoViewContainer", package.seeall)

slot0 = class("Season1_3RetailLevelInfoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Season1_3RetailLevelInfoView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, 100, slot0._closeCallback, slot0._homeCallback, nil, slot0)

	return {
		slot0._navigateButtonView
	}
end

function slot0._closeCallback(slot0)
	slot0:closeThis()
end

function slot0._homeCallback(slot0)
	slot0:closeThis()
end

function slot0.playOpenTransition(slot0, slot1)
	slot1 = slot1 or {}
	slot1.duration = 0

	uv0.super.playOpenTransition(slot0, slot1)
end

return slot0
