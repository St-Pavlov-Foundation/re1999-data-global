module("modules.logic.character.view.CharacterBackpackSearchFilterViewContainer", package.seeall)

slot0 = class("CharacterBackpackSearchFilterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		CharacterBackpackSearchFilterView.New()
	}
end

return slot0
