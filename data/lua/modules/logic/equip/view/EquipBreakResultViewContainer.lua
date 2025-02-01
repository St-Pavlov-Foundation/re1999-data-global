module("modules.logic.equip.view.EquipBreakResultViewContainer", package.seeall)

slot0 = class("EquipBreakResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		EquipBreakResultView.New()
	}
end

return slot0
