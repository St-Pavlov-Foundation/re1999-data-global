module("modules.logic.character.view.CharacterDataUttuViewContainer", package.seeall)

slot0 = class("CharacterDataUttuViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		CharacterDataUttuView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return slot0
