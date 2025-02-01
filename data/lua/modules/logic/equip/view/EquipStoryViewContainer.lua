module("modules.logic.equip.view.EquipStoryViewContainer", package.seeall)

slot0 = class("EquipStoryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		EquipStoryView.New()
	}
end

return slot0
