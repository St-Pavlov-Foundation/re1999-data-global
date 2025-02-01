module("modules.logic.versionactivity1_4.act130.view.Activity130CollectViewContainer", package.seeall)

slot0 = class("Activity130CollectViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Activity130CollectView.New())

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
