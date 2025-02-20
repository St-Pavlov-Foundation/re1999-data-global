module("modules.logic.tower.view.fight.TowerBossResultViewContainer", package.seeall)

slot0 = class("TowerBossResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TowerBossResultView.New())

	return slot1
end

return slot0
