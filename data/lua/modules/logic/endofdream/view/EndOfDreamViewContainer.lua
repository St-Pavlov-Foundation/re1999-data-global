module("modules.logic.endofdream.view.EndOfDreamViewContainer", package.seeall)

slot0 = class("EndOfDreamViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))
	table.insert(slot1, EndOfDreamView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigationView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		slot0.navigationView
	}
end

return slot0
