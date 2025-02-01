module("modules.logic.advance.view.testtask.TestTaskViewContainer", package.seeall)

slot0 = class("TestTaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TestTaskView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		slot0._navigateButtonView
	}
end

return slot0
