module("modules.logic.resonance.view.CharacterTalentUseLayoutViewContainer", package.seeall)

slot0 = class("CharacterTalentUseLayoutViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, CharacterTalentUseLayoutView.New())

	return slot1
end

return slot0
