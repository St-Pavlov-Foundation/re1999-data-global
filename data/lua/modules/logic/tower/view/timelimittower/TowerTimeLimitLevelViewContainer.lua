module("modules.logic.tower.view.timelimittower.TowerTimeLimitLevelViewContainer", package.seeall)

slot0 = class("TowerTimeLimitLevelViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.towerTimeLimitLevelInfoView = TowerTimeLimitLevelInfoView.New()

	table.insert(slot1, TowerTimeLimitLevelView.New())
	table.insert(slot1, slot0.towerTimeLimitLevelInfoView)
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.TowerLimit)

		return {
			slot0.navigateView
		}
	end
end

function slot0.getTowerTimeLimitLevelInfoView(slot0)
	return slot0.towerTimeLimitLevelInfoView
end

function slot0.setOverrideCloseClick(slot0, slot1, slot2)
	slot0.navigateView:setOverrideClose(slot1, slot2)
end

return slot0
