module("modules.logic.character.view.CharacterGuideTalentViewContainer", package.seeall)

slot0 = class("CharacterGuideTalentViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		CharacterGuideTalentView.New()
	}
end

return slot0
