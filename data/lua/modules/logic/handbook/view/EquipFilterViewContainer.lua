module("modules.logic.handbook.view.EquipFilterViewContainer", package.seeall)

slot0 = class("EquipFilterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, EquipFilterView.New())

	return slot1
end

return slot0
