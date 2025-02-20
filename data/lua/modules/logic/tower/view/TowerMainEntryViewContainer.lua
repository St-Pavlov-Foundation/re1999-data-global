module("modules.logic.tower.view.TowerMainEntryViewContainer", package.seeall)

slot0 = class("TowerMainEntryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TowerMainEntryView.New())

	return slot1
end

return slot0
