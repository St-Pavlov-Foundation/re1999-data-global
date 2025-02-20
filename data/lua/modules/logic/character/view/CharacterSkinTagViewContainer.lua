module("modules.logic.character.view.CharacterSkinTagViewContainer", package.seeall)

slot0 = class("CharacterSkinTagViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, CharacterSkinTagView.New())

	return slot1
end

return slot0
