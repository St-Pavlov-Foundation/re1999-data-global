module("modules.logic.weekwalk.view.WeekWalkLayerViewContainer", package.seeall)

slot0 = class("WeekWalkLayerViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "top_left"))
	table.insert(slot1, WeekWalkLayerView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, HelpEnum.HelpId.WeekWalk)

	return {
		slot0._navigateButtonView
	}
end

function slot0.getNavBtnView(slot0)
	return slot0._navigateButtonView
end

return slot0
