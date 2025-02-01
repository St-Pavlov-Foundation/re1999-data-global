module("modules.logic.tipdialog.view.TipDialogViewContainer", package.seeall)

slot0 = class("TipDialogViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TipDialogView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_bottomcontent/top_left"))

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

function slot0.onContainerOpenFinish(slot0)
	slot0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

return slot0
