module("modules.logic.character.view.CharacterTalentLevelUpPreviewContainer", package.seeall)

slot0 = class("CharacterTalentLevelUpPreviewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		CharacterTalentLevelUpPreview.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
end

return slot0
