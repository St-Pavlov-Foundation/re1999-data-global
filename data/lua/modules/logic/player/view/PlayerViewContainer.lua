module("modules.logic.player.view.PlayerViewContainer", package.seeall)

slot0 = class("PlayerViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, PlayerView.New())
	table.insert(slot1, PlayerViewAchievement.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

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

function slot0.onContainerOpenFinish(slot0)
	slot0.navigationView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_Player_Interface_Close)
end

return slot0
