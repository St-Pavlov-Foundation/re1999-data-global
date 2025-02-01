module("modules.logic.character.view.CharacterGetViewContainer", package.seeall)

slot0 = class("CharacterGetViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		CharacterGetView.New(),
		CharacterSkinGetDetailView.New()
	}
end

return slot0
