module("modules.logic.tower.view.permanenttower.TowerMopUpViewContainer", package.seeall)

slot0 = class("TowerMopUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TowerMopUpView.New())

	return slot1
end

return slot0
