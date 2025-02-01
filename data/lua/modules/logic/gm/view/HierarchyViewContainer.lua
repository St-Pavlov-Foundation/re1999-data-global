module("modules.logic.gm.view.HierarchyViewContainer", package.seeall)

slot0 = class("HierarchyViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, HierarchyView.New())

	return slot1
end

return slot0
