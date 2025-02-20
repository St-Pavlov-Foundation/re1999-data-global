module("modules.logic.tower.view.TowerGuideViewContainer", package.seeall)

slot0 = class("TowerGuideViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TowerGuideView.New())

	return slot1
end

return slot0
