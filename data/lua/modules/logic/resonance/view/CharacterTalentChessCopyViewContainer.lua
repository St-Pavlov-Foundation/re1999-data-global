module("modules.logic.resonance.view.CharacterTalentChessCopyViewContainer", package.seeall)

slot0 = class("CharacterTalentChessCopyViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, CharacterTalentChessCopyView.New())

	return slot1
end

return slot0
