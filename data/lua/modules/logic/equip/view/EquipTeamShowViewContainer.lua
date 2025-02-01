module("modules.logic.equip.view.EquipTeamShowViewContainer", package.seeall)

slot0 = class("EquipTeamShowViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		EquipTeamShowView.New()
	}
end

return slot0
