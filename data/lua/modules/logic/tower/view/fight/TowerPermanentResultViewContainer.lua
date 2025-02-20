module("modules.logic.tower.view.fight.TowerPermanentResultViewContainer", package.seeall)

slot0 = class("TowerPermanentResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TowerPermanentResultView.New())

	return slot1
end

return slot0
