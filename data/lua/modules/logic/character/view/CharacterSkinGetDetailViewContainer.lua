module("modules.logic.character.view.CharacterSkinGetDetailViewContainer", package.seeall)

slot0 = class("CharacterSkinGetDetailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		CharacterSkinGetDetailView.New()
	}
end

return slot0
