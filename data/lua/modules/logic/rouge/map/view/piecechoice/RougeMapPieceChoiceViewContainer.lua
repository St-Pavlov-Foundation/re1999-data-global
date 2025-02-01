module("modules.logic.rouge.map.view.piecechoice.RougeMapPieceChoiceViewContainer", package.seeall)

slot0 = class("RougeMapPieceChoiceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeMapPieceChoiceView.New())
	table.insert(slot1, RougeMapCoinView.New())
	table.insert(slot1, RougeMapEntrustView.New())
	table.insert(slot1, RougeMapChoiceTipView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
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

function slot0.setOverrideClose(slot0, slot1, slot2)
	slot0.navigateView:setOverrideClose(slot1, slot2)
end

return slot0
