module("modules.logic.settings.view.KeyMapAlertViewContainer", package.seeall)

slot0 = class("KeyMapAlertViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, KeyMapAlertView.New())

	return slot1
end

return slot0
