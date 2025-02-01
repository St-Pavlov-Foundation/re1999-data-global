module("modules.logic.playercard.view.PlayerCardCharacterSwitchTipsViewContainer", package.seeall)

slot0 = class("PlayerCardCharacterSwitchTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, PlayerCardCharacterSwitchTipsView.New())

	return slot1
end

return slot0
