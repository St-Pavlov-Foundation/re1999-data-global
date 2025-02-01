module("modules.logic.equip.view.EquipStrengthenAlertViewContainer", package.seeall)

slot0 = class("EquipStrengthenAlertViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		EquipStrengthenAlertView.New()
	}
end

return slot0
