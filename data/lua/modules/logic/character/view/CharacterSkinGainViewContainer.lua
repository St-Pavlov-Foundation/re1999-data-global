module("modules.logic.character.view.CharacterSkinGainViewContainer", package.seeall)

slot0 = class("CharacterSkinGainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, CharacterSkinGainView.New())

	return slot1
end

return slot0
