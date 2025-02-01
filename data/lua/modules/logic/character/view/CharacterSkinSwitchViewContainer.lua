module("modules.logic.character.view.CharacterSkinSwitchViewContainer", package.seeall)

slot0 = class("CharacterSkinSwitchViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, CharacterSkinSwitchView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btntopleft"))
	table.insert(slot1, CharacterSkinSwitchSpineGCView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		slot0.navigateView
	}
end

function slot0.on(slot0)
	slot0.navigateView:resetOnCloseViewAudio(AudioEnum.UI.UI_role_skin_close)
end

return slot0
