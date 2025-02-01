module("modules.logic.meilanni.view.MeilanniViewContainer", package.seeall)

slot0 = class("MeilanniViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, MeilanniView.New())
	table.insert(slot1, MeilanniMap.New())
	table.insert(slot1, MeilanniEventView.New())
	table.insert(slot1, MeilanniDialogBtnView.New())
	table.insert(slot1, MeilanniDialogView.New())
	table.insert(slot1, TabViewGroup.New(1, "top_left"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		true
	}, HelpEnum.HelpId.VersionActivityMeiLanNi)

	return {
		slot0._navigateButtonView
	}
end

return slot0
