module("modules.logic.character.view.CharacterRankUpResultViewContainer", package.seeall)

slot0 = class("CharacterRankUpResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		CharacterRankUpResultView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		}, 100)
	}
end

return slot0
