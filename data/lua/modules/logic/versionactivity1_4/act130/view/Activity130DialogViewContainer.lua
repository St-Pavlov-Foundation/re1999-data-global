module("modules.logic.versionactivity1_4.act130.view.Activity130DialogViewContainer", package.seeall)

slot0 = class("Activity130DialogViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Activity130DialogView.New())
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
