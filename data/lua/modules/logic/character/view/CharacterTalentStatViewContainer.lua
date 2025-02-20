module("modules.logic.character.view.CharacterTalentStatViewContainer", package.seeall)

slot0 = class("CharacterTalentStatViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, CharacterTalentStatView.New())

	return slot1
end

return slot0
